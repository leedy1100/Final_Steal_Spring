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


$(function(){
	var materID = $("#userId").val();

	$("#"+materID+"M").css("list-style-type","disc");
	memberlistupdate();
	
});

function memberlistupdate(){
<%
	List<String> list = (List<String>)request.getAttribute("memberlist");
	if(list!=null){
		for(int i = 0; i<list.size(); i++){
%>
	$("#<%=list.get(i)%>M").css("list-style-type","disc");
<%
			System.out.println(list.size());
		}
	}
%>
}

</script>

<style type="text/css">

body{
	margin: 0px;
}

#videos>video{
	margin: 0px;
	width: 14%;
	height: auto;
}

#videos>div{
	display:inline-block;
	width: 14%;
	
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
		<video id="video1" id="one" class="received_video" autoplay poster="resources/image/waitperson.png" ></video>
		<video id="video2" id="two" class="received_video" autoplay poster="resources/image/waitperson.png" ></video>
		<video id="video3" id="three" class="received_video" autoplay poster="resources/image/waitperson.png" ></video>
		<video id="video4" id="foul" class="received_video" autoplay poster="resources/image/waitperson.png" ></video>
		<video id="video5" id="five" class="received_video" autoplay poster="resources/image/waitperson.png" ></video>
		<video id="video6" id="six" class="received_video" autoplay poster="resources/image/waitperson.png" ></video>
		<div>
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
	</div>

	<table
		style="height: 600px; width: 900px; margin: 0; padding: 0; text-align: center">

		<col width="200px" />
		<col width="400px" />

		<col width="300px" />

		<tr height="600px;">
			<td style="width: 550px" colspan="2">
				<div
					style="width: 100%; height: 550px; overflow-y: scroll; overflow-x: inherit;"
					class="ui message" id="output"></div>
			</td>

			<td style="width: 300px">
				

				<div style="width: 100%; height: 400px; overflow-y: scroll;"
					class="ui message" id="listPeople"></div>
			</td>
		</tr>

		<tr height="100px;">
			<td><input type="text" id="wisper" value=""
				style="width: 100%; height: 100%; font-weight: bold;"
				class="ui message" name="who" placeholder="귓속말" /></td>
			<td><input type="text" id="textID" size="50" value=""
				style="width: 100%; height: 100%; font-weight: bold;"
				class="ui message blue" name="chatInput" placeholder="내용 입력" /></td>
			<td><input type="button" id="buttonMessage" value="보내기"
				style="width: 100%; height: 100%;" class="ui primary button" /></td>
		</tr>
	</table>

	<h1>Realtime communication with WebRTC</h1>
	<video id="video" id="zero" autoplay></video>
	

	<button id="join">join</button>

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

			$("#output").append(
					"<i class='user icon'></i>"
							+ "<b style='color:blue'>[${login.main_id}]</b> : "
							+ msg + "<br/>");

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
					"<i class='user icon'</i>"
							+ "<b style='color:blue'>[${login.main_id}]</b> : "
							+ "[<b>" + wisper + "</b>]님에게 귓속말 : " + msg
							+ "<br/>");

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
	
var isChannelReady = false;
var isInitiator = false;
var isStarted = false;
var localStream;
var pc;
var remoteStream;

var video = document.getElementById('video');
var video1 = document.getElementById('video1');
var video2 = document.getElementById('video2');
var video3 = document.getElementById('video3');
var video4 = document.getElementById('video4');
var video5 = document.getElementById('video5');
var video6 = document.getElementById('video6');

var roomId;
var remoteUserId;
var isOffer;
var localLargeStream;
var localmediumStream;
var localSmallStream;
var streams = [];
var peer; // offer or answer peer
var peers = [];
var iceServers = {
	iceServers : [ {
		url : 'stun:stun.l.google.com:19302'
	}, {
		url : 'stun:stun1.l.google.com:19302'
	}, {
		url : 'stun:stun2.l.google.com:19302'
	}, {
		url : 'turn:107.150.19.220:3478',
		credential : 'turnserver',
		username : 'subrosa',
	}, ],
};

