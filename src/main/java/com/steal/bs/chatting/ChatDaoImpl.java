package com.steal.bs.chatting;

import java.util.List;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ChatDaoImpl implements ChatDao{

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public ChatDto checkRoom(String name) throws Exception {
		
		ChatDto dto = null;
		
		try {
			dto = sqlSession.selectOne(namespace+"getRoom", name);
		} catch (Exception e) {
			System.out.println("getRoom ERROR");
			e.printStackTrace();
		}
	
		return dto;
		
	}

	@Override
	public void createChatRoom(ChatDto dto) throws Exception {
		
		try {
			sqlSession.insert(namespace+"createChatRoom", dto);
		} catch (Exception e) {
			System.out.println("createChatRoom ERROR");
			e.printStackTrace();
		}
	}

	@Override
	public List<ChatDto> getRoomList() throws Exception {
		
		List<ChatDto> list = null;
		
		try {
			list = sqlSession.selectList(namespace+"getRoomList");
		} catch (Exception e) {
			System.out.println("getRoomList ERROR");
			e.printStackTrace();
		}
	
		return list;
		
	}

	@Override
	public void addRoomMember(ChatMemberDto mem) throws Exception {
		
		try {
			sqlSession.insert(namespace+"addRoomMember",mem);
		} catch (Exception e) {
			System.out.println("addRoomMember ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public ChatMemberDto getRoomMember(ChatMemberDto mem) throws Exception {
		
		ChatMemberDto dto = null;
		
		try {
			dto = sqlSession.selectOne(namespace+"getRoomMember", mem);
		} catch (Exception e) {
			System.out.println("getRoom ERROR");
			e.printStackTrace();
		}
	
		return dto;
		
	}

	@Override
	public void updateRoomMember(ChatMemberDto mem) throws Exception {
		
		try {
			sqlSession.update(namespace+"updateRoomMember",mem);
		} catch (Exception e) {
			System.out.println("updateRoomMember ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateChatCountInc(ChatDto dto) throws Exception {

		try {
			sqlSession.update(namespace+"updateChatCountInc",dto);
		} catch (Exception e) {
			System.out.println("updateRoomMember ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateChatCountDec(ChatDto dto) throws Exception {

		try {
			sqlSession.update(namespace+"updateChatCountDec",dto);
		} catch (Exception e) {
			System.out.println("updateChatCountDec ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteChat() throws Exception {

		try {
			sqlSession.delete(namespace+"deleteChat");
		} catch (Exception e) {
			System.out.println("deleteChat ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public List<ChatDto> searchRoomList(String name) throws Exception {
		
		List<ChatDto> list = null;
		
		try {
			list = sqlSession.selectList(namespace+"searchRoomList", name);
		} catch (Exception e) {
			System.out.println("searchRoomList ERROR");
			e.printStackTrace();
		}
	
		return list;
		
	}

}
