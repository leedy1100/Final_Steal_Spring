package com.steal.bs.chatting;

import java.io.StringWriter;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.json.Json;
import javax.json.JsonObject;
import javax.json.JsonWriter;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.socket.CloseStatus;
import org.springframework.web.socket.TextMessage;
import org.springframework.web.socket.WebSocketSession;
import org.springframework.web.socket.handler.TextWebSocketHandler;

import com.steal.bs.model.ChattingDto;

public class WebSocket extends TextWebSocketHandler {

	@Autowired
	ChatBiz chatBiz;

	private List<WebSocketSession> sessionList = new ArrayList<>();
	private Map<WebSocketSession, String> mapList = new HashMap<>();
	private Map<WebSocketSession, String> roomList = new HashMap<>();

	/* private List<String> userList = new ArrayList<>(); */
	
	@Override
	public void afterConnectionEstablished(WebSocketSession session) throws Exception {

		Map<String, Object> map = session.getAttributes();
		ChattingDto mem = (ChattingDto) map.get("login");

		String userId = mem.getMain_id();

		ChatMemberDto userRoom = chatBiz.getRoomMember(new ChatMemberDto(0, userId, "", ""));

		roomList.put(session, userRoom.getRoom());

		String priroom = userRoom.getRoom();
		chatBiz.updateRoomMember(new ChatMemberDto(0, userId, "", priroom));

		mapList.put(session, userId);

		sessionList.add(session);

		chatBiz.updateChatCountInc(new ChatDto(0, userRoom.getRoom(), "", 0, 0, ""));

		for (int i = 0; i < sessionList.size(); i++) {

			if (userRoom.getRoom().equals(roomList.get(sessionList.get(i)))) {
				sessionList.get(i).sendMessage(new TextMessage(JsonDataOpen(userId)));
			}

			/*
			 * String roomName = roomList.get(sessionList.get(i));
			 * 같은방 접속자 리스트 보여준다
			 * userList = informUser(mapList, roomName); ChatUtil chatUtil = new ChatUtil();
			 * String userListMessage = chatUtil.split(userList);
			 * sessionList.get(i).sendMessage(new TextMessage(JsonUser(userListMessage)));
			 * 
			 * 방 리스트 보내준다.
			 * String roomNames = getRoomName(); sessionList.get(i).sendMessage(new
			 * TextMessage(JsonRoom(roomNames)));
			 */
			
		}

	}

	@Override
	public void afterConnectionClosed(WebSocketSession session, CloseStatus status) throws Exception {

		Map<String, Object> map = session.getAttributes();
		ChattingDto mem = (ChattingDto) map.get("login");
		String userId = mem.getMain_id();

		ChatMemberDto member = chatBiz.getRoomMember(new ChatMemberDto(0, userId, "", ""));

		roomList.remove(session);
		mapList.remove(session);
		sessionList.remove(session);
		
		chatBiz.updateChatCountDec(new ChatDto(0, member.getPriroom(), "", 0, 0, ""));

		Iterator<WebSocketSession> roomIds = roomList.keySet().iterator();
		while (roomIds.hasNext()) {
			WebSocketSession roomId = roomIds.next();
			String value = roomList.get(roomId);
			if (member.getPriroom().equals(value)) {
				roomId.sendMessage(new TextMessage(JsonDataClose(userId)));
			}
		}
		
		/*
		 * 위와 같음
		 * for (int i = 0; i < sessionList.size(); i++) { String roomName =
		 * roomList.get(sessionList.get(i));
		 * 
		 * userList = informUser(mapList, roomName); ChatUtil chatUtil = new ChatUtil();
		 * String userListMessage = chatUtil.split(userList);
		 * sessionList.get(i).sendMessage(new TextMessage(JsonUser(userListMessage)));
		 * System.out.println(sessionList.get(i));
		 * 
		 * String roomNames = getRoomName(); sessionList.get(i).sendMessage(new
		 * TextMessage(JsonRoom(roomNames))); }
		 */
		
		chatBiz.deletRoomMember(new ChatMemberDto(0, userId, "", ""));
		chatBiz.deleteChat();

	}