var peerConnectionOptions = {
	optional : [ {
		DtlsSrtpKeyAgreement : 'true',
	}, ],
};
var mediaConstraints = {
	mandatory : {
		OfferToReceiveAudio : true,
		OfferToReceiveVideo : true,
	},
};

// DOM
var $body = $('body');
var $roomList = $('#room-list');
var $videoWrap = $('#video-wrap');
var $tokenWrap = $('#token-wrap');
var $uniqueToken = $('#unique-token');
var $joinWrap = $('#join-wrap');



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

function PeerStart() {
	console.log("PeerStart 시작")
    if (!isStarted && typeof window.localStream !== 'undefined' && isChannelReady) {
    	console.log('>>>>>> creating peer connection');
        createPeerConnection();
        localStream.getTracks().forEach(track => pc.addTrack(track ,localStream));
        isStarted = true;
    }
    console.log("PeerStart 끝");
}

function createPeerConnection() {
	console.log("createPeerConnection 시작");
	
	try {
		pc = new RTCPeerConnection(pcConfig);
		pc.onicecandidate = handleIceCandidate;
		pc.ontrack = handleTrackEvent;
		if(authority==0){
			pc.onnegotiationneeded = handleNegotiationNeededEvent;
		}
		pc.onremovetrack = handleRemoveTrackEvent;
		
		console.log('Created RTCPeerConnnection');
	} catch (e) {
		console.log('Failed to create PeerConnection, exception: ' + e.message);
		alert('Cannot create RTCPeerConnection object.');
		return;
	}
	
	peers.push(pc);
	
	console.log("createPeerConnection 끝");
	
	return pc;
}

function handleIceCandidate(event) {
	var room = $("#room").val();
	console.log("handleIceCandidate 시작");
	console.log('icecandidate event: ', event);
	if (event.candidate) {
		ws.send("room: "+room+"~"+event.candidate.candidate+"~"+event.candidate.component+"~"+event.candidate.foundation+"~"+event.candidate.address+"~"+event.candidate.port+"~"+event.candidate.priority+"~"+event.candidate.protocol+"~"+event.candidate.relatedAddress+"~"+event.candidate.relatedPort+"~"+event.candidate.sdpMid+"~"+event.candidate.sdpMLineIndex+"~"+event.candidate.tcpType+"~"+event.candidate.type+"~"+event.candidate.usernameFragment);
	} else {
		console.log('End of candidates.');
	}
	console.log("handleIceCandidate 끝");
}


async function handleNegotiationNeededEvent() {
	console.log("doCall 시작");
	
	const offer = await pc.createOffer();
	await onCreateOfferSuccess(offer);
	
	console.log("doCall 끝");
}

async function onCreateOfferSuccess(offer) {
	
	console.log('Sending offer to peer');
	
	try {
		await pc.setLocalDescription(offer);
		onSetLocalSuccess(pc);
		var room = $("#room").val();
		await ws.send("{room: "+room+", type: \"offer\", sdp: \""+pc.localDescription.sdp+"\"}");
	} catch (e) {
		console.log('createOffer() error: ', e);
	}
	
}

function onSetLocalSuccess(pc) {
	console.log(pc+' setLocalDescription complete');
}


async function doAnswer() {
	console.log("doAnswer 시작");
	
	const answer = await pc.createAnswer();
	await onCreateAnswerSuccess(answer);
	
	console.log("doAnswer 끝");
}

async function onCreateAnswerSuccess(answer) {
	
	console.log('Sending answer to peer');
	
	try {
		await pc.setLocalDescription(answer);
		onSetLocalSuccess(pc);
		var room = $("#room").val();
		ws.send("{room: "+room+", type: \"answer\", sdp: \""+pc.localDescription.sdp+"\"}");
	} catch (e) {
		console.log('createAnswer() error: ', e);
	}
	
}

