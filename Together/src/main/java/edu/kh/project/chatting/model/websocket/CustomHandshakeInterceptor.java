package edu.kh.project.chatting.model.websocket;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.server.ServerHttpRequest;
import org.springframework.http.server.ServerHttpResponse;
import org.springframework.web.socket.WebSocketHandler;
import org.springframework.web.socket.server.support.HttpSessionHandshakeInterceptor;
import org.springframework.http.server.ServletServerHttpRequest;

public class CustomHandshakeInterceptor extends HttpSessionHandshakeInterceptor {

    @Override
    public boolean beforeHandshake(ServerHttpRequest request, ServerHttpResponse response,
                                   WebSocketHandler wsHandler, Map<String, Object> attributes) throws Exception {

        // HttpServletRequest 꺼내기
        HttpServletRequest servletRequest = ((ServletServerHttpRequest) request).getServletRequest();

        // roomNo 가져오기
        String roomNo = servletRequest.getParameter("roomNo");

        if (roomNo != null) {
            attributes.put("roomNo", roomNo); // WebSocketSession에 저장됨
        }

        // 기존 세션(loginMember 등)도 복사
        return super.beforeHandshake(request, response, wsHandler, attributes);
    }
}