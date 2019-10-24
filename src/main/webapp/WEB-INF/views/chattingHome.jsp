<%@page import="java.util.ArrayList"%>
<%@page import="com.steal.bs.model.ChattingDto"%>
<%@page import="java.util.List"%>
<%@page import="com.steal.bs.chatting.ChatDto"%>
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

<script type="text/javascript" src="resources/js/jquery-3.4.1.min.js"></script>

<script type="text/javascript">

var height = window.innerHeight;
$(function(){
	$("#myvideo").css("height",(height/100)*69);
	$("#output").css("height",(height/100)*65);
});

$(window).resize(function() {
	height = window.innerHeight;
	$("#myvideo").css("height",(height/100)*69);
	$("#output").css("height",(height/100)*65);
});

$(function(){
	var materID = $("#userId").val();

	$("#"+materID+"M").css("list-style-type","disc");
	memberlistupdate();
	
});

function memberlistupdate(){
<%
	ChattingDto logindto = (ChattingDto)session.getAttribute("login");
	List<String> list = (List<String>)request.getAttribute("memberlist");
	ChatDto dto = (ChatDto)request.getAttribute("userinfodto");
	if(list!=null){
		for(int i = 0; i<list.size(); i++){
%>
	$("#<%=list.get(i)%>M").css("list-style-type","disc");
<%
		}
	}
%>
}

$(function(){
	$("#videos").on('mousewheel', function(e){
		if(e.originalEvent.wheelDelta==120){
			this.scrollLeft -=30;
			if(this.scrollLeft>1){
				e.preventDefault();
			}
		} else if(e.originalEvent.wheelDelta==-120){
			this.scrollLeft +=30;
			if(this.scrollWidth>(this.scrollLeft+(window.innerWidth*7/10))){
				e.preventDefault();
			}
		}
	});
});

</script>

<style type="text/css">

body{
	margin: 0px;
	background-color: aqua; 
}

#videos{
	background-color: #778899;
	display: inline-block;
	width: 86%;
	white-space: nowrap;
	height: 276px;
	overflow: auto;
}

#videos>video{
	margin: 0px;
	width: 260px;
	height: auto;
}

#memberList{
	background-color: #D3D3D3;
	position: relative;
	float: right;
	width: 14%;
	height: 276px;
	overflow: auto;
	
}

#output{
	background-color: #F8F8FF;
	display: inline-block;
	width: 70%; 
	overflow-y: scroll; 
}

#sendM{
	background-color: #F8F8FF;
	display: inline-block;
	width: 70%;
	white-space: nowrap;
}

#wisper{
	width: 9%;
	font-weight: bold;
}

#textID{
	width: 79%;
	font-weight: bold;
}

#buttonMessage{
	width: 9%; 
}

#output>p{
	margin-top: 1%;
	margin-bottom: 1%;
}

#output>p[align="right"]>a{
	display: inline-block;
	max-width: 30%;
	margin-right: 5%;
	padding: 1%;
	background-color: #F0E68C;
	border-radius: 20px 10px;
	white-space: pre-wrap;
	word-break:break-all;
}

#output>p[align="left"]>b{
	display: inline-block;
	max-width: 30%;
	margin-left: 5%;
	padding: 1%;
	background-color: #F0E68C;
	border-radius: 10px 20px;
	white-space: pre-wrap;
	word-break:break-all;
}

#myvideo{
	position: relative;
	background-color: #FAD0E6;
	float: right;
	margin-right: 1%;
	width: 28%;
	text-align: center;
	vertical-align: middle;
}

#myvideo>video{
	top: 20px;
	width: 100%;
}

</style>

