package com.bit.bnb.chatting.dao;

import com.bit.bnb.chatting.model.AllMessageVO;
import com.bit.bnb.chatting.model.ChatRoomVO;
import com.bit.bnb.chatting.model.MessageVO;
import com.bit.bnb.rooms.model.RoomsVO;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.List;

@Repository
public class ChatDAO {

    @Autowired
    private SqlSessionTemplate sqlSessionTemplate;

    private static String namespace="mappers.chatMapper.";

    public void createRoom (MessageVO vo) throws Exception{
        System.out.println("creatRoom 메서드");
        sqlSessionTemplate.insert(namespace+"createRoom", vo);
        System.out.println("creatRoom 완료");
    }

    public ChatRoomVO isRoom(ChatRoomVO vo) throws Exception{

        ChatRoomVO roomVO = null;
        roomVO=sqlSessionTemplate.selectOne(namespace+"isRoom",vo);
        return roomVO;

    }

    public void insertMessage(MessageVO vo) throws Exception{
        sqlSessionTemplate.insert(namespace+"insertMessage",vo);
    }

    public String getPartner(ChatRoomVO vo) throws Exception {

        List<MessageVO> voList =sqlSessionTemplate.selectList(namespace+"getPartner", vo);
        return voList.get(0).getUserId();
    }

    public String getProfile(String str) throws Exception {
        return sqlSessionTemplate.selectOne(namespace+"getProfile" , str);
    }



    public String getName(String str) throws Exception {

        return sqlSessionTemplate.selectOne(namespace+"getName" , str);
    }



    public List<MessageVO> getMessageList(ChatRoomVO roomsVO) throws Exception {
        return sqlSessionTemplate.selectList(namespace+"getMessageList" , roomsVO);


    }


    public List<ChatRoomVO> getRoomList(String str) throws Exception {
        return sqlSessionTemplate.selectList(namespace+"getRoomList",str);
    }


    public List<MessageVO> newChatCK(String userId){
        return sqlSessionTemplate.selectList(namespace+"newChatCK", userId);
    }

    public void readOkUpdate(ChatRoomVO roomVO){
        sqlSessionTemplate.update(namespace+"readOkUpdate", roomVO);
    }

    public List<ChatRoomVO> getAllRoomList(String str) throws Exception {
        return sqlSessionTemplate.selectList(namespace+"getAllRoomList",str);
    }

    public List<MessageVO> UnreadMessageList(String userId){
        return sqlSessionTemplate.selectList(namespace+"UnreadMessageList",userId);
    }




    public List<ChatRoomVO> getRoomList2(String str) throws Exception {
        // TODO Auto-generated method stub
        return sqlSessionTemplate.selectList(namespace+"getRoomList2" , str);
    }


    public MessageVO getRecentMessage(String str) throws Exception {
        // TODO Auto-generated method stub
        return sqlSessionTemplate.selectOne(namespace+"getRecentMessage" , str);
    }

    public String getTutorId(String str) throws Exception {
        // TODO Auto-generated method stub
        return sqlSessionTemplate.selectOne(namespace+"getTutorId" , str) ;
    }

    public List<ChatRoomVO> getRoomListTutor(String str) throws Exception {
        // TODO Auto-generated method stub
        return sqlSessionTemplate.selectList(namespace+"getRoomListTutor" , str);
    }

    public void updateReadTime(int class_id, String user_id, String TUTOR_USER_user_id) throws Exception {
        // TODO Auto-generated method stub

        HashMap<String, Object> map = new HashMap<String, Object> ();

        map.put("TUTOR_USER_user_id", TUTOR_USER_user_id);
        map.put("USER_user_id", user_id);
        map.put("CLASS_class_id", class_id);
        sqlSessionTemplate.update(namespace+"updateReadTime" , map);
    }


    public int getUnReadCount(String TUTOR_USER_user_id, int class_id, String user_id) throws Exception {
        // TODO Auto-generated method stub
        HashMap<String, Object> map = new HashMap<String, Object> ();

        map.put("TUTOR_USER_user_id", TUTOR_USER_user_id);
        map.put("USER_user_id", user_id);
        map.put("CLASS_class_id", class_id);


        return sqlSessionTemplate.selectOne(namespace+"getUnReadCount" , map);
    }

    public int getAllCount(String str) {
        // TODO Auto-generated method stub
        HashMap<String, Object> map = new HashMap<String, Object> ();

        map.put("USER_user_id", str);
        map.put("TUTOR_USER_user_id", str);
        if(sqlSessionTemplate.selectOne(namespace+"getAllCount" ,map) ==null) {
            return 0;
        }else {

            return sqlSessionTemplate.selectOne(namespace+"getAllCount" ,map);
        }

    }

    public void updateReadTimeTutor(int class_id , String user_id , String TUTOR_USER_user_id) throws Exception {
        // TODO Auto-generated method stub
        HashMap<String, Object> map = new HashMap<String, Object> ();

        map.put("TUTOR_USER_user_id", TUTOR_USER_user_id);
        map.put("USER_user_id", user_id);
        map.put("CLASS_class_id", class_id);
        sqlSessionTemplate.update(namespace+"updateReadTimeTutor" , map);
    }




    public int getUnReadCountTutor(String TUTOR_USER_user_id, int class_id, String user_id) throws Exception {
        // TODO Auto-generated method stub
        HashMap<String, Object> map = new HashMap<String, Object> ();

        map.put("TUTOR_USER_user_id", TUTOR_USER_user_id);
        map.put("USER_user_id", user_id);
        map.put("CLASS_class_id", class_id);


        return sqlSessionTemplate.selectOne(namespace+"getUnReadCountTutor" , map);
    }

    public List<AllMessageVO> devMessageList (){

        return sqlSessionTemplate.selectList(namespace+"devMessageList");
    }
    public void allMessageinsert(AllMessageVO vo){
       sqlSessionTemplate.insert(namespace+"allMessageinsert",vo);
    }



}
