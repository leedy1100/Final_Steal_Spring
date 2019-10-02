package com.steal.bs.chatting;


public class ChatMemberDto {

	private int num;
	private String id;
	private String room;
	private String priroom;
	
	public ChatMemberDto() {}
	
	public ChatMemberDto(int num, String id, String room, String priroom) {
		super();
		this.num = num;
		this.id = id;
		this.room = room;
		this.priroom = priroom;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getRoom() {
		return room;
	}

	public void setRoom(String room) {
		this.room = room;
	}

	public String getPriroom() {
		return priroom;
	}

	public void setPriroom(String priroom) {
		this.priroom = priroom;
	}

	@Override
	public String toString() {
		return "ChatMemberDto [num=" + num + ", id=" + id + ", room=" + room + ", priroom=" + priroom + "]";
	}

}
