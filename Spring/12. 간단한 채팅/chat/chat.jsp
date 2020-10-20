<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();

   String wsURL = "ws://"+request.getServerName()+":"+request.getServerPort()+cp+"/chat.msg";
%>

<style type="text/css">
#chatMsgContainer{
   clear:both;
   border: 1px solid #ccc;
   height: 285px;
   overflow-y: scroll;
   padding: 3px;
   width: 100%;
}
#chatMsgContainer p{
   padding-bottom: 0px;
   margin-bottom: 0px;
}
#chatConnectionList{
	clear:both;
	width: 100%;
	height: 315px;
	text-align:left;
	padding:5px 5px 5px 5px;
	overflow-y:scroll;
    border: 1px solid #ccc;
}
</style>

<script type="text/javascript">
// ---------------------------------------------
$(function(){
	var socket=null;
	
	// - 채팅창을 실행할 때 다음과 같이 ip로 실행
	//   http://아이피주소:포트번호/cp/chat/main

	// - 채팅서버
	//   ws://ip주소:포트번호/cp/chat.msg
	
	var host = "<%=wsURL%>";
	
	if("WebSocket" in window) {
		socket = new WebSocket(host);
	} else if("MozWebSocket" in window) {
		socket = new MozWebSocket(host);
	} else {
		writeToScreen("웹소켓을 지원하지 않는 브라우저입니다.");
		return false;
	}
	
	socket.onopen = function(evt) { onOpen(evt); };
	socket.onclose = function(evt) { onClose(evt); };
	socket.onmessage = function(evt) { onMessage(evt); };
	socket.onerror = function(evt) { onError(evt); };
	
	 // 서버 접속이 성공한 경우 호출되는 콜백함수
	function onOpen(evt) {
		writeToScreen("채팅방에 입장 했습니다.");
		
		var obj = {};
		obj.cmd = "connect";
		obj.userId = "${sessionScope.member.userId}";
		obj.nickName = "${sessionScope.member.userName}";
		
		var jsonStr;
		jsonStr = JSON.stringify(obj); // 자바스크립트 객체를 JSON 문자열로 변환 
		
		socket.send(jsonStr);		
		
		$("#chatMsg").on("keydown", function(event){
			if(event.keyCode==13) {
				sendMessage();
			}
		});
	}

	// 연결이 끊어진 경우에 호출되는 콜백함수
	function onClose(evt) {
		// 채팅 입력창 이벤트를 제거 한다.
		$("#chatMsg").on("keydown", null);
		writeToScreen("웹소켓 종료...");

	}

	// 서버로부터 메시지를 받은 경우에 호출되는 콜백함수
	function onMessage(evt) {
		// 서버가 보낸 정보를 받는다. (JSON)
		var data = JSON.parse(evt.data);
				
		var cmd = data.cmd;
		if(cmd=="connectList") {
			var userId = data.userId;
			var nickName = data.nickName;
			
			var sp = "<span style='display:block;' id='guest-"+userId+"'>";
			sp += nickName + "</span>";
			$("#chatConnectionList").append(sp);
		} else if(cmd=="connect") {
			var userId = data.userId;
			var nickName = data.nickName;
			
			var s = nickName+"님이 입장했습니다.";
			writeToScreen(s);
			
			var sp = "<span style='display:block;' id='guest-"+userId+"'>";
			sp += nickName + "</span>";
			$("#chatConnectionList").append(sp);
			
		} else if(cmd=="disconnect") {
			var userId = data.userId;
			var nickName = data.nickName;
			
			var s = nickName+"님이 퇴장했습니다.";
			writeToScreen(s);
			
			$("#guest-"+userId).remove();
			
		} else if(cmd=="message") {
			var userId = data.userId;
			var nickName = data.nickName;
			var msg = data.chatMsg;
			
			writeToScreen(nickName+">>"+msg);
		}
	}
	
	// 에러가 발생시 호출되는 콜백함수
	function onError(evt) {
		writeToScreen("웹소켓 에러..");
	}
	
	// 메시지 전송
	function sendMessage() {
		var msg = $("#chatMsg").val().trim();
		if(! msg) {
			return;
		}
		
		var obj = {};
		obj.cmd = "message";
		obj.chatMsg = msg;	
		
		var jsonStr;
		jsonStr = JSON.stringify(obj);
		
		socket.send(jsonStr);	
		
		$("#chatMsg").val("");
		writeToScreen("[전송]" + msg);
	}
	
});
//---------------------------------------------

// 채팅 메시지를 출력하기 위한 함수
function writeToScreen(message) {
    var $chatContainer = $("#chatMsgContainer");
    
    $chatContainer.append("<p>");
    $chatContainer.find("p:last").css("wordWrap", "break-word");
    $chatContainer.find("p:last").html(message);
    
    while($chatContainer.find("p").length > 50) { 	// 대화내용이 어느정도 쌓이면 위에 내용부터 지우기 
    	$chatContainer.find("p:first").remove();	
    }    
    
    $chatContainer.scrollTop($chatContainer.prop("scrollHeight"));	// 스크롤바 밑으로 내려가게 
}
</script>

<div class="body-container" style="width: 700px;">
    <div class="body-title">
        <h3><span style="font-family: Webdings">2</span> 채팅 <small style="font-size:65%; font-weight: normal;">Chatting</small></h3>
    </div>
    
    <div style="clear: both;">
        <div style="float: left; width: 350px;">
            <div style="clear: both; padding-bottom: 5px;">
                <span style="font-weight: 600;">＞</span>
                <span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">채팅 메시지</span>
            </div>
            <div id="chatMsgContainer"></div>
            <div style="clear: both; padding-top: 5px;">
                <input type="text" id="chatMsg" class="boxTF"  style="width: 99%;"
                            placeholder="채팅 메시지를 입력 하세요...">
            </div>
        </div>
        
        <div style="float: left; width: 20px;">&nbsp;</div>
        
        <div style="float: left; width: 170px;">
            <div style="clear: both; padding-bottom: 5px;">
                <span style="font-weight: 600;">＞</span>
                <span style="font-weight: 600; font-family: 나눔고딕, 맑은 고딕, 돋움; color: #424951;">접속자 리스트</span>
            </div>
            <div id="chatConnectionList"></div>
        </div>
    </div>

</div>