async function onIceCandidate(jsoncandidate) {
	
	try {
		var candidate = new RTCIceCandidate({
			sdpMid: jsoncandidate.sdpMid,
			sdpMLineIndex: jsoncandidate.sdpMLineIndex,
			candidate: jsoncandidate.candidate
		});
		
		await pc.addIceCandidate(candidate);
		
		console.log("pc.addIceCandidate 통과");
		
	} catch (e) {
		console.log('onIceCandidate() error: ', e);
	}
	
}


function handleTrackEvent(event) {
	console.log("handleRemoteStreamAdded 시작");
	console.log('Remote stream added.');
	
	var remoteVideo = document.getElementsByClassName("received_video");
	
	for(var i = 0; i < roomUserNumber-1 ; i++){
		console.log(event.streams[i]);
		remoteVideo.item(i).srcObject = event.streams[i];
	}
		
	console.log("handleRemoteStreamAdded 끝");
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
	var trackList = stream.getTracks();

	
	if (trackList.length == 0) {
		closeVideoCall();
	}
	
}


function closeVideoCall() {
	var remoteVideo = document.getElementsByClassName("received_video");
	var localVideo = document.getElementById("video");

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
			remoteVideo.srcObject.getTracks().forEach(track => track.stop());
		}

		if (localVideo.srcObject) {
			localVideo.srcObject.getTracks().forEach(track => track.stop());
		}
		
		pc.close();
		pc = null;
	}
	
	remoteVideo.removeAttribute("src");
	remoteVideo.removeAttribute("srcObject");
	localVideo.removeAttribute("src");
	localVideo.removeAttribute("srcObject");
	
	targetUsername = null;
}


/* ------------------------------------------------------------------------------------------------------------------------------------ */


	
async function websocket() {
	$("#textID").focus();
	
	ws = new WebSocket("wss://192.168.10.7:8443/bs/echo.do");
	
	ws.onopen = function() {
		
		$("#output").append("<b>채팅방에 참여했습니다.</b> : " + $("#room").val()+ "<br/>");
		
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
		
		if(authority==0) {
			isInitiator = true;
		}
		
	};

	
	ws.onmessage = async function(message) {
		
		console.log(message.data);
		
		var jsonjoin = JSON.parse(message.data);
		if(jsonjoin.type=='join') {
			if(authority==0){
				handleNegotiationNeededEvent();
			}
			
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
			
			return;
		}
		
		
		var jsonoffer = JSON.parse(message.data);
		if(jsonoffer.type=='offer') {
			
			if(authority==0){
				return;
			}
			
			pc.setRemoteDescription(new RTCSessionDescription(jsonoffer));
			await doAnswer();
			
			return;
		}
		
		var jsonanswer = JSON.parse(message.data);
		if(jsonanswer.type=='answer') {
			try{
				await pc.setRemoteDescription(new RTCSessionDescription(jsonanswer));
			} catch (e) {
				console.log("givenAnswer pc.setRemoteDescription(new RTCSessionDescription(jsonanswer)); error" + e);
			}
			
			return;
		}
		
		var jsoncandidate = JSON.parse(message.data);
		if(jsoncandidate.candidate) {
			
			await onIceCandidate(jsoncandidate);
			
			return;
		}
		
		var jsonbye = JSON.parse(message.data);
		if(jsonbye.type=='bye' && isStarted){
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
		}
	};
	
	ws.onclose = function(event) { };
	
	var constraints = { audio: true, video: { width : 300, height : 200, frameRate: { max: 30 } } }; 
	
	navigator.mediaDevices.getUserMedia(constraints).then(function(mediaStream) {
		
		video.srcObject = mediaStream;
		window.localStream = mediaStream;
		
		video.muted = true;
		console.log('Adding local stream.');
		isChannelReady = true;
		
		PeerStart();
		
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
		ws.send("room: "+room+", type: join, userID: "+userID);
		
	}).catch(e => console.log('getUserMedia() error: ', e));
	
}
	
$(document).ready(function() {
	websocket();
});



</script>
</html>