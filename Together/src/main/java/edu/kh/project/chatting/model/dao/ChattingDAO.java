package edu.kh.project.chatting.model.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import edu.kh.project.chatting.model.dto.ChatEmoji;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.member.model.dto.Member;

@Repository
public class ChattingDAO {

    @Autowired
    private SqlSessionTemplate sqlSession;

    public List<ChattingRoom> getChattingList(int memberNo) {
        return sqlSession.selectList("chattingMapper.getChattingList", memberNo);
    }

    public List<Message> selectMessageList(Map<String, Object> paramMap) {
        return sqlSession.selectList("chattingMapper.selectMessageList", paramMap);
    }

    public List<Object> selectChatTarget(int roomNo, int memberNo) {
        Map<String, Object> paramMap = new HashMap<>();
        paramMap.put("roomNo", roomNo);
        paramMap.put("loginMemberNo", memberNo);
        return sqlSession.selectList("chattingMapper.selectChatTarget", paramMap);
    }

    public int deleteRoom(int roomNo) {
        return sqlSession.update("chattingMapper.deleteRoom", roomNo);
    }

    public int selectOwnerNo(int roomNo) {
        return sqlSession.selectOne("chattingMapper.selectOwnerNo", roomNo);
    }

    public int insertMessage(Message msg) {
        return sqlSession.insert("chattingMapper.insertMessage", msg);
    }

    public int insertImageMessage(Message msg) {
        return sqlSession.insert("chattingMapper.insertImageMessage", msg);
    }

    public void insertChatImage(Image img) {
        sqlSession.insert("chattingMapper.insertChatImage", img);
    }

    public List<ChatEmoji> selectBigEmojiList() {
        return sqlSession.selectList("chattingMapper.selectBigEmojiList");
    }

    public int createGroupChatRoom(Map<String, Object> map) {
        return sqlSession.insert("chattingMapper.createGroupChatRoom", map);
    }

    public void insertChatRoomUser(int roomNo, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("roomNo", roomNo);
        map.put("memberNo", memberNo);
        sqlSession.insert("chattingMapper.insertChatRoomUser", map);
    }

    public void deleteRoomUsers(int roomNo, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("roomNo", roomNo);
        map.put("memberNo", memberNo);
        sqlSession.delete("chattingMapper.deleteRoomUsers", map);
    }

    public String selectBoardTitle(int recruitmentNo) {
        return sqlSession.selectOne("chattingMapper.selectBoardTitle", recruitmentNo);
    }

    public int selectRoomNoByRoomName(String roomName) {
        return sqlSession.selectOne("chattingMapper.selectRoomNoByRoomName", roomName);
    }

    public void deleteChatRoomUser(int roomNo, int memberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("roomNo", roomNo);
        map.put("memberNo", memberNo);
        sqlSession.delete("chattingMapper.deleteChatRoomUser", map);
    }

    public List<Member> selectRoomMemberList(int roomNo) {
        return sqlSession.selectList("chattingMapper.selectRoomMemberList", roomNo);
    }

    public ChattingRoom selectRoomName(int roomNo) {
        return sqlSession.selectOne("chattingMapper.selectRoomName", roomNo);
    }

    public int kickMemberFromRoom(int roomNo, int targetMemberNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("roomNo", roomNo);
        map.put("memberNo", targetMemberNo);
        return sqlSession.delete("chattingMapper.kickMemberFromRoom", map);
    }

    public int insertPrivateChatRoom(Map<String, Object> map) {
        int result = sqlSession.insert("chattingMapper.insertPrivateChatRoom", map);
        if (result > 0) {
            return (int) map.get("roomNo");
        }
        return 0;
    }

    public Integer checkPrivateRoom(int myMemberNo, int targetMemberNo) {
        Map<String, Integer> map = new HashMap<>();
        map.put("myMemberNo", myMemberNo);
        map.put("targetMemberNo", targetMemberNo);
        return sqlSession.selectOne("chattingMapper.checkPrivateRoom", map);
    }

    public int checkDuplicateGroupChatRoom(String roomName, int ownerNo) {
        Map<String, Object> map = new HashMap<>();
        map.put("roomName", roomName);
        map.put("ownerNo", ownerNo);
        return sqlSession.selectOne("chattingMapper.checkDuplicateGroupChatRoom", map);
    }

} 
