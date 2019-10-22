package com.steal.bs.chatting;

public class ChatDto {

	private int num;
	private String name;
	private String pwd;
	private int totalcount;
	private int remaincount;
	private String master;
	private String user1;
	private String user2;
	private String user3;
	private String user4;
	private String user5;
	private String user6;
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
	
	

	public ChatDto(int num, String name, String pwd, int totalcount, int remaincount, String master, String user1,
			String user2, String user3, String user4, String user5, String user6, String content) {
		this.num = num;
		this.name = name;
		this.pwd = pwd;
		this.totalcount = totalcount;
		this.remaincount = remaincount;
		this.master = master;
		this.user1 = user1;
		this.user2 = user2;
		this.user3 = user3;
		this.user4 = user4;
		this.user5 = user5;
		this.user6 = user6;
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

	public String getMaster() {
		return master;
	}

	public void setMaster(String master) {
		this.master = master;
	}

	public String getUser1() {
		return user1;
	}

	public void setUser1(String user1) {
		this.user1 = user1;
	}

	public String getUser2() {
		return user2;
	}

	public void setUser2(String user2) {
		this.user2 = user2;
	}

	public String getUser3() {
		return user3;
	}

	public void setUser3(String user3) {
		this.user3 = user3;
	}

	public String getUser4() {
		return user4;
	}

	public void setUser4(String user4) {
		this.user4 = user4;
	}

	public String getUser5() {
		return user5;
	}

	public void setUser5(String user5) {
		this.user5 = user5;
	}

	public String getUser6() {
		return user6;
	}

	public void setUser6(String user6) {
		this.user6 = user6;
	}

	@Override
	public String toString() {
		return "ChatDto [num=" + num + ", name=" + name + ", pwd=" + pwd + ", totalcount=" + totalcount
				+ ", remaincount=" + remaincount + ", master=" + master + ", user1=" + user1 + ", user2=" + user2
				+ ", user3=" + user3 + ", user4=" + user4 + ", user5=" + user5 + ", user6=" + user6 + ", content="
				+ content + "]";
	}

}
