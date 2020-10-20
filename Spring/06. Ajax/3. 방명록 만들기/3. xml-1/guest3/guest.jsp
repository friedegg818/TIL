<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
	String cp=request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<style type="text/css">
.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
</style>

<script type="text/javascript" src="<%=cp%>/resource/jquery/js/jquery.min.js"></script>
<script type="text/javascript">
$(function(){
	listPage(1);
});

function printGuest(data) {
//	var dataCount = data.getElementsByTagName("dataCount")[0].firstChild.nodeValue;  순수 자바스크립트식 
	var dataCount=$(data).find("dataCount").text();
	var pageNo=$(data).find("pageNo").text();
	var paging=$(data).find("paging").text();
	
	var out="";
	$(data).find("record").each(function(){		// record는 여러개니까 each로 돌림
		var record=$(this);
		var num=record.attr("num");
		var name=record.find("name").text();
		var content=record.find("content").text();
		var created=record.find("created").text();
			
		out+="<tr height='35' bgcolor='#eeeeee'>";
		out+="  <td width='50%' style='padding-left: 5px; border:1px solid #cccccc; border-right:none;'><span style='font-weight: 600;'>"+ name+"</span></td>";
		out+="  <td width='50%' align='right' style='padding-right: 5px; border:1px solid #cccccc; border-left:none;'>" + created;
		out+=" | <a onclick='deleteGuest(\""+num+"\", \""+pageNo+"\");'>삭제</a></td>" ;
		out+="</tr>";
		out+="<tr height='50'>";
		out+="   <td colspan='2' style='padding: 5px;' valign='top'>"+content+"</td>";
		out+="</tr>";
	});
	out+="<tr height='40'>";
	out+="  <td colspan='2' align='center'>";
	out+= dataCount==0 ? " 등록된 게시물이 없습니다." : paging;
	out+="  </td>";
	out+="</tr>";
	
	$("#listGuestBody").html(out);
}

$(function(){
	$("#btnSend").click(function(){
		var url = "<%=cp%>/guest3/insert";
		var query = $("form[name=guestForm]").serialize();	
		
		$.ajax({
			type: "post", 
			url : url,
			data : query, 
			dataType : "xml",
			success : function(data) {
				var state = $(data).find("state").text();
				if(state=="false") {
					alert("게시물 등록에 실패 했습니다.");
					return false;
				}
				
				$("#name").val("");
				$("#content").val("");
				listPage(1);				
			},
			error : function(e) {
				console.log(e.responseText);
			}
		});
		
	});
});

function deleteGuest(num, pageNo) {
	var url = "<%=cp%>/guest3/delete";
	
	if(! confirm("게시글을 삭제 하시겠습니까?")) {
		return;
	}
	
	$.ajax({
		type: "post", 
		url : url,
		data : {num:num},
		dataType : "xml",
		success : function(data) {
			listPage(pageNo);
		},
		error : function(e) {
			console.log(e.responseText);
		}
	});
	
}

function listPage(page) {
	var url = "<%=cp%>/guest3/list";
	var query = "pageNo=" + page;
	
	$.ajax({
		type: "get", 
		url : url,
		data : query, 
		dataType : "xml",
		success : function(data) {
			printGuest(data);
		},
		error : function(e) {
			console.log(e.responseText);
		}
	});
}
</script>

</head>
<body>
<div style="width: 600px; margin: 30px auto 10px;">
<table style="width: 100%; border-spacing: 0px;">
<tr height="40">
	<td align="left" class="title">
		| 방명록
	</td>
</tr>
</table>

<form name="guestForm">
  <table style="width: 100%; border-spacing: 0px; border-collapse: collapse;">
  <tr height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td style="padding-left:10px;" align="left"> 
        <input type="text" name="name" id="name" size="35" maxlength="20" class="boxTF">
      </td>
  </tr>
  
  <tr style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="padding-top:5px; text-align: center;" valign="top">내&nbsp;&nbsp;&nbsp;용</td>
      <td valign="top" style="padding:5px 0px 5px 10px;" align="left"> 
        <textarea name="content" id="content" cols="72" class="boxTA" style="width:97%; height: 70px;"></textarea>
      </td>
  </tr>
  </table>

  <table style="width: 100%; margin: 0px auto; border-spacing: 0px;">
     <tr align="right"> 
      <td height="45">
          <button type="button" id="btnSend" class="btn">등록하기</button>
          <button type="reset" class="btn">다시입력</button>
      </td>
    </tr>
  </table>
</form>

<div id="listGuest" style="width:100%;">
	<table style="width: 100%; margin: 15px auto 10px; table-layout:fixed; word-break:break-all; border-spacing: 0; border-collapse: collapse;">
		<thead>
			<tr height="35">
				<td width="50%">
					<span style="color: #3EA9CD; font-weight: 700;">방명록</span>
					<span>[목록]</span>
				</td>
				<td width="50%">&nbsp;</td>
			</tr>
		</thead>
		<tbody id="listGuestBody"></tbody>
	</table>
</div>

</div>

</body>
</html>