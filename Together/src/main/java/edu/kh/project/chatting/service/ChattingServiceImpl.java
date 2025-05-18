package edu.kh.project.chatting.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.kh.project.chatting.model.dao.ChattingDAO;
import edu.kh.project.chatting.model.dto.ChatEmoji;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.common.utility.Utill;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.member.model.dto.Member;

@Service
public class ChattingServiceImpl implements ChattingService{

	@Autowired
	private ChattingDAO dao;

	@Override
	public List<ChattingRoom> getChattingList(int memberNo) {
		return dao.getChattingList(memberNo);
	}

	@Override
	public List<Message> selectMessageList(Map<String, Object> paramMap) {
		return dao.selectMessageList(paramMap);
	}

	@Override
	public List<Object> selectChatTarget(int roomNo, int memberNo) {
		return dao.selectChatTarget(roomNo, memberNo);
	}

	@Override
	public int deleteRoom(int roomNo, int memberNo) {
		dao.deleteRoomUsers(roomNo, memberNo);
		return dao.deleteRoom(roomNo);
	}

	@Override
	public int selectOwnerNo(int roomNo) {
		return dao.selectOwnerNo(roomNo);
	}

	@Override
	public int insertMessage(Message msg) {
		msg.setMessageContent(Utill.XSSHandling(msg.getMessageContent()));
		return dao.insertMessage(msg);
	}

	@Override
	public int insertImageMessage(Message msg) {
		return dao.insertImageMessage(msg);
	}

	@Override
	public void insertChatImage(Image img) {
		dao.insertChatImage(img);
	}

	@Override
	public List<ChatEmoji> getBigEmojiList() {
		return dao.selectBigEmojiList();
	}

	@Override
	public int createGroupChatRoom(String roomName, int ownerNo, Map<String, Object> outMap) {
		String finalRoomName = roomName;
		int count = 0;

		while (dao.checkDuplicateGroupChatRoom(finalRoomName, ownerNo) > 0) {
			count++;
			finalRoomName = roomName + "_" + ((int)(Math.random() * 1000) + count);
			if (count > 20) break;
		}

		outMap.put("roomName", finalRoomName);

		Map<String, Object> map = new HashMap<>();
		map.put("roomName", finalRoomName);
		map.put("ownerNo", ownerNo);

		int result = dao.createGroupChatRoom(map);

		if (result > 0) {
			int roomNo = (int) map.get("roomNo");
			dao.insertChatRoomUser(roomNo, ownerNo);
		}

		return result;
	}

	@Override
	public String selectRecruitmentTitle(int recruitmentNo) {
		return dao.selectBoardTitle (recruitmentNo);
	}

	@Override
	public int selectRoomNoByRoomName(String roomName) {
		return dao.selectRoomNoByRoomName(roomName);
	}

	@Override
	public void insertChatRoomUser(int roomNo, int memberNo) {
		dao.insertChatRoomUser(roomNo, memberNo);
	}

	@Override
	public void deleteChatRoomUser(int roomNo, int memberNo) {
		dao.deleteChatRoomUser(roomNo, memberNo);
	}

	@Override
	public List<Member> selectRoomMemberList(int roomNo) {
		return dao.selectRoomMemberList(roomNo);
	}

	@Override
	public ChattingRoom selectRoomName(int roomNo) {
		return dao.selectRoomName(roomNo);
	}

	@Override
	@Transactional(rollbackFor = Exception.class)
	public int kickMemberFromRoom(int roomNo, int targetMemberNo) {
		return dao.kickMemberFromRoom(roomNo, targetMemberNo);
	}

	@Override
	@Transactional
	public Map<String, Object> createOrGetPrivateChatRoom(int myMemberNo, int targetMemberNo, String roomName) {
		Map<String, Object> result = new HashMap<>();
		Integer existingRoomNo = dao.checkPrivateRoom(myMemberNo, targetMemberNo);
		if (existingRoomNo != null) {
			result.put("roomNo", existingRoomNo);
			result.put("isNew", false);
			return result;
		}

		Map<String, Object> map = new HashMap<>();
		map.put("myMemberNo", myMemberNo);
		map.put("targetMemberNo", targetMemberNo);
		map.put("roomName", roomName);

		int roomNo = dao.insertPrivateChatRoom(map);
		if (roomNo == 0) throw new RuntimeException("채팅방 생성 실패");

		dao.insertChatRoomUser(roomNo, myMemberNo);
		dao.insertChatRoomUser(roomNo, targetMemberNo);

		result.put("roomNo", roomNo);
		result.put("isNew", true);
		return result;
	}
}
