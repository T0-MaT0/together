package edu.kh.project.chatting.service;

import java.util.List;
import java.util.Map;

import edu.kh.project.chatting.model.dto.ChatEmoji;
import edu.kh.project.chatting.model.dto.ChattingRoom;
import edu.kh.project.chatting.model.dto.Message;
import edu.kh.project.individual.dto.Image;
import edu.kh.project.member.model.dto.Member;

public interface ChattingService {

    /** 채팅방 목록 조회 */
    List<ChattingRoom> getChattingList(int memberNo);

    /** 채팅 메시지 조회 */
    List<Message> selectMessageList(Map<String, Object> paramMap);

    /** 채팅 대상 정보 조회 */
    List<Object> selectChatTarget(int roomNo, int memberNo);

    /** 채팅방 삭제 */
    int deleteRoom(int roomNo, int memberNo);

    /** 채팅방 방장 번호 조회 */
    int selectOwnerNo(int roomNo);

    /** 텍스트 메시지 삽입 */
    int insertMessage(Message msg);

    /** 이미지 메시지 삽입 */
    int insertImageMessage(Message msg);

    /** 이미지 정보 저장 (IMG 테이블) */
    void insertChatImage(Image img);

    /** 채팅 이모지 리스트 조회 */
    List<ChatEmoji> getBigEmojiList();

    /** 공동구매 채팅방 생성 (모집글 등록 시) */
    int createGroupChatRoom(String roomName, int ownerNo, Map<String, Object> outMap);

    /** 모집글 제목으로 채팅방 이름 조회 */
    String selectRecruitmentTitle(int recruitmentNo);

    /** 채팅방 이름으로 방 번호 조회 */
    int selectRoomNoByRoomName(String roomName);

    /** 채팅방에 사용자 추가 (참여자 추가) */
    void insertChatRoomUser(int roomNo, int memberNo);

    /** 채팅방에서 사용자 제거 */
    void deleteChatRoomUser(int roomNo, int memberNo);

    /** 채팅방 참여자 리스트 조회 */
    List<Member> selectRoomMemberList(int roomNo);

    /** 채팅방 정보 조회 (이름, 방장 등) */
    ChattingRoom selectRoomName(int roomNo);

    /** 채팅방에서 유저 강제 퇴장 (방장 기능) */
    int kickMemberFromRoom(int roomNo, int targetMemberNo);

    /** 1대1 채팅방 생성 or 존재 여부 확인 */
    Map<String, Object> createOrGetPrivateChatRoom(int myMemberNo, int targetMemberNo, String roomName);
}