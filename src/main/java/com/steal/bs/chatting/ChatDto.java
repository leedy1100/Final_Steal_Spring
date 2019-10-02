package com.steal.bs.chatting;

public class ChatDto {

	private int num;
	private String name;
	private String pwd;
	private int totalcount;
	private int remaincount;
	private String content;
	
	public ChatDto() {}
	
	public ChatDto(int num, String name, String pwd, int totalcount, int remaincount, String content) {
		super();
		this.num = num;
		this.name = name;
		this.pwd = pwd;
		this.totalcount = totalcount;
		this.remaincount = remaincount;
		this.content = content;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public int getTotalcount() {
		return totalcount;
	}

	public void setTotalcount(int totalcount) {
		this.totalcount = totalcount;
	}

	public int getRemaincount() {
		return remaincount;
	}

	public void setRemaincount(int remaincount) {
		this.remaincount = remaincount;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	@Override
	public String toString() {
		return "ChatDto [num=" + num + ", name=" + name + ", pwd=" + pwd + ", totalcount=" + totalcount
				+ ", remaincount=" + remaincount + ", content=" + content + "]";
	}

}
