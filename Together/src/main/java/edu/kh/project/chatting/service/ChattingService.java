package edu.kh.project.chatting.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.chatting.model.dto.ChatEmoji;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.member.model.dto.Member;

public interface ChattingService {

	/** 채팅방 목록 조회
	 * @param memberNo
	 * @return chattingList
	 */
	List<ChattingRoom> getChattingList(int memberNo);

	/** 채팅 메세지 조회
	 * @param paramMap
	 * @return messageList
	 */
	List<Message> selectMessageList(Map<String, Object> paramMap);

	/** 상대 프로필
	 * @param roomNo
	 * @param memberNo
	 * @return
	 */
	List<Object> selectChatTarget(int roomNo, int memberNo);

	// 채팅방 삭제
	int deleteRoom(int roomNo);

	// 채팅방 주인 확인
	int selectOwnerNo(int roomNo);

	// 메세지 입력
	int insertMessage(Message msg);

	// 메세지 이미지 입력
	int insertImageMessage(Message msg);

	// 메세지 이미지 입력
	void insertChatImage(Image img);

	// 메시지 큰 이모지 조회
	List<ChatEmoji> getBigEmojiList();

	// 모집하기 방 만들 시 채팅방 생성
	int createGroupChatRoom(String roomName, int ownerNo);


	
	

//
//	
//	/** 닉네임 또는 이메일로 회원 검색
//	 * @param map
//	 * @return list
//	 */
//	List<Member> searchTargetList(Map<String, Object> map);
//
//
//	/** 채팅방 입장(없으면 생성)
//	 * @param map
//	 * @return chattingNo
//	 */
//	int chattingEnter(Map<String, Integer> map);
//
//
//	/** 채팅방 생성
//	 * @param map
//	 * @return chattingNo
//	 */
//	int createChattingRoom(Map<String, Integer> map);
//
//
//	/** 채팅방 읽음 표시
//	 * @param paramMap
//	 * @return result
//	 */
//	int updateReadFlag(Map<String, Object> paramMap);



}
