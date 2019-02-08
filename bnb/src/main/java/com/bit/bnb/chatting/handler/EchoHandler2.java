package com.bit.bnb.chatting.handler;

import com.bit.bnb.chatting.dao.ChatDAO;
import com.bit.bnb.chatting.model.AllMessageVO;
import com.bit.bnb.chatting.model.ChatRoomVO;
import com.bit.bnb.chatting.model.MessageVO;
import com.bit.bnb.chatting.service.MakeChatRoomService;
import com.bit.bnb.user.model.UserVO;
import com.google.gson.Gson;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class EchoHandler2 extends TextWebSocketHandler {

    @Autowired
    private ChatDAO dao;

    @Autowired
    private MakeChatRoomService makeChatRoomService;

    private List<WebSocketSession> connectedUsers;

    public EchoHandler2(){
        connectedUsers = new ArrayList<WebSocketSession>();
    }

    private Map<String,WebSocketSession> users = new ConcurrentHashMap<String, WebSocketSession>();

    @Override
    public void afterConnectionEstablished(WebSocketSession session) throws Exception {
            users.put(session.getId(),session);
            connectedUsers.add(session);
    }

    @Override
    public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {
        connectedUsers.remove(session);
        users.remove(session.getId());

    }

    @Override
    protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {
        System.out.println(message.getPayload());
        Map<String, Object> map = null;

        AllMessageVO messageVO = AllMessageVO.convertMessage(message.getPayload());

        System.out.println("1 : " + messageVO.toString());

            dao.allMessageinsert(messageVO);




        for (WebSocketSession websocketSession : connectedUsers) {
            map = websocketSession.getAttributes();
                Gson gson = new Gson();
                String msgJson = gson.toJson(messageVO);
                websocketSession.sendMessage(new TextMessage(msgJson));
            }


        }

}
