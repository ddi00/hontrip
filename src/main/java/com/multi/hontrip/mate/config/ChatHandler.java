package com.multi.hontrip.mate.config;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.multi.hontrip.mate.dto.ChatMessageDTO;
import com.multi.hontrip.mate.dto.ChatSessionInfoDTO;
import com.multi.hontrip.mate.dto.MessageType;
import com.multi.hontrip.mate.service.ChatService;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.io.IOException;
import java.time.LocalDateTime;
import java.util.*;

/**
 * 텍스트 기반 채팅 구현
 */
@Component
@RequiredArgsConstructor
@Slf4j
public class ChatHandler extends TextWebSocketHandler {

    private static List<Map<String, Object>> roomSessionList = new ArrayList<>();   // 웹 소켓 세션 리스트
    private final ObjectMapper objectMapper;
    private final ChatService service;
    /** client 접속 시 호출되는 메서드
     * -  room번호로 세션이 있는지 확인 -> 없으면 추가, 있으면 세션 추가
     * */
    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
        super.afterConnectionEstablished(session);
        //소켓 연결
        boolean flag = false;   //세션에 해당 방이 존재하는지 확인할 flag
        String url = session.getUri().toString();
        log.info("소켓 연결 sessionUrl : " + url);

        // 방 번호 추출
        ChatSessionInfoDTO chatSessionInfoDTO = (ChatSessionInfoDTO) session.getAttributes().get("chatSessionInfoDTO");
        Long roomId = chatSessionInfoDTO.getRoomId();

        // 해당 방 번호의 맵을 찾음
        Optional<Map<String, Object>> existingRoom = roomSessionList.stream()
                .filter(roomSession -> roomId.equals(roomSession.get("roomNumber")))
                .findFirst();

        if (existingRoom.isPresent()) {
            Map<String, Object> room = existingRoom.get();
            // 해당 방이 이미 존재하면 세션을 추가
            room.put(session.getId(), session);
        } else {
            // 해당 방이 존재하지 않으면 새로운 맵을 생성하고 세션을 추가
            Map<String, Object> newRoom = new HashMap<>();
            newRoom.put("roomNumber", roomId);
            newRoom.put(session.getId(), session);
            roomSessionList.add(newRoom);
        }
        log.info(session + " 클라이언트 접속 -> session 추가");
    }
    /** 메세지 전송 시 호출되는 메서드 */
    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

        // 페이로드에서 데이터 가져와 dto로 변환
        String payload = (String)message.getPayload();  // json의 페이로드를 가져와 저장
        log.info("payload : {}",payload);
        ChatMessageDTO chatMessage = objectMapper.readValue(payload,ChatMessageDTO.class);  //페이로드를 메세지DTO로 변환
        log.info("session : {}",chatMessage.toString());

        // 세션에서 내 정보 꺼내기
        ChatSessionInfoDTO chatsessionInfo = (ChatSessionInfoDTO)session.getAttributes().get("chatSessionInfoDTO");   // 내 세션에서 세션 정보 꺼내기
        Long roomId=chatsessionInfo.getRoomId();
        // 같은 채팅방에 있는 맵 가져오기
        Map<String, Object> sameRoomMap = roomSessionList.stream()
                .filter(roomSession -> roomId.equals(roomSession.get("roomNumber")))
                .findFirst()
                .orElse(null);

        //메세지 타입별 내용 정의
        String nickName = "참석자1";
//        String nickName = (String)httpSession.getAttribute("nickName");
        if(chatMessage.getMessageType().equals(MessageType.JOIN)){ // 채팅방 첫 입장
            String welcomeMessage = nickName+"님 반갑습니다. 채팅을 시작합니다.";
            chatMessage.setMessage(welcomeMessage);
        } else if (chatMessage.getMessageType().equals(MessageType.ENTER)) {    // 채팅방 입장
            //채팅방에 접속 여부만 알려주자
            String accessMessage = nickName+"님이 입장하셨습니다.";
            chatMessage.setMessage(accessMessage);
        }
        chatMessage.setRoomId(chatsessionInfo.getRoomId());
        chatMessage.setSenderId(chatsessionInfo.getSenderId());
        chatMessage.setReceiverId(chatsessionInfo.getReceiverId());
        chatMessage.setSendTime(LocalDateTime.now());

       // db에 채팅 내용 저장
        if(!chatMessage.getMessageType().equals(MessageType.ENTER)){    //입장은 내용을 별도 저장하지 않음
            service.saveChatContent(chatMessage);
        }

        // 전달할 내용
        TextMessage textMessage = new TextMessage("["+chatMessage.getRoomId() + "]["+chatMessage.getMessageType()+"][" + chatMessage.getSenderId()+"]["+chatMessage.getSendTime()+"]["+chatMessage.getMessage()+"]");

        // 나랑 같은 방에 있는 세션들에게 메세지 보내기
        if (sameRoomMap != null) {
            sameRoomMap.values().stream()
                    .filter(value -> value instanceof WebSocketSession)
                    .map(value -> (WebSocketSession) value)
                    .forEach(roomSession -> {
                        try {
                            roomSession.sendMessage(textMessage);
                        } catch (IOException e) {
                            e.printStackTrace();
                        }
                    });
        }
    }
    /** client 접속종료 시 호출되는 메서드
     * - db에 내 최종 접속일자 변경
     * - 방에서 현재 내 세션 제거
     * */
    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        super.afterConnectionClosed(session, status);
        // 세션에서 내 정보 꺼내기
        ChatSessionInfoDTO chatsessionInfo = (ChatSessionInfoDTO) session.getAttributes().get("chatSessionInfoDTO");   // 내 세션에서 세션 정보 꺼내기
        Long roomId = chatsessionInfo.getRoomId();
        Long userId = chatsessionInfo.getSenderId();

        //DB에서 마지막 접속시간 udpate
        service.updateLastJoinAt(userId,roomId);

        // 소켓 종료 시 해당 세션만 제거
        Optional<Map<String, Object>> roomOptional = roomSessionList.stream()
                .filter(room -> roomId.equals(room.get("roomNumber")))
                .findFirst();

        if (roomOptional.isPresent()) {
            Map<String, Object> room = roomOptional.get();
            room.remove(session.getId());
        }
        log.info(session + " 클라이언트 접속 해제 -> session 제거 완료");
    }
}
