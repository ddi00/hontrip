package com.multi.hontrip.mate.config;

import com.multi.hontrip.mate.dto.ChatSessionInfoDTO;
import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.HandshakeInterceptor;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

public class ChattingHandShakeInterceptor implements HandshakeInterceptor {
    @Override
    public boolean beforeHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Map<String, Object> map) throws Exception {

        String path = serverHttpRequest.getURI().getPath();
        String query = serverHttpRequest.getURI().getQuery();
        String roomId = path.substring(path.lastIndexOf('/') + 1);

        // 쿼리 문자열 파싱 - 쿼리 문자열을 &로 분리하고, 각 키-값 쌍을 파싱하여 Map으로 변환
        Map<String, String> queryMap = Arrays.stream(query.split("&"))
                .map(param -> param.split("="))
                .collect(Collectors.toMap(
                        param -> param[0], // 키
                        param -> param[1]  // 값
                ));
        String senderId = queryMap.get("senderId");
        String receiverId = queryMap.get("receiverId");

        // 세션 어트리뷰트로 추가
        ChatSessionInfoDTO chatSessionInfoDTO = ChatSessionInfoDTO.builder()
                .roomId(Long.parseLong(roomId))
                .senderId(Long.parseLong(senderId))
                .receiverId(Long.parseLong(receiverId))
                .build();

        map.put("chatSessionInfoDTO", chatSessionInfoDTO);
        return true;
    }

    @Override
    public void afterHandshake(ServerHttpRequest serverHttpRequest, ServerHttpResponse serverHttpResponse, WebSocketHandler webSocketHandler, Exception e) {

    }
}
