<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
.container{
   margin-top: 50px;
}
#row1{
   margin: 0px auto;
   width: 800px;
}
#chatArea{
   height: 450px;
   overflow-y:auto;
   border: 1px solid #00B98E;
}
#sendBtn, #inputBtn, #outputBtn{
	border:1px solid #00B98E;    
	border-radius: 20px;
	background-Color: #00B98E;   
	font-weight:bold;   
	color: white;  
}
</style>
<script type="text/javascript" src="http://code.jquery.com/jquery.js"></script>
<script type="text/javascript" src="http://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.3.0/sockjs.min.js"></script>
<script type="text/javascript">
let websocket;
// 서버연결 
function connection()
{
	// 소켓연결 
	websocket=new WebSocket("ws://localhost:8080/web/chat/chat-ws")
	websocket.onopen=onOpen
	websocket.onclose=onClose
	websocket.onmessage=onMessage
}
// 연결처리 => Callback 
function onOpen(event)
{
	 alert("채팅 서버와 연결되었습니다.")
}
function onClose(event)
{
	  alert("채팅 서버와 연결 해제되었습니다.")
}
function onMessage(event)
{
	 let data=event.data // 전송된 데이터 
	 if(data.substring(0,4)==="msg:") // oto , makeroom  ==> 100 200 300...
	 // msg:[이름] 메세지
	 {
		 appendMessage(data.substring(4))
	 }
}
function disConnection()
{
	websocket.close()
}
// 퇴장처리 => Callback
// 메세지 전송 => Callback
function appendMessage(msg)
{
	 $('#recvMsg').append(msg+"<br>")
	 let ch=$('#chatArea').height()
	 let m=$('#recvMsg').height()-ch
	 $('#chatArea').scrollTop(m)
}
function send()
{
	let name=$('#name').val()
	if(name.trim()==="")
	{
		$('#name').focus()
		return
	}
	
	let msg=$('#sendMsg').val()
	if(msg.trim()==="")
	{
		$('#sendMsg').focus()
		return 
	}
	
	websocket.send("msg:["+name+"]"+msg)
	$('#sendMsg').val("")
	$('#sendMsg').focus()
}
$(function(){
	$('#inputBtn').click(function(){
		connection() 
	})
	$('#outputBtn').click(function(){
		disConnection()
	})
	$('#sendBtn').click(function(){
		send()
	})
	$('#sendMsg').keydown(function(key){
		if(key.keyCode===13)//enter @keydown.13 => enter
		{
			send()
		}
	})
})
</script>
</head>
<body>

<div style="height: 40px"></div>
		<div class="container-xxl bg-white p-0">
  <div class="container">
   <div style="height: 30px"></div>
   <h3 class="text-center">실시간 채팅</h3>
   <div class="row" id="row1">
     <table class="table">
      <tr>
        <td style="border: none;">
         이름:&nbsp;<input type=text id="name" size=15 class="input-sm">&nbsp;&nbsp;
         <input type=button value="입장" class="btn-danger btn-sm" id="inputBtn">&nbsp;
         <input type=button value="퇴장" class="btn-success btn-sm" id="outputBtn">
        </td>
      </tr>
      <tr>
       <td style="border: none;">
        <div id="chatArea">
          <div id="recvMsg"></div>
        </div>
       </td>
      </tr>
      <tr>
        <td style="border: none;">
          <input type=text id="sendMsg" size=85 class="input-sm">&nbsp;&nbsp;
          <input type=button id="sendBtn" value="전  송" class="btn-sm btn-primary">
        </td>
      </tr>
     </table>
   </div>
  </div>
  </div>
  
  
</body>
</html>