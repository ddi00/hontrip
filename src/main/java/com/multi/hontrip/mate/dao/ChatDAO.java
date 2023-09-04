package com.multi.hontrip.mate.dao;

import com.multi.hontrip.mate.dto.*;
import lombok.RequiredArgsConstructor;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
@RequiredArgsConstructor
public class ChatDAO {

    private final SqlSessionTemplate sessionTemplate;

    @Transactional
    public Long insertChatRoom(ChatInfoDTO chatInfoDTO) {   //챗방 만들기
        // 챗방 만들기
        sessionTemplate.insert("chatMapper.insertChatroom", chatInfoDTO);
        //사용자 채팅 정보 만들기 - owner꺼 guest꺼 2개 생성 -> owner id를 가져와야 함
        sessionTemplate.insert("chatMapper.insertOwnerChatroom", chatInfoDTO);
        sessionTemplate.insert("chatMapper.insertGuestChatroom", chatInfoDTO);
        return chatInfoDTO.getRoomId();
    }

    public List<ChatroomListDTO> getChatRoomListById(Long id) { //내 아이디가 포함된 챗 리스트 가져오기
        return sessionTemplate.selectList("chatMapper.getChatRoomListById", id);
    }

    @Transactional
    public void insertChatMessage(ChatMessageDTO chatMessage) {

        //메세지 테이블에 저장
        sessionTemplate.insert("chatMapper.insertChatMessage", chatMessage);

        //chatRoom에 lastChatId 넣어주기
        Long lastMessageId=sessionTemplate.selectOne("chatMapper.getLastChatIdByRoomId",chatMessage.getRoomId());
        if (lastMessageId < chatMessage.getMessageId()) {   // 혹시 메세지가 lastmessageid보다 작으면 넣지 않아야함 -> 그럴 일 없어보이긴 함
            sessionTemplate.update("chatMapper.updateLastChatIdByRoomId", chatMessage);
        }

        //사용자별 채팅정보 업데이트
        sessionTemplate.update("chatMapper.updateSenderChatroom", chatMessage);
        sessionTemplate.update("chatMapper.updateReceiverChatroom", chatMessage);
    }


    public void updateLastJoinAt(Long userId, Long roomId) {
        Map<String, Long> params = new HashMap<>();
        params.put("userId", userId);
        params.put("roomId", roomId);
        sessionTemplate.update("chatMapper.updateLastJoinAt", params);
    }


    public Long getChatRoomIdByPostIdAndGuestID(ChatInfoDTO chatInfoDTO) {
        return sessionTemplate.selectOne("chatMapper.selectRoomIdByPostIdAndGuestID", chatInfoDTO);
    }

    @Transactional
    public JoinChatInfo getChatRoomInfoByRoomIdAndUserId(ChatroomRequestDTO chatroomRequestDTO) {
        //채팅 타이틀 가져와야 함
        String roomTitle = sessionTemplate.selectOne("chatMapper.selectRoomInfoByRoomId", chatroomRequestDTO);
        //receiver id 가져오기
        Long receiverId = sessionTemplate.selectOne("chatMapper.selectReceiverIdByRoomIdAndSenderId",chatroomRequestDTO);
        //이전 메세지 전부 가져오기
        List<ChatMessageDTO> chatMessageDTOS = sessionTemplate.selectList("chatMapper.selectMessageListByRoomId",chatroomRequestDTO);
        //새로 들어온 것인지? - chatMessageDTOS에서 sender에 본인 아이디가 없으면 new
        boolean newFlag = !chatMessageDTOS.stream()
                .anyMatch(chatMessageDTO -> chatMessageDTO.getSenderId() == chatroomRequestDTO.getSenderId());

        return JoinChatInfo.builder()
                .roomId(chatroomRequestDTO.getRoomId())
                .chatRoomName(roomTitle)
                .senderId(chatroomRequestDTO.getSenderId())
                .receiverId(receiverId)
                .chatMessages(chatMessageDTOS)
                .newFlag(newFlag)
                .build();
    }

    public ChatOwnerAcceptedDTO getIsOwnerIsAcceptedByRoomIdAndUserId(long roomId, long userId) {
        Map<String, Long> params = new HashMap<>();
        params.put("userId", userId);
        params.put("roomId", roomId);
        return sessionTemplate.selectOne("chatMapper.getIsOwnerIsAcceptedByRoomIdAndUserId", params);
    }

    public void acceptMatchingApplication(long roomId) {
        sessionTemplate.update("chatMapper.acceptMatchingApplication", roomId);
    }

    public String getGuestNicknameByRoomId(long roomId) {
        return sessionTemplate.selectOne("chatMapper.getGuestNicknameByRoomId", roomId);
    }
}