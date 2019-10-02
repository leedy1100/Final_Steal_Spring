<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<% request.setCharacterEncoding("UTF-8"); %>
<% response.setContentType("text/html; charset=UTF-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>chattingHome</title>

<script type="text/javascript" src="resources/js/jquery-3.4.1.min.js" ></script>

</head>
<body>

	<input type="hidden" id="userId" value="${login.main_id}" />
	<input type="hidden" id="room" value="${room}" />

	<table style="width: 900px; background-image: url('');">

		<tr>
			<td align="center" style="width: 600px; color: white">
				<h2>
					방이름:
					<c:if test="${room=='all'}">
						<b>전체 채팅방</b>
					</c:if>
					<c:if test="${room!='all'}">
						<b>${room}</b>
					</c:if>
				</h2>
			</td>

			<td align="center" style="width: 300px">
				<input type="button" class="ui button" value="방 만들기" id="createRoom" />
				&nbsp;&nbsp;
				<input type="button" class="ui button" value="전체 채팅방으로 이동" id="backBtn" />
			</td>
		</tr>

	</table>

	<table style="height: 600px; width: 900px; margin: 0; padding: 0; text-align: center">

		<col width="200px" />
		<col width="400px" />

		<col width="300px" />

		<tr height="600px;">
			<td style="width: 550px" colspan="2">
				<div style="width: 100%; height: 550px; overflow-y: scroll; overflow-x: inherit;" class="ui message" id="output">
				</div>
			</td>

			<td style="width: 300px">
				<form action="moveChatRoom.do" method="post" id="moveChatForm">
					<input type="hidden" name="roomName" value="">

					<div class="ui message blue" style="width: 300px; height: 100px; overflow-y: scroll; overflow-x: inherit;" id="room">
						<div class="ui celled list" id="getRoomList">
							<div class="item">
								<div class="content">
									<b title="전체 채팅방 입니다">전체 채팅방</b>
								</div>
							</div>
						</div>
					</div>
				</form>
				<input type="text" class="ui input blue" style="width: 200px; height: 32px" placeholder="방 제목" id="searchRoomText" />
				&nbsp;&nbsp;&nbsp;
				<input type="button" value="검색" class="ui primary button" style="width: 80px; height: 30px" id="searchRoomBtn" />

				<form action="createChatRoom.do" method="post" id="createForm">
					<input type="hidden" id="chkRoomName" value="">

					<div style="width: 300px; height: 500px; display: none;" class="ui message" id="showCreateRoom">
						<table style="width: 100%; height: 100%">
							<col width="80px">
							<tr style="padding: 1px; margin: 1px">
								<th>방제목</th>
								<td>
									<input type="text" name="name" placeholder="방이름" size="8" class="ui message" style="font-weight: bold; width: 100%; height: 15px" />
								</td>
							</tr>
							<tr>
								<th>비밀번호</th>
								<td>
									<input type="text" name="pwd" placeholder="방 비밀번호" size="8" class="ui message" style="font-weight: bold; width: 100%; height: 15px" title="작성하지 않을시 공개방으로 생성됩니다" />
								</td>
							</tr>
							<tr>
								<th>참여인원</th>
								<td>
									<a href="#none">
										<img src="" onclick="count_back()" width="13px" title="1명 감소">
									</a>
									<input type="text" name="totalcount" value="4" size="2" readonly="readonly" id="count" class="ui message" style="height: 15px; font-weight: bold;" />
									<a href="#none">
										<img src="" onclick="count_next()" width="13px" title="1명 증가">
									</a>
								</td>
							</tr>
							<tr>
								<th>내용</th>
								<td>
									<input type="text" name="content" placeholder="내용" class="ui message" style="font-weight: bold; width: 100%; height: 15px" />
								</td>
							</tr>
							<tr>
								<td colspan="2">
									<input type="button" id="submitBtn" value="방만들기" class="ui primary button" />
									<input type="button" id="backBtn" value="돌아가기" class="ui button" />
								</td>
							</tr>
						</table>
					</div>
				</form>

				<div style="width: 100%; height: 400px; overflow-y: scroll;" class="ui message" id="listPeople">
				</div>
			</td>
		</tr>

		<tr height="100px;">
			<td>
				<input type="text" id="wisper" value="" style="width: 100%; height: 100%; font-weight: bold;" class="ui message" name="who" placeholder="귓속말" />
			</td>
			<td>
				<input type="text" id="textID" size="50" value="" style="width: 100%; height: 100%; font-weight: bold;" class="ui message blue" name="chatInput" placeholder="내용 입력" />
			</td>
			<td>
				<input type="button" id="buttonMessage" value="보내기" style="width: 100%; height: 100%;" class="ui primary button" />
			</td>
		</tr>
	</table>
</body>

<script type="text/javascript">
var sock = null;
var id = '${login.main_id}';
function sendmsgform() {
	var msg = $('input[name=chatInput]').val().trim("!%/");
	var widper = $("#wisper").val().trim("!%/");
	var room = $("#room").val().trim("!%/");

	if (wisper == "" && msg != "") {
		ws.send(msg + "!%/" + "" + "!%/" + room);

		$("#output").append(
				"<i class='user icon'></i>"
						+ "<b style='color:blue'>[${login.main_id}]</b> : "
						+ msg + "<br/>");

		$("#output").scrollTop(99999999);
		$("#testId").val("");
		$("#testId").focus();
	} else if ($("#userId").val() == wisper) {
		alert("귓속말을 본인에게는 보낼 수 없습니다.");
		$("#wisper").focus();
	} else {
		ws.send(msg + "!%/" + "" + "!%/" + room);
		$("#output").append(
				"<i class='user icon'</i>"
						+ "<b style='color:blue'>[${login.main_id}]</b> : "
						+ "[<b>" + wisper + "</b>]님에게 귓속말 : " + msg + "<br/>");

		$("#output").scrollTop(99999999);
		$("#testId").val("");
		$("#testId").focus();
	}
}

$(document)
		.ready(
				function() {
					$("#textID").focus();
					
					if (id == 'admin') {
						ws = new WebSocket("ws://localhost:8787/bs/echo.do");
					} else {
						ws = new WebSocket("ws://127.0.0.1:8787/bs/echo.do");
					}
					
					ws.onopen = function() {
						$("#output").append(
								"<b>채팅방에 참여했습니다.</b> : " + $("#room").val()
										+ "<br/>");

						$("#buttonMessage").click(function() {
							sendmsgform();
						});

						$("#testId").keypress(function(event) {
							if (event.which == "13") {
								sendmsgform();
							}
						});

						$("#searchRoomBtn").click(function() {
							var text = $("#searchRoomText").val().trim("!%/&");
							ws.send("!%/&" + text);

							$("#searchRoomText").val("");
						});
					};

					ws.onmessage = function(message) {
						var jsonData = JSON.parse(message.data);

						if (jsonData.message != null) {
							$("#output").append(jsonData.message + "<br>");
							$("#output").scrollTop(99999999);
						}

						var jsonData2 = JSON.parse(message.data);
						if (jsonData2.list != null) {
							$("#listPeople").html(jsonData2.list);
						}

						var jsonData3 = JSON.parse(message.data);
						if (jsonData3.room != null) {
							var roomSplit = jsonData3.room.split(',');

							var str = "<div class='item'<div class='content'><b title='전체채팅방입니다' class='chatRoom' onclick=\"moveRoom('all',0,010000,'null')\">전체 채팅방</b> (총 "
									+ roomSplit[0] + "명 참여)</div></div>";

							for (var i = 1; i < roomSplit.length; i++) {
								var spl = roomSplit[i].split("/");

								if (spl[0] == '방이 존재하지 않습니다') {
									str += "<div class='item'><div class='content'><b title='방이존재하지 않습니다'>"
											+ spl[0] + "</b></div></div>";
								} else {
									str += "<div class='item'><div class='content'><b title='"
											+ spl[3]
											+ "' class='chatRoom' onclick=\"moveRoom('"
											+ spl[0]
											+ "','"
											+ spl[1]
											+ "','"
											+ spl[2]
											+ "','"
											+ spl[4]
											+ "')\"> "
											+ spl[0]
											+ "</b> ("
											+ spl[1]
											+ "/"
											+ spl[2]
											+ ")</div></div>";
								}
							}

							$("#getRoomList").html(str);
						}
					};
					
					ws.onclose = function(event) {
					};

				});

function moveRoom(room, remaincount, totalcount, pwd) {
	var currentRoom = $("#room").val();

	if (room == currentRoom) {
		alert("현재 선택하신 방에 있습니다.");
	} else {
		if (remaincount < totalcount) {
			if (pwd != 'null') {
				var chkPwd = prompt("비밀번호를 입력하세요.");
				if (chkPwd == pwd) {
					$("[name='roomName']").val(room);
					$("#moveChatForm").attr("target", "_self").submit();
				} else {
					alert("비밀번호가 틀렸습니다.");
				}
			} else {
				$("[name='roomName']").val(room);
				$("#moveChatForm").attr("target", "_self").submit();
			}
		} else {
			alert("인원 수 가 가득 찼습니다.")
		}
	}
};

function count_back() {
	var count = $("#count").val();
	count = (Number(count) - 1);
	if (count >= 2) {
		$("#count").val(count);
	}
};

function count_next() {
	var count = $("#count").val();
	count = (Number(count) + 1);
	if ($("#count").val() < 30) {
		$("#count").val(count);
	}
};

function insertWisper(id) {
	if ($("#userId").val() == id) {
		alert("본인에게는 귓속말을 할 수 없습니다.");
	} else {
		$("#wisper").val(id);
	}
}

$("[name='name']").blur(function() {
	var name = $("[name='name']").val();
	if (name != "") {
		$.ajax({
			type : "post",
			url : "./checkRoom.do",
			async : true,
			data : {
				name : name
			},
			success : function(msg) {
				if (msg == "1") {
					$("#chkRoomName").val(name);
				} else if (msg == "0") {
					alert("이미 존재하는 방이름 입니다.");
					$("[name='name']").val("");
					;
					$("[name='name']").focus();
				}
			}
		});
	}
});

$("#createRoom").click(function() {
	$("#listPeople").slideToggle(300);
	$("#showCreateRoom").slideToggle(300);
});

$("#backBtn").click(function() {
	location.href = "chat.do";
});

$("#submitBtn").click(function() {
	if ($("[name='name']").val().length < 1) {
		alert("방제목을 입력하세요");
		$("[name='name']").focus();
	} else if ($("[name='name']").val() == "all") {
		alert("해방 방제목은 사용할 수 없습니다.");
	} else if ($("chkRoomName").val() == "") {
		alert("이미 방이 존재합니다.");
	} else if ($("[name='content']").val().length < 1) {
		alert("방을 설명하기위한 내용을 입력하세요.");
		$("[name='content']").focus();
	} else {
		$("#createForm").attr("target", "_self").submit();
	}
});

$("#backBtn").click(function() {
	$("form").each(function() {
		this.reset();
	});
	$("#listPeople").slideToggle(300);
	$("#showCreateRoom").slideToggle(300);
});

$("#wisper").click(function() {
	$("#wisper").val("");
});

</script>

</html>