package edu.kh.project.chatting.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import edu.kh.project.chatting.model.dao.ChattingDAO;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.common.utility.Utill;
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
	public int deleteRoom(int roomNo) {
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
