package com.steal.bs.chatting;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ChatBizImpl implements ChatBiz{

	@Autowired
	ChatDao dao;
	
	@Override
	public ChatDto checkRoom(String name) throws Exception {
		return dao.checkRoom(name);
	}

	@Override
	public void createChatRoom(ChatDto dto) throws Exception {
		dao.createChatRoom(dto);
	}

	@Override
	public List<ChatDto> getRoomList() throws Exception {
		return dao.getRoomList();
	}

	@Override
	public void addRoomMember(ChatMemberDto mem) throws Exception {
		dao.addRoomMember(mem);
	}

	@Override
	public ChatMemberDto getRoomMember(ChatMemberDto mem) throws Exception {
		return dao.getRoomMember(mem);
	}

	@Override
	public void updateRoomMember(ChatMemberDto mem) throws Exception {
		dao.updateRoomMember(mem);
	}

	@Override
	public void updateChatCountInc(ChatDto dto) throws Exception {
		dao.updateChatCountInc(dto);
	}

	@Override
	public void updateChatCountDec(ChatDto dto) throws Exception {
		dao.updateChatCountDec(dto);
	}

	@Override
	public void deleteChat() throws Exception {
		dao.deleteChat();
	}

	@Override
	public List<ChatDto> searchRoomList(String name) throws Exception {
		return dao.searchRoomList(name);
	}

}