</head>
<body>
	<input type="hidden" id="userId" value="${login.main_id}" />
	<input type="hidden" id="room" value="${room}" />

	<div>
		<h3 align="left" style="position: absolute; margin: 3px; ">회의룸 : <b>${room}</b></h3> <h3 align="right" style=" margin: 3px; " >-${login.main_id}님 환영합니다- -<a href="javascript:history.back();" style=" text-decoration:none; ">방 나가기</a>-</h3>
	</div>
	
	<div id="videos">
		<video id="video1" class="received_video" autoplay poster="resources/image/waitperson.png" style=" background-color: #D3D3D3; "  ></video>
		<video id="video2" class="received_video" autoplay poster="resources/image/waitperson.png" style=" background-color: #90EE90; " ></video>
		<video id="video3" class="received_video" autoplay poster="resources/image/waitperson.png" style=" background-color: #FFB6C1; " ></video>
		<video id="video4" class="received_video" autoplay poster="resources/image/waitperson.png" style=" background-color: #FFA07A; " ></video>
		<video id="video5" class="received_video" autoplay poster="resources/image/waitperson.png" style=" background-color: #20B2AA; " ></video>
		<video id="video6" class="received_video" autoplay poster="resources/image/waitperson.png" style=" background-color: #87CEFA; " ></video>
	</div>
	
	<div id="memberList" >
		<ul style=" list-style-type: circle; " >
		<c:if test="${not empty userinfodto.master}">
			<li id="${userinfodto.master}M">${userinfodto.master}</li>
		</c:if>
		<c:if test="${not empty userinfodto.user1}">
			<li id="${userinfodto.user1}M">${userinfodto.user1}</li>
		</c:if>
		<c:if test="${not empty userinfodto.user2}">
			<li id="${userinfodto.user2}M">${userinfodto.user2}</li>
		</c:if>
		<c:if test="${not empty userinfodto.user3}">
			<li id="${userinfodto.user3}M">${userinfodto.user3}</li>
		</c:if>
		<c:if test="${not empty userinfodto.user4}">
			<li id="${userinfodto.user4}M">${userinfodto.user4}</li>
		</c:if>
		<c:if test="${not empty userinfodto.user5}">
			<li id="${userinfodto.user5}M">${userinfodto.user5}</li>
		</c:if>
		<c:if test="${not empty userinfodto.user6}">
			<li id="${userinfodto.user6}M">${userinfodto.user6}</li>
		</c:if>
		</ul>
	</div>

	<div class="ui message" id="output"></div>
	<div id="myvideo"><video id="video" id="zero" autoplay></video></div>
	<div id="sendM">
		&nbsp;<input type="text" id="wisper" value="" class="ui message" name="who" placeholder="귓속말" />
		<input type="text" id="textID" size="50" value="" class="ui message blue" name="chatInput" placeholder="내용 입력" />
		<input type="button" id="buttonMessage" value="보내기" class="ui primary button" />
	</div>
	
	

</body>

<script type="text/javascript">
	var sock = null;
	var id = '${login.main_id}';
	var authority = '${login.authority}';
	
	function sendmsgform() {
		var msg = $('input[name=chatInput]').val().trim("!%/");
		var wisper = $("#wisper").val().trim("!%/");
		var room = $("#room").val().trim("!%/");
		
		if (wisper == "" && msg != "") {
			ws.send(msg + "!%/" + "" + "!%/" + room);

			$("#output").append("<p align='right'><a>"+ msg + "</a></p>");

			$("#output").scrollTop(99999999);
			$("#textID").val("");
			$("#textID").focus();
		} else if (wisper != "" && msg != "") {
			
			if ($("#userId").val() == wisper) {
				
				alert("귓속말을 본인에게는 보낼 수 없습니다.");
				$("#wisper").focus();
			
			} else {
				
				ws.send(msg + "!%/" + wisper + "!%/" + room);
				$("#output").append(
					"<p align='right' ><a>[<b>" + wisper + "</b>]님에게 귓속말 : " + msg + "</a></p>");

				$("#output").scrollTop(99999999);
				$("#textID").val("");
				$("#textID").focus();
				
			}
		}
	}			

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

	$("#wisper").click(function() {
		$("#wisper").val("");
	});
	
	
	/* ------------------------------------------------------------------------------------------------------------------------ */

var video = document.getElementById('video');
	
var connections = [];

var pcConfig = {
		'iceServers': [{
			urls: 'stun:stun.l.google.com:19302'
		}, {
			url : 'stun:stun1.l.google.com:19302'
		}, {
			url : 'stun:stun2.l.google.com:19302'
		}]
};

window.onbeforeunload = function () {
	var room = $("#room").val();
	ws.send("room: "+room+", type: bye, userID: "+userID);
}

function PeerStart(userID) {
	console.log("PeerStart 시작")

	console.log('>>>>>> creating peer connection');
	
	var pc = createPeerConnection(userID);
        
	window.localStream.getTracks().forEach(track => pc.addTrack(track , window.localStream));
   
    console.log("PeerStart 끝");
}

