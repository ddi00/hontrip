package com.multi.hontrip.mate.controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import com.multi.hontrip.mate.dto.*;
import com.multi.hontrip.mate.service.ChatService;
import lombok.RequiredArgsConstructor;
import org.springframework.messaging.handler.annotation.MessageMapping;
import org.springframework.messaging.simp.SimpMessageSendingOperations;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/mate")
public class ChatController {
    private final ChatService chatService;
    private final SimpMessageSendingOperations simpMessageSendingOperations;

    @MessageMapping("/mate/chat") //app/mate/chat <- pub
    public void send(ChatMessageDTO chatMessageDTO) throws Exception {
        chatMessageDTO.setSendTime(LocalDateTime.now());
        if (chatMessageDTO.getMessageType() == MessageType.JOIN) {
            chatMessageDTO.setMessage(chatMessageDTO.getSenderNickname() + "님이 들어왔습니다");
        } else if (chatMessageDTO.getMessageType().equals("LEAVE")) {
            chatMessageDTO.setMessage(chatMessageDTO.getSenderNickname() + "님이 나갔습니다");
        }
        chatService.saveChatContent(chatMessageDTO);
        simpMessageSendingOperations.convertAndSend("/topic/chat/roomId/" + chatMessageDTO.getRoomId(), chatMessageDTO);
    }

    @PostMapping("/create-chatroom")    //form으로 보낼때는 requestBody 쓰지 마시오
    public ChatInfoDTO createChatRoom(ChatInfoDTO chatInfoDTO) { // 채팅방 새로 생성하기(post소유주만 가능)  : 채팅 후 환영인사까지 하기 위해
        chatInfoDTO.setRoomId(chatService.createRoom(chatInfoDTO));
        return chatInfoDTO;
    }

    @PostMapping("/chat-room-list")
    public List<ChatroomListDTO> findAllRooms(HttpSession session) {
        Long id = (Long) session.getAttribute("id");
        List<ChatroomListDTO> chatRoomDTOList = chatService.getChatListById(id);

        return chatRoomDTOList;
    }


/*
    @PostMapping("/create-chatroom")    //form으로 보낼때는 requestBody 쓰지 마시오
    public ModelAndView createChatRoom(ChatInfoDTO chatInfoDTO, ModelAndView modelAndView) { // 채팅방 새로 생성하기(post소유주만 가능)  : 채팅 후 환영인사까지 하기 위해
        Long roomId = chatService.getChatRoomIdByPostIdAndGuestID(chatInfoDTO);
        if (roomId == null) {
            ChatSessionInfoDTO chatSessionInfoDTO = chatService.createRoom(chatInfoDTO);
            chatSessionInfoDTO.setChatRoomName(chatInfoDTO.getChatRoomName());
            modelAndView.addObject("chatSessionInfo",chatSessionInfoDTO);
            modelAndView.setViewName("/mate/chatroom-view");   //바로 뷰로 넘김
        } else {    //이미 존재하는 방이면
            modelAndView.setViewName("redirect:/mate/join-chat/"+roomId+"?user_id="+chatInfoDTO.getOwnerId());
        }
        return modelAndView;
    }

     @PostMapping("my-chat-list")
    public List<ChatSessionInfoDTO> findAllRooms(HttpSession session) { // 내 채팅방 리스트 전체 가져오기
        Long id = (Long) session.getAttribute("id");
        List<ChatSessionInfoDTO> chatRoomDTOList = chatService.getChatListById(id);
        return chatRoomDTOList;
    }

    @GetMapping("/chat-view")
    public ModelAndView chatPage(ModelAndView modelAndView) {
        modelAndView.setViewName("/mate/chat-view");
        return modelAndView;
    }
*/


    @GetMapping("/join-chat/{roomId}")
    public JoinChatInfo joinChat(@PathVariable("roomId") Long roomId,
                                 @RequestParam("user_id") Long userId) {
        // TODO 원래 session정보에서 sender를 가져와야 하나 지금은 Query로 가져옴
        // 쳇방 정보를 가져와야함
        ChatroomRequestDTO chatroomRequestDTO = ChatroomRequestDTO.builder()
                .roomId(roomId)
                .senderId(userId)
                .build();
        // 이전 쳇정보를 가져와야 함
        JoinChatInfo joinChatInfo = chatService.getChatRoomInfoByRoomIdAndUserId(chatroomRequestDTO);
        return joinChatInfo;
    }

    @GetMapping("/update_last_join_at")
    public void updateLastJoinAt(long userId, long roomId) {
        chatService.updateLastJoinAt(userId, roomId);
    }

    @GetMapping("/owner_check")
    public ChatOwnerAcceptedDTO getIsOwnerIsAcceptedByRoomIdAndUserId(long roomId, long userId) {
        return chatService.getIsOwnerIsAcceptedByRoomIdAndUserId(roomId, userId);
    }

    @GetMapping("/accept_matching_application")
    public void acceptMatchingApplication(long roomId) {
        chatService.acceptMatchingApplication(roomId);
    }

    @GetMapping(value = "/guest_nickname", produces = "application/json; charset=utf8")
    public String getGuestNicknameByRoomId(long roomId) {
        JsonObject guestNickname = new JsonObject();
        guestNickname.addProperty("nickname", chatService.getGuestNicknameByRoomId(roomId));
        return new Gson().toJson(guestNickname);
    }
}
