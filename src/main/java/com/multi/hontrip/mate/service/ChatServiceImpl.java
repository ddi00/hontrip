package com.multi.hontrip.mate.service;

import com.multi.hontrip.mate.dao.ChatDAO;
import com.multi.hontrip.mate.dto.*;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class ChatServiceImpl implements ChatService{

    public final ChatDAO chatDAO;
/*
    @Override
    public ChatSessionInfoDTO createRoom(ChatInfoDTO chatInfoDTO) {    //신규 채팅방 생성
        //DB에 채팅방 정보 저장 - ID를 받아야 함
        Long chatRoomId = chatDAO.insertChatRoom(chatInfoDTO);
        //chatRoom셋팅해서 반환
        return ChatSessionInfoDTO.builder()
                .roomId(chatRoomId)
                .senderId(chatInfoDTO.getOwnerId())
                .receiverId(chatInfoDTO.getGuestId())
                .build();
    }
    */

    @Override
    public long createRoom(ChatInfoDTO chatInfoDTO) {    //신규 채팅방 생성
        //DB에 채팅방 정보 저장 - ID를 받아야 함
        return chatDAO.insertChatRoom(chatInfoDTO);
    }


    @Override
    public List<ChatroomListDTO> getChatListById(Long id) {
        //db에서 사용자 id가 포함된 ChatRoom 전부 가져오기
        return chatDAO.getChatRoomListById(id);
    }

    @Override
    public void saveChatContent(ChatMessageDTO chatMessage) {
        chatDAO.insertChatMessage(chatMessage);
    }
    @Override
    public void updateLastJoinAt(Long userId, Long roomId) {
        chatDAO.updateLastJoinAt(userId, roomId);
    }

    @Override
    public Long getChatRoomIdByPostIdAndGuestID(ChatInfoDTO chatInfoDTO) {
        return chatDAO.getChatRoomIdByPostIdAndGuestID(chatInfoDTO);
    }

    @Override
    public JoinChatInfo getChatRoomInfoByRoomIdAndUserId(ChatroomRequestDTO chatroomRequestDTO) {
        return chatDAO.getChatRoomInfoByRoomIdAndUserId(chatroomRequestDTO);
    }

    @Override
    public ChatOwnerAcceptedDTO getIsOwnerIsAcceptedByRoomIdAndUserId(long roomId, long userId) {
        return chatDAO.getIsOwnerIsAcceptedByRoomIdAndUserId(roomId, userId);
    }

    @Override
    public void acceptMatchingApplication(long roomId) {
        chatDAO.acceptMatchingApplication(roomId);
    }

    @Override
    public String getGuestNicknameByRoomId(long roomId) {
        return chatDAO.getGuestNicknameByRoomId(roomId);
    }
}

