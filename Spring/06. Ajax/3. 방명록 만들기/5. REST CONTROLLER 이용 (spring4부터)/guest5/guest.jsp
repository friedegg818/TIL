<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%
   String cp = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>spring</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<link rel="stylesheet" href="<%=cp%>/resource/css/style.css" type="text/css">
<style type="text/css">
.title {
	font-weight: bold;
	font-size:13pt;
	margin-bottom:10px;
	font-family: 나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
</style>

<script src="http://code.jquery.com/jquery-3.4.1.min.js"></script>
<script type="text/javascript">
$(function(){
	listPage(1);
});

function listPage(page) {
	var url = "<%=cp%>/guest5/list";
	var query = "pageNo="+page;
	
	$.ajax({
		type: "get",
		url: url,
		data: query,
		dataType: "json",
		success: function(data) {
			printGuest(data);
		},
		error: function(e) {
			console.log(e.responseText);
		}
	});
}

function printGuest(data) {
	// $("#listGuest").show();

	var dataCount=data.dataCount;
	var pageNo=data.pageNo;
	var paging=data.paging;
	
	var out="";
	if(dataCount!=0) {
		out="<table style='width: 100%; margin: 15px auto 10px; table-layout:fixed; word-break:break-all; border-spacing: 0px;'>";
		for(var idx=0; idx<data.list.length; idx++) {
			var num=data.list[idx].num;
			var name=data.list[idx].name;
			var content=data.list[idx].content;
			var created=data.list[idx].created;
			
			out+="<tr height='35' bgcolor='#eeeeee'>";
			out+="  <td width='50%' style='padding-left: 5px; border:1px solid #cccccc; border-right:none;'><span style='font-weight: 600;'>"+ name+"</span></td>";
			out+="  <td width='50%' align='right' style='padding-right: 5px; border:1px solid #cccccc; border-left:none;'>" + created;
			out+=" | <a onclick='deleteGuest(\""+num+"\", \""+pageNo+"\");'>삭제</a></td>" ;
			out+="</tr>";
			out+="<tr height='50'>";
			out+="   <td colspan='2' style='padding: 5px;' valign='top'>"+content+"</td>";
			out+="</tr>";
		}
		out+="<tr height='40'>";
		out+="  <td colspan='2' align='center'>";
		out+=paging;
		out+="  </td>";
		out+="</tr>";
		out+="</table>";
	}
	
	$("#listGuest").html(out);
}



$(function(){
	$("#btnSend").click(function(){		
		var query = $("form[name=guestForm]").serialize();		
		var url = "<%=cp%>/guest5/insert";
		
		$.ajax({
			type: "post",
			url : url,
			data : query,
			dataType : "json",
			success : function(data) {
				var state = data.state;
				
				if(state=="false") {
					alert("게시물을 추가 하지 못했습니다.");
					return false;
				}
				
				listPage(1);
				
				$("#name").val("");
				$("#content").val("");
			},
			error: function(e) {
				console.log(e.rfesponseText);
			},
			beforeSend: check 
		});
	});
	
	function check() {
		var name = $("#name").val().trim();
		var content = $("#content").val().trim();
		if(! name) {
			$("#name").focus();
			return false;
		}
		
		if(! content) {
			$("#content").focus();
			return false;
		}
		
		return true;
	}	
});

function deleteGuest(num, page) {
	if(! confirm("게시물을 삭제 하시겠습니까?")) {
		return;
	}
	
	var url = "<%=cp%>/guest5/delete";
	$.post(url, {num:num}, function(data){
		var state = data.state;
		if(state=="false") {
			alert('게시물 삭제에 실패 했습니다.');
			return;
		}		
		listPage(page);
		
	}, "json");
}

</script>

</head>

<body>

<div style="width: 600px; margin: 30px auto;">
<table style="width: 100%; border-spacing: 0;">
<tr height="40">
	<td align="left" class="title">
		| 방명록
	</td>
</tr>
</table>

<form name="guestForm">
  <table style="width: 100%; margin-top: 10px; border-spacing: 0; border-collapse: collapse;">
  <tr height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="text-align: center;">작성자</td>
      <td width="500" style="padding-left:10px;" align="left"> 
        <input type="text" name="name" id="name" size="35" maxlength="20" class="boxTF">
      </td>
  </tr>
  
  <tr style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="padding-top:5px; text-align: center;" valign="top">내&nbsp;&nbsp;&nbsp;용</td>
      <td width="500" valign="top" style="padding:5px 0px 5px 10px;" align="left"> 
        <textarea name="content" id="content" cols="72" class="boxTA" style="width:97%; height: 70px;"></textarea>
      </td>
  </tr>
  </table>

  <table style="width: 100%; border-spacing: 0;">
     <tr align="right"> 
      <td height="45">
          <button type="button" id="btnSend" class="btn" id="btnSend">등록하기</button>
          <button type="reset" class="btn">다시입력</button>	  
      </td>
    </tr>
  </table>
</form>

<div id="listGuest"></div>

</div>

</body>
</html>
