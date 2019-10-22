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
	public ChatDto checkRoom(String name)  {
		
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
	public void createChatRoom(ChatDto dto)  {
		
		try {
			sqlSession.insert(namespace+"createChatRoom", dto);
		} catch (Exception e) {
			System.out.println("createChatRoom ERROR");
			e.printStackTrace();
		}
	}

	@Override
	public List<ChatDto> getRoomList()  {
		
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
	public void addRoomMember(ChatMemberDto mem)  {
		
		try {
			sqlSession.insert(namespace+"addRoomMember",mem);
		} catch (Exception e) {
			System.out.println("addRoomMember ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public ChatMemberDto getRoomMember(ChatMemberDto mem)  {
		
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
	public void updateRoomMember(ChatMemberDto mem)  {
		
		try {
			sqlSession.update(namespace+"updateRoomMember",mem);
		} catch (Exception e) {
			System.out.println("updateRoomMember ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateChatCountInc(ChatDto dto)  {

		try {
			sqlSession.update(namespace+"updateChatCountInc",dto);
		} catch (Exception e) {
			System.out.println("updateRoomMember ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public void updateChatCountDec(ChatDto dto)  {

		try {
			sqlSession.update(namespace+"updateChatCountDec",dto);
		} catch (Exception e) {
			System.out.println("updateChatCountDec ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public void deleteChat()  {

		try {
			sqlSession.delete(namespace+"deleteChat");
		} catch (Exception e) {
			System.out.println("deleteChat ERROR");
			e.printStackTrace();
		}
		
	}

	@Override
	public List<ChatDto> searchRoomList(String name)  {
		
		List<ChatDto> list = null;
		
		try {
			list = sqlSession.selectList(namespace+"searchRoomList", name);
		} catch (Exception e) {
			System.out.println("searchRoomList ERROR");
			e.printStackTrace();
		}
	
		return list;
		
	}

	@Override
	public void deletRoomMember(ChatMemberDto mem) {
		try {
			sqlSession.delete(namespace+"deleteRoomMember", mem);
		} catch (Exception e) {
			System.out.println("deletRoomMember ERROR");
			e.printStackTrace();
		}
	}

	@Override
	public List<String> sameRoomList(String roomname) {
		List<String> list = null;
		
		try {
			list = sqlSession.selectList(namespace+"selectRoomMember", roomname);
		} catch (Exception e) {
			System.out.println("sameRoomList ERROR");
			e.printStackTrace();
		}
	
		return list;
	}

}
