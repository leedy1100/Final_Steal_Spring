package com.steal.bs.chatting;

import java.util.List;

public interface ChatBiz {

	ChatDto checkRoom(String name) ;
	
	void createChatRoom(ChatDto dto) ;
	
	List<ChatDto> getRoomList() ;
	
	void addRoomMember(ChatMemberDto mem) ;
	
	ChatMemberDto getRoomMember(ChatMemberDto mem) ;

	List<String> sameRoomList(String roomname) ;
	
	void updateRoomMember(ChatMemberDto mem) ;
	
	void deletRoomMember(ChatMemberDto mem) ;

	void updateChatCountInc(ChatDto dto) ;
	
	void updateChatCountDec(ChatDto dto) ;

	void deleteChat() ;

	List<ChatDto> searchRoomList(String name) ;

}