function createPeerConnection(userID) {
	console.log("createPeerConnection 시작");
	
	var peer = {
			userID : userID,
			pc : null
	};
	
	try {
		peer.pc = new RTCPeerConnection(pcConfig);
		peer.pc.onicecandidate = function(event) {
			var room = $("#room").val();
			console.log("handleIceCandidate 시작");
			console.log('icecandidate event: ', event);
			if (event.candidate) {
				ws.send("userID: "+userID+", fromID: "+id+", room: "+room+"~"+event.candidate.candidate+"~"+event.candidate.component+"~"+event.candidate.foundation+"~"+event.candidate.address+"~"+event.candidate.port+"~"+event.candidate.priority+"~"+event.candidate.protocol+"~"+event.candidate.relatedAddress+"~"+event.candidate.relatedPort+"~"+event.candidate.sdpMid+"~"+event.candidate.sdpMLineIndex+"~"+event.candidate.tcpType+"~"+event.candidate.type+"~"+event.candidate.usernameFragment);
			} else {
				console.log('End of candidates.');
			}
			console.log("handleIceCandidate 끝");
		}
		
		peer.pc.ontrack = function(event) {
			console.log("handleRemoteStreamAdded 시작");
			console.log('Remote stream added.');
			console.log(userID);
			var remoteVideo = document.getElementsByClassName(userID);
			console.log(remoteVideo);

			console.log(event);
			console.log(event.streams[0]);
			
			remoteVideo.item(0).srcObject = event.streams[0];
			
			console.log("handleRemoteStreamAdded 끝");
		};
		peer.pc.onremovetrack = handleRemoveTrackEvent;
		
		console.log('Created RTCPeerConnnection');
	} catch (e) {
		console.log('Failed to create PeerConnection, exception: ' + e.message);
		alert('Cannot create RTCPeerConnection object.');
		return;
	}
	
	connections.push(peer);
	
	console.log("createPeerConnection 끝");
	
	return peer.pc;
}

function getPeer(userID) {
	console.log('getPeer', arguments);
	var peer = null;

	for (var i = 0; i < connections.length; i++) {
		if (connections[i].userID === userID) {
			peer = connections[i].pc;
		}
	}

	return peer;
}

async function handleNegotiationNeededEvent(userID) {
	console.log("doCall 시작");
	
	var peer = getPeer(userID);
	
	const offer = await peer.createOffer();
	try {
		console.log('Sending offer to peer');
		await peer.setLocalDescription(offer);
		onSetLocalSuccess(peer);
		var room = $("#room").val();
		await ws.send("userID: "+userID+", fromID: "+id+", room: "+room+", type: \"offer\", sdp: \""+peer.localDescription.sdp+"\"");
	} catch (e) {
		console.log('createOffer() error: ', e);
	}
	
	console.log("doCall 끝");
}

function onSetLocalSuccess(peer) {
	console.log(peer+' setLocalDescription complete');
}


async function doAnswer(fromID) {
	console.log("doAnswer 시작");
	
	var peer = getPeer(fromID);
	
	const answer = await peer.createAnswer();
	
	try {
		console.log('Sending answer to peer');
		await peer.setLocalDescription(answer);
		onSetLocalSuccess(peer);
		var room = $("#room").val();
		ws.send("fromID: "+fromID+", userID: "+id+", room: "+room+", type: \"answer\", sdp: \""+peer.localDescription.sdp+"\"");
	} catch (e) {
		console.log('createAnswer() error: ', e);
	}
	
	console.log("doAnswer 끝");
}

async function onIceCandidate(jsoncandidate) {
	
	try {
		var peer = getPeer(jsoncandidate.fromID);
		
		var candidate = new RTCIceCandidate({
			sdpMid: jsoncandidate.sdpMid,
			sdpMLineIndex: jsoncandidate.sdpMLineIndex,
			candidate: jsoncandidate.candidate
		});
		
		await peer.addIceCandidate(candidate);
		
		console.log("pc.addIceCandidate 통과");
		
	} catch (e) {
		console.log('onIceCandidate() error: ', e);
	}
	
}

function handleRemoteHangup() {
	console.log('Session terminated.');
	var remoteVideo = document.getElementsByClassName("received_video");
	
	if (remoteVideo.item(0).srcObject) {
		remoteVideo.item(0).srcObject.getTracks().forEach(track => track.stop());
	}
	
	remoteVideo.item(0).removeAttribute("src");
	remoteVideo.item(0).removeAttribute("srcObject");
	
}

function handleRemoveTrackEvent(event) {
	
	var stream = document.getElementsByClassName("received_video").srcObject;
	var trackList = stream.item(0).getTracks();

	
	if (trackList.length == 0) {
		closeVideoCall();
	}
	
}


