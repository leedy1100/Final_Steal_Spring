package com.steal.bs.chatting;

import java.util.List;

public class ChatUtil {

	String type;
	String message;
	String list;
	
	public ChatUtil() {}
	
	
	public String split(List<String> mem) {
		String list = "";
		for(int i=0; i<mem.size(); i++) {
			list += "<a href='#none' onclick=\"insertWisper('"+mem.get(i)+"')\">";
			list += mem.get(i);
			list += "</p>";
		}
		return list;
	}

}
