package com.steal.bs.chatting;

import java.util.List;

public interface ChatDao {

	String namespace= "base.";
	
	ChatDto checkRoom(String name) throws Exception;
	
	void createChatRoom(ChatDto dto) throws Exception;
	
	List<ChatDto> getRoomList() throws Exception;
	
	void addRoomMember(ChatMemberDto mem) throws Exception;
	
	ChatMemberDto getRoomMember(ChatMemberDto mem) throws Exception;

	//Lsit<ChatMemberDto> sameRoomList(ChatMemberDto mem) throws Exception;
	
	void updateRoomMember(ChatMemberDto mem) throws Exception;
	
	//void deletRoomMember(ChatMemberDto mem) throws Exception;

	void updateChatCountInc(ChatDto dto) throws Exception;
	
	void updateChatCountDec(ChatDto dto) throws Exception;

	void deleteChat() throws Exception;

	List<ChatDto> searchRoomList(String name) throws Exception;
	
}