function closeVideoCall(userID) {
	var remoteVideo = document.getElementsByClassName("received_video");
	var localVideo = document.getElementById("video");

	var pc = getPeer(userID);
	
	if (pc) {
		pc.ontrack = null;
		pc.onremovetrack = null;
		pc.onremovestream = null;
		pc.onicecandidate = null;
		pc.oniceconnectionstatechange = null;
		pc.onsignalingstatechange = null;
		pc.onicegatheringstatechange = null;
		pc.onnegotiationneeded = null;

		if (remoteVideo.srcObject) {
			remoteVideo.item(0).srcObject.getTracks().forEach(track => track.stop());
		}

		if (localVideo.srcObject) {
			localVideo.item(0).srcObject.getTracks().forEach(track => track.stop());
		}
		
		pc.close();
		pc = null;
	}
	
	remoteVideo.item(0).removeAttribute("src");
	remoteVideo.item(0).removeAttribute("srcObject");
	localVideo.removeAttribute("src");
	localVideo.removeAttribute("srcObject");
	
	targetUsername = null;
}


/* ------------------------------------------------------------------------------------------------------------------------------------ */


	
async function websocket() {
	$("#textID").focus();
	
	ws = new WebSocket("wss://192.168.10.7:8443/bs/echo.do");
	
	ws.onopen = function() {
		
		$("#output").append("<p align='center'><b>채팅방에 참여했습니다.</b> : " + $("#room").val()+ "</p>");
		
		$("#buttonMessage").click(function() {
			sendmsgform();	
		});
		
		$("#textID").keypress(function(event) {
			if (event.which == "13") {
				sendmsgform();
			}
		});
		
		$("#searchRoomBtn").click(
				function() {
				
					var text = $("#searchRoomText").val().trim("!%/&");
					ws.send("!%/&" + text);
					
					$("#searchRoomText").val("");
				});
		
	};

	
	ws.onmessage = async function(message) {
		
		console.log(message.data);
		
		var jsonjoin = JSON.parse(message.data);
		if(jsonjoin.type=='join') {
			
			userid = jsonjoin.userID;
			switch (userid) {
			case "zero":
				idclone="${userinfodto.master}";
				break;
			case "one":
				idclone="${userinfodto.user1}";
				break;
			case "two":
				idclone="${userinfodto.user2}";
				break;
			case "three":
				idclone="${userinfodto.user3}";
				break;
			case "four":
				idclone="${userinfodto.user4}";
				break;
			case "five":
				idclone="${userinfodto.user5}";
				break;
			case "six":
				idclone="${userinfodto.user6}";
				break;
			default:
				break;
			}
			$("#"+idclone+"M").css("list-style-type","disc");
			
			handleNegotiationNeededEvent(idclone);
			
			return;
		}
		
		
		var jsonoffer = JSON.parse(message.data);
		if(jsonoffer.type=='offer') {
			
			if(authority==0){
				return;
			}
			var peer = getPeer(jsonoffer.fromID);
			await peer.setRemoteDescription(jsonoffer);
			await doAnswer(jsonoffer.fromID);
			
			return;
		}
		
		var jsonanswer = JSON.parse(message.data);
		if(jsonanswer.type=='answer') {
			
			var peer = getPeer(jsonoffer.userID);
			try{
				await peer.setRemoteDescription(jsonanswer);
			} catch (e) {
				console.log("setRemoteDescription error" + e);
			}
			
			return;
		}
		
		var jsoncandidate = JSON.parse(message.data);
		if(jsoncandidate.candidate) {
			
			await onIceCandidate(jsoncandidate);
			
			return;
		}
		
		var jsonbye = JSON.parse(message.data);
		if(jsonbye.type=='bye'){
			handleRemoteHangup();
			
			userid = jsonbye.userID;
			switch (userid) {
			case "zero":
				idclone="${userinfodto.master}";
				break;
			case "one":
				idclone="${userinfodto.user1}";
				break;
			case "two":
				idclone="${userinfodto.user2}";
				break;
			case "three":
				idclone="${userinfodto.user3}";
				break;
			case "four":
				idclone="${userinfodto.user4}";
				break;
			case "five":
				idclone="${userinfodto.user5}";
				break;
			case "six":
				idclone="${userinfodto.user6}";
				break;
			default:
				break;
			}
			$("#"+idclone+"M").css("list-style-type","circle");
		}
		
		
		
		var jsonData = JSON.parse(message.data);
		if (jsonData.message != null) {
			$("#output").append(jsonData.message);
			$("#output").scrollTop(99999999);
		}
		
		/* var jsonData2 = JSON.parse(message.data);
		if (jsonData2.list != null) {
			$("#listPeople").html(jsonData2.list);
			<a href="#none" onclick="insertWisper('zongyeng')">zongyeng<p></p></a>
		} */
		
		/* var jsonData3 = JSON.parse(message.data);
		if (jsonData3.room != null) {
			var roomSplit = jsonData3.room.split(',');
			
			roomUserNumber = roomSplit[0];
			
			var str = "<div class='item'<div class='content'><b title='전체채팅방입니다' class='chatRoom' onclick=\"moveRoom('all',0,010000,'null')\">전체 채팅방</b> (총 "+ roomSplit[0] + "명 참여)</div></div>";

			for (var i = 1; i < roomSplit.length; i++) {
				var spl = roomSplit[i].split("/");
				
				if (spl[0] == '방이 존재하지 않습니다') {
					str += "<div class='item'><div class='content'><b title='방이존재하지 않습니다'>"+ spl[0] + "</b></div></div>";
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
		} */
	};
	
	ws.onclose = function(event) { };
	
	var constraints = { audio: true, video: { width : 550, height : 550, frameRate: { max: 30 } } }; 
	
	navigator.mediaDevices.getUserMedia(constraints).then(function(mediaStream) {
		
		video.srcObject = mediaStream;
		window.localStream = mediaStream;
		
		video.muted = true;
		console.log('Adding local stream.');
		
		var room = $("#room").val();
		
		switch (id) {
		case "${userinfodto.master}":
			userID="zero";
			break;
		case "${userinfodto.user1}":
			userID="one";
			break;
		case "${userinfodto.user2}":
			userID="two";
			break;
		case "${userinfodto.user3}":
			userID="three";
			break;
		case "${userinfodto.user4}":
			userID="four";
			break;
		case "${userinfodto.user5}":
			userID="five";
			break;
		case "${userinfodto.user6}":
			userID="six";
			break;
		default:
			break;
		}

		ws.send("room: "+room+", type: join, userID: "+userID+", trueId: "+id);
		
	}).catch(e => console.log('getUserMedia() error: ', e)).then(function() {
<%
		int memberNum = 0;
		List<String> membersname = new ArrayList<String>();
		if(dto.getMaster()!=""&&dto.getMaster()!=logindto.getMain_id()){
			membersname.add(dto.getMaster());
			memberNum++;
%>
		PeerStart("<%=dto.getMaster()%>");
<%
		}
		if(dto.getUser1()!=""&&dto.getUser1()!=logindto.getMain_id()){
			membersname.add(dto.getUser1());
			memberNum++;
%>
		PeerStart("<%=dto.getUser1()%>");
<%		
		} 
		if(dto.getUser2()!=""&&dto.getUser2()!=logindto.getMain_id()){
			membersname.add(dto.getUser2());
			memberNum++;
%>
		PeerStart("<%=dto.getUser2()%>");
<%
		} 
		if(dto.getUser3()!=""&&dto.getUser3()!=logindto.getMain_id()){
			membersname.add(dto.getUser3());
			memberNum++;
%>
		PeerStart("<%=dto.getUser3()%>");
<%
		} 
		if(dto.getUser4()!=""&&dto.getUser4()!=logindto.getMain_id()){
			membersname.add(dto.getUser4());
			memberNum++;
%>
		PeerStart("<%=dto.getUser4()%>");
<%
		} 
		if(dto.getUser5()!=""&&dto.getUser5()!=logindto.getMain_id()){
			membersname.add(dto.getUser5());
			memberNum++;
%>
		PeerStart("<%=dto.getUser5()%>");
<%
		} 
		if(dto.getUser6()!=""&&dto.getUser6()!=logindto.getMain_id()){
			membersname.add(dto.getUser6());
			memberNum++;
%>
		PeerStart("<%=dto.getUser6()%>");
<%
		}
		
		System.out.println(memberNum);
		for(int i = 0; i<memberNum; i++){
%>
			$("#video<%=i+1%>").attr("class","<%=membersname.get(i)%>")
<%			
		}
%>		
	});
	
}
	
$(document).ready(function() {
	websocket();
});

</script>
</html>