<%@page import="com.score.ScoreDTO"%>
<%@page import="com.score.ScoreDAO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
	request.setCharacterEncoding("UTF-8");

	ScoreDAO dao = new ScoreDAO();
	List<ScoreDTO> list = dao.listScore();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
*{
    margin:0; padding: 0;
}
body {
    font-size:14px;
	font-family:"Malgun Gothic", "맑은 고딕", NanumGothic, 나눔고딕, 돋움, sans-serif;
}
a{
    color:#000000;
    text-decoration:none;
    cursor:pointer;
}
a:active, a:hover {
    text-decoration: underline;
    color:tomato;
}
textarea:focus, input:focus{
    outline: none;
}
.btn {
    color:#333333;
    font-weight:500;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
    border:1px solid #cccccc;
    background-color:#ffffff;
    text-align:center;
    cursor:pointer;
    padding:3px 10px 5px;
    border-radius:4px;
}
.btn:active, .btn:focus, .btn:hover {
    background-color:#e6e6e6;
    border-color:#adadad;
    color:#333333;
}
.boxTF {
    border:1px solid #999999;
    padding:3px 5px 5px;
    border-radius:4px;
    background-color:#ffffff;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.selectField {
    border:1px solid #999999;
    padding:2px 5px 4px;
    border-radius:4px;
    font-family:"맑은 고딕", 나눔고딕, 돋움, sans-serif;
}
.title {
    font-weight:bold;
    font-size:16px;
    font-family:나눔고딕, "맑은 고딕", 돋움, sans-serif;
}
</style>

<script type="text/javascript">
function deleteList() {
	var f=document.listForm;
	var cnt=0;
	
	if(f.haks==undefined) {
		return;		
	}
	
	if(f.haks.length!=undefined) {// 체크박스가 둘 이상인 경우
		for(var i=0; i<f.haks.length; i++) {
			if(f.haks[i].checked)
				cnt++;
		}
	} else {
		// 체크박스가 하나인 경우
		if(f.haks.checked)
			cnt++;
	}
	
	if(cnt==0) {
		alert("선택한 항목이 없습니다.");
		return;
	}
	
	if(confirm("선택 항목을 삭제 하시겠습니까 ?")) {
		f.action = "deleteList.jsp";
		f.submit();		
	}
}

function check() {
	var f=document.listForm;
	
	if(f.haks==undefined)
		return;
	
	if(f.haks.length!=undefined) { // 체크박스가 둘 이상인 경우
		for(var i=0; i<f.haks.length; i++) {
			if(f.chkAll.checked)
				f.haks[i].checked=true;
			else
				f.haks[i].checked=false;
		}
	} else { // 체크박스가 하나인 경우
		if(f.chkAll.checked)
			f.haks.checked=true;
		else
			f.haks.checked=false;
	}
}

function deleteScore(hak) {
	if(confirm("삭제 하시겠습니까 ?")) {
		location.href="delete.jsp?hak="+hak;		
	}
}

function updateScore(hak) {
	location.href = "update.jsp?hak="+hak;	
}
</script>
</head>
<body>

<div style="width: 750px; margin: 30px auto;">
	<table style="width: 100%; border-spacing: 0; border-collapse: collapse;">
	<tr height="35">
	   <td align="left" class="title">
			| 성적처리
		</td>
	</tr>
	</table>
	
	<table style="width: 100%; margin-top: 10px; border-spacing: 0; border-collapse: collapse;">
	<tr height="35">
	   <td align="left">
	       <input type="button" value="삭제" class="btn" onclick="deleteList();">
	   </td>
	   <td align="right">
	     <input type="button" value="  등록하기  " class="btn" onclick="javascript:location.href='write.jsp';">
	   </td>
	</tr>
	</table>
	
	<form method="post" name="listForm">
	<table style="width: 100%; border-spacing: 1px; background: #cccccc;">
	<tr height="30" bgcolor="#eeeeee" align="center">
		<th width="35">
		    <input type="checkbox" name="chkAll" value="all" onclick="check();">
		</th>
		<th width="60">학번</th>
		<th width="80">이름</th>
		<th width="90">생년월일</th>
		<th width="60">국어</th>
		<th width="60">영어</th>
		<th width="60">수학</th>
		<th width="60">총점</th>
		<th width="60">평균</th>
		<th width="60">석차</th>
		<th>수정</th>
	</tr>
	
<%for(ScoreDTO dto : list) { %>
	<tr height="35" bgcolor="#ffffff" align="center">
		<td>
		    <input type="checkbox" name="haks" value="<%=dto.getHak()%>">
		</td>
		<td><%=dto.getHak()%></td>
		<td><%=dto.getName()%></td>
		<td><%=dto.getBirth()%></td>
		<td><%=dto.getKor()%></td>
		<td><%=dto.getEng()%></td>
		<td><%=dto.getMat()%></td>
		<td><%=dto.getTot()%></td>
		<td><%=dto.getAve()%></td>
		<td><%=dto.getRank()%></td>
		<td>
			<input type="button" value="수정" class="btn" onclick="updateScore('<%=dto.getHak()%>');">
			<input type="button" value="삭제" class="btn" onclick="deleteScore('<%=dto.getHak()%>');">
		</td>
	</tr>
<% } %>	
	</table>
	</form>
</div>

</body>
</html>