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

	// 채팅방 목록 조회
	@Override
	public List<ChattingRoom> getChattingList(int memberNo) {
		return dao.getChattingList(memberNo);
	}

	// 채팅 메세지 조회
	@Override
	public List<Message> selectMessageList(Map<String, Object> paramMap) {
		return dao.selectMessageList(paramMap);
	}

	// 상대 프로필
	@Override
	public List<Object> selectChatTarget(int roomNo, int memberNo) {
		return dao.selectChatTarget(roomNo, memberNo);
	}

	// 채팅방 삭제
	@Override
	public int deleteRoom(int roomNo, int memberNo) {
		// 1. 방에 속한 사용자 삭제
	    dao.deleteRoomUsers(roomNo, memberNo);
	    
		 return dao.deleteRoom(roomNo);
	}

	// 채팅방 주인 확인
	@Override
	public int selectOwnerNo(int roomNo) {
		return dao.selectOwnerNo(roomNo);
	}

	// 메세지 입력
	@Override
	public int insertMessage(Message msg) {
		msg.setMessageContent(Utill.XSSHandling(msg.getMessageContent()));
		return dao.insertMessage(msg);
	}

	// 메세지 이미지 입력
	@Override
	public int insertImageMessage(Message msg) {
		return dao.insertImageMessage(msg);
	}

	// 메세지 이미지 입력
	@Override
	public void insertChatImage(Image img) {
		dao.insertChatImage(img);
	}

	// 메세지 큰 이모지 조회
	@Override
	public List<ChatEmoji> getBigEmojiList() {
		return dao.selectBigEmojiList();
	}

	// 모집하기 방 생성 시 채팅방 생성
	@Override
	public int createGroupChatRoom(String roomName, int ownerNo, Map<String, Object> outMap) {
		String finalRoomName = roomName;
	    int count = 0;

	    // 중복이 존재하는 한 반복
	    while (dao.checkDuplicateGroupChatRoom(finalRoomName, ownerNo) > 0) {
	        count++;
	        finalRoomName = roomName + "_" + ((int)(Math.random() * 1000) + count);
	        if (count > 20) break; 
	    }
	    
	    outMap.put("roomName", finalRoomName);

	    Map<String, Object> map = new HashMap<>();
	    map.put("roomName", roomName);
	    map.put("ownerNo", ownerNo);

	    int result = dao.createGroupChatRoom(map);

	    if (result > 0) {
	        int roomNo = (int) map.get("roomNo");
	        dao.insertChatRoomUser(roomNo, ownerNo); 
	    }

	    return result;
	}

	// 참가하기 시 채팅방 참여(roomName 조회)
	@Override
	public String selectBoardTitle(int boardNo) {
		return dao.selectBoardTitle(boardNo);
	}

	// 참가하기 시 채팅방 참여(roomNo 조회)
	@Override
	public int selectRoomNoByRoomName(String roomName) {
		return dao.selectRoomNoByRoomName(roomName);
	}

	// 참가하기 시 채팅방 참여(user insert)
	@Override
	public void insertChatRoomUser(int roomNo, int memberNo) {
		dao.insertChatRoomUser(roomNo, memberNo);
	}

	// 방 나가기
	@Override
	public void deleteChatRoomUser(int roomNo, int memberNo) {
		dao.deleteChatRoomUser(roomNo, memberNo);
	}

	// 채팅방 참가자 조회
	@Override
	public List<Member> selectRoomMemberList(int roomNo) {
		return dao.selectRoomMemberList(roomNo);
	}

	// 채팅방 이름
	@Override
	public ChattingRoom selectRoomName(int roomNo) {
	    return dao.selectRoomName(roomNo);
	}

	// 채팅방 추방
	@Override
	@Transactional(rollbackFor = Exception.class)
	public int kickMemberFromRoom(int roomNo, int targetMemberNo) {
		return dao.kickMemberFromRoom(roomNo, targetMemberNo);
	}

	// 1대1 채팅
	@Override
	@Transactional
	public Map<String, Object> createOrGetPrivateChatRoom(int myMemberNo, int targetMemberNo, String roomName) {
		Map<String, Object> result = new HashMap<>();
		// 기존 채팅방 존재 여부 확인
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
	    // 새 채팅방 생성
	    int roomNo = dao.insertPrivateChatRoom(map);
	    if (roomNo == 0) throw new RuntimeException("채팅방 생성 실패");


	    // 참가자 추가
	    dao.insertChatRoomUser(roomNo, myMemberNo);
	    dao.insertChatRoomUser(roomNo, targetMemberNo);

	    result.put("roomNo", roomNo);
	    result.put("isNew", true);
	    return result;
	}

	

	

//
//	// 닉네임 또는 이메일로 회원 검색
//	@Override
//	public List<Member> searchTargetList(Map<String, Object> map) {
//		return dao.searchTargetList(map);
//	}
//
//
//	// 채팅방 입장 없으면 생성
//	@Override
//	public int chattingEnter(Map<String, Integer> map) {
//		return dao.checkChattingNo(map);
//	}
//
//
//	// 채팅방 생성
//	@Override
//	public int createChattingRoom(Map<String, Integer> map) {
//		return dao.createChattingRoom(map);
//	}
//
//	// 채팅방 읽음 표시
//	@Override
//	public int updateReadFlag(Map<String, Object> paramMap) {
//		return dao.updateReadFlag(paramMap);
//	}
//
//	// 채팅방 메세지 목록 조회
//	@Override
//	public List<Message> selectMessageList(Map<String, Object> paramMap) {
//		
//		// 1) 메세지 목록 조회
//		List<Message> messageList = dao.selectMessageList(Integer.parseInt( String.valueOf(paramMap.get("chattingNo"))));
//		
//		// String.valueOf : Object의 값을 String으로 변환
//		//					값이 null인 경우 "null"이라는 문자열로 처리
//		
//		// 2) 메세지 목록이 존재하는 경우 알림 읽음 처리
//		if(!messageList.isEmpty()) {
//			dao.updateReadFlag(paramMap);
//		}
//		
//		return messageList;
//	}
//

}