	@Override
	protected void handleTextMessage(WebSocketSession session, TextMessage message) throws Exception {

		Map<String, Object> map = session.getAttributes();
		ChattingDto mem = (ChattingDto) map.get("login");
		String userId = mem.getMain_id();

		System.out.println("들어온 메세지 : "+message.getPayload());
			
		if(message.getPayload().equals("got user media")) {
			session.sendMessage(message);
			return;
		} else if(message.getPayload().contains("type: \"offer\"")) {
			String room = message.getPayload().substring(7, message.getPayload().indexOf(", type: \"offer\""));
			
			String offermessage = message.getPayload().replaceAll("\\{room: "+room+", type: \"offer\", sdp: \"", "");
			offermessage = offermessage.replaceAll("\"\\}", "");
			
			for (WebSocketSession webSocketSession : sessionList) {
				if (room.equals(roomList.get(webSocketSession))) {
					if (!session.getId().equals(webSocketSession.getId())) {
						webSocketSession.sendMessage(new TextMessage(Jsonoffer(offermessage)));
					}
				}
			}
			
			return;
		} else if(message.getPayload().contains("type: \"answer\"")) {
			String room = message.getPayload().substring(7, message.getPayload().indexOf(", type: \"answer\""));
			
			String answermessage = message.getPayload().replaceAll("\\{room: "+room+", type: \"answer\", sdp: \"", "");
			answermessage = answermessage.replaceAll("\"\\}", "");
			
			for (WebSocketSession webSocketSession : sessionList) {
				if (room.equals(roomList.get(webSocketSession))) {
					if (!session.getId().equals(webSocketSession.getId())) {
						webSocketSession.sendMessage(new TextMessage(Jsonanswer(answermessage)));
					}
				}
			}
			
			return;
		} else if(message.getPayload().contains("candidate:")) {
			
			String room = message.getPayload().substring(6, message.getPayload().indexOf("~candidate:"));
			
			String candidatemessageclone = message.getPayload().replaceAll("room: "+room+"~", "");
			
			String[] candidatemessage = candidatemessageclone.split("~");
			
			for (WebSocketSession webSocketSession : sessionList) {
				if (room.equals(roomList.get(webSocketSession))) {
					if (!session.getId().equals(webSocketSession.getId())) {
						webSocketSession.sendMessage(new TextMessage(Jsoncandidate(candidatemessage)));
					}
				}
			}
			
			
			return;
			
		} else if(message.getPayload().contains("type: bye")) {
			
			String room = message.getPayload().substring(6, message.getPayload().indexOf(", type: bye"));
			String userID = message.getPayload().substring(message.getPayload().indexOf(", userID: ")+10);
			
			for (WebSocketSession webSocketSession : sessionList) {
				if (room.equals(roomList.get(webSocketSession))) {
					if (!session.getId().equals(webSocketSession.getId())) {
						webSocketSession.sendMessage(new TextMessage(Jsonbye(userID)));
					}
				}
			}
			
			return;
			
		} else if(message.getPayload().contains("type: join")) {
			
			String room = message.getPayload().substring(6, message.getPayload().indexOf(", type: join"));
			
			String userID = message.getPayload().substring(message.getPayload().indexOf(", userID: ")+10);
			
			for (WebSocketSession webSocketSession : sessionList) {
				if (room.equals(roomList.get(webSocketSession))) {
					if (!session.getId().equals(webSocketSession.getId())) {
						webSocketSession.sendMessage(new TextMessage(Jsonjoin(userID)));
					}
				}
			}
			
			return;
			
		} 
		
		if (message.getPayload().contains("!%/&")) {

			String searchRoom = message.getPayload().replaceAll("!%/&", "");

			String roomNames = "";
			if (searchRoom.equals("")) {
				roomNames = getRoomName();
			} else {
				roomNames = getRoomName(searchRoom);
			}

			for (WebSocketSession webSocketSession : sessionList) {
				if (session.getId().equals(webSocketSession.getId())) {
					webSocketSession.sendMessage(new TextMessage(JsonRoom(roomNames)));
				}
			}
		} else {
			String msgArr[] = new String[3];
			msgArr = message.getPayload().split("!%/");

			if (!msgArr[1].equals("")) {
				Iterator<WebSocketSession> sessionIds = mapList.keySet().iterator();
				while (sessionIds.hasNext()) {
					WebSocketSession sessionId = sessionIds.next();
					String value = mapList.get(sessionId);
					if (value.equals(msgArr[1])) {
						sessionId.sendMessage(new TextMessage(JsonWisper(userId, msgArr[0])));
					}
				}
			} else {
				for (WebSocketSession webSocketSession : sessionList) {
					if (msgArr[2].equals(roomList.get(webSocketSession))) {
						if (!session.getId().equals(webSocketSession.getId())) {
							webSocketSession.sendMessage(new TextMessage(JsonData(userId, msgArr[0])));
						}
					}
				}
			}
		}
	}

	public String JsonData(String id, Object msg) {

		JsonObject jsonObject = Json.createObjectBuilder()
				.add("message", "<p class="+id+" align='left'><b><a href='#none' onclick=\"insertWisper('" + id + "')\"><b>["
						+ id + "]</b></a> : " + msg + "</b></p>")
				.build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}

