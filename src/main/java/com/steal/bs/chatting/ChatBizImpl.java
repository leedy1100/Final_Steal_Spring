package com.steal.bs.chatting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatBizImpl implements ChatBiz{

	@Autowired
	ChatDao dao;
	
	@Override
	public ChatDto checkRoom(String name)  {
		return dao.checkRoom(name);
	}

	@Override
	public void createChatRoom(ChatDto dto)  {
		dao.createChatRoom(dto);
	}

	@Override
	public List<ChatDto> getRoomList()  {
		return dao.getRoomList();
	}

	@Override
	public void addRoomMember(ChatMemberDto mem)  {
		dao.addRoomMember(mem);
	}

	@Override
	public ChatMemberDto getRoomMember(ChatMemberDto mem)  {
		return dao.getRoomMember(mem);
	}

	@Override
	public void updateRoomMember(ChatMemberDto mem)  {
		dao.updateRoomMember(mem);
	}

	@Override
	public void updateChatCountInc(ChatDto dto)  {
		dao.updateChatCountInc(dto);
	}

	@Override
	public void updateChatCountDec(ChatDto dto)  {
		dao.updateChatCountDec(dto);
	}

	@Override
	public void deleteChat()  {
		dao.deleteChat();
	}

	@Override
	public List<ChatDto> searchRoomList(String name)  {
		return dao.searchRoomList(name);
	}

	@Override
	public void deletRoomMember(ChatMemberDto mem) {
		dao.deletRoomMember(mem);
	}

	@Override
	public List<String> sameRoomList(String roomname) {
		return dao.sameRoomList(roomname);
	}

}