	public String JsonDataOpen(String id) {

		JsonObject jsonObject = Json.createObjectBuilder().add("message", "<p align='center'><a href='#none' onclick=\"insertWisper('"
				+ id + "')\"><b>[" + id + "]</b> 님이 <b style='color:blue'>접속</b>하였습니다.</a></p>").build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}

	public String JsonDataClose(String id) {

		JsonObject jsonObject = Json.createObjectBuilder()
				.add("message", "<p align='center'><b>[" + id + "]</b> 님이 <b style='color:red'>퇴장</b>하였습니다.</p>").build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}

	public String JsonWisper(String fromId, Object msg) {

		JsonObject jsonObject = Json.createObjectBuilder()
				.add("message",
						"<p align='left'><b><a href='#none' onclick=\"insertWisper('" + fromId + "')\"><b style='color:green'>[" + fromId + "]</b>님의 귓속말</a> : " + msg +"</b></p>")
				.build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}

	public String JsonUser(String id) {

		JsonObject jsonObject = Json.createObjectBuilder().add("list", id).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}

	public String JsonRoom(String roomNames) {

		JsonObject jsonObject = Json.createObjectBuilder().add("room", roomNames).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}

	/*
	 * private List<String> informUser(Map<WebSocketSession, String> maplist, String
	 * room) throws Exception {
	 * 
	 * List<String> list = new ArrayList<>();
	 * 
	 * Iterator<WebSocketSession> sessionIds = maplist.keySet().iterator(); while
	 * (sessionIds.hasNext()) { WebSocketSession sessionId = sessionIds.next();
	 * String value = maplist.get(sessionId);
	 * 
	 * String userRoom = roomList.get(sessionId);
	 * 
	 * if (userRoom.equals(room)) { list.add(value); } }
	 * 
	 * return list; }
	 */

	public String getRoomName() throws Exception {

		List<ChatDto> roomList = chatBiz.getRoomList();

		String room = sessionList.size() + "";

		for (int i = 0; i < roomList.size(); i++) {
			room += ",";
			room += roomList.get(i).getName() + "/";
			room += roomList.get(i).getRemaincount() + "/";
			room += roomList.get(i).getTotalcount() + "/";
			room += roomList.get(i).getContent() + "/";
			room += roomList.get(i).getPwd() + "/";
		}

		return room;
	}

	public String getRoomName(String name) throws Exception {

		List<ChatDto> roomList = chatBiz.searchRoomList(name);

		String room = sessionList.size() + "";

		if (roomList.size() < 1) {
			room += ",방이 존재하지 않습니다./ / / /null";
		} else {

			for (int i = 0; i < roomList.size(); i++) {
				room += ",";
				room += roomList.get(i).getName() + "/";
				room += roomList.get(i).getRemaincount() + "/";
				room += roomList.get(i).getTotalcount() + "/";
				room += roomList.get(i).getContent() + "/";
				room += roomList.get(i).getPwd() + "/";
			}
		}

		return room;
	}
	
	public String Jsonoffer(String offerdata) {

		JsonObject jsonObject = Json.createObjectBuilder().add("type","offer").add("sdp", offerdata).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}
	
	public String Jsonanswer(String answerdata) {

		JsonObject jsonObject = Json.createObjectBuilder().add("type","answer").add("sdp", answerdata).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}
	
	public String Jsoncandidate(String[] candidatedata) {

		JsonObject jsonObject = Json.createObjectBuilder().add("candidate",candidatedata[0]).add("component", candidatedata[1]).add("foundation", candidatedata[2]).add("address", candidatedata[3]).add("port", candidatedata[4]).add("priority", candidatedata[5]).add("protocol", candidatedata[6]).add("relatedAddress", candidatedata[7]).add("relatedPort", candidatedata[8]).add("sdpMid", candidatedata[9]).add("sdpMLineIndex", candidatedata[10]).add("tcpType", candidatedata[11]).add("type", candidatedata[12]).add("usernameFragment", candidatedata[13]).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}
	
	public String Jsonbye(String userID) {

		JsonObject jsonObject = Json.createObjectBuilder().add("type","bye").add("userID",userID).build();
		
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();

	}
	
	public String Jsonjoin(String userID) {
		
		JsonObject jsonObject = Json.createObjectBuilder().add("type","join").add("userID",userID).build();
		StringWriter write = new StringWriter();

		try (JsonWriter jsonWriter = Json.createWriter(write)) {
			jsonWriter.write(jsonObject);
		}

		return write.toString();
	}
}
