<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ page import="java.util.List"%>
<%@ page import="com.util.MyUtil"%>
<%@ page import="com.guest.GuestDTO"%>
<%@ page import="com.guest.GuestDAO"%>
<%
	String cp = request.getContextPath();
	request.setCharacterEncoding("utf-8");

	GuestDAO dao=new GuestDAO();
	MyUtil util=new MyUtil();

	// 변수명 page는 JSP 예약어
	String pageNum=request.getParameter("page");
	int current_page=1;
	if(pageNum!=null)
		current_page=Integer.parseInt(pageNum);
	
	int dataCount=dao.dataCount();
	
	int rows=5;
	int total_page=util.pageCount(rows, dataCount);
	
	if(current_page>total_page)
		current_page=total_page;
	
	int start=(current_page-1)*rows+1;
	int end=current_page*rows;
	
	List<GuestDTO> list=dao.listGuest(start, end);
	
	String listUrl=cp+"/guest/guest.jsp";
	String paging=util.paging(current_page, total_page, listUrl);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
	margin: 0; padding: 0;
}

body {
	font-size: 13px; font-family:  맑은 고딕, 돋움;
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

.title {
	font-size: 15px; font-weight: bold;
}

.btn {
	color: #333; font-weight: 500; 
	border: 1px solid #cccccc; background-color: #ffffff;
	text-align: center; padding: 3px 10px 5px;
	border-radius: 4px;
}
.btn:hover, .btn:active, btn:focus {
	border-color: #adadad;
	background-color: #e6e6e6;
	font-weight: 700;
}

.boxTF {
	border: 1px solid #999999;
	padding: 3px 5px 5px;
	border-radius: 4px;
}

.boxTA{
	border: 1px solid #999999;
	padding: 3px 5px;
	border-radius: 4px;
	height: 150px;
	resize: none;
}
</style>

<script type="text/javascript">
if(typeof String.prototype.trim !== 'function') {
    String.prototype.trim = function() {
        var TRIM_PATTERN = /(^\s*)|(\s*$)/g;
        return this.replace(TRIM_PATTERN, "");
    };
}

function sendGuest() {
    var f = document.guestForm;

    var str = f.name.value;
	str = str.trim();
    if(!str) {
        f.name.focus();
        return;
    }
    f.name.value = str;

	str = f.content.value;
    str = str.trim();
    if(!str) {
        f.content.focus();
        return;
    }
	f.content.value = str;

    f.action = "<%=cp%>/guest/guest_ok.jsp";
    f.submit();
}

function deleteGuest(num)  {
	if (confirm("위 자료를 삭제하시겠습니까 ?")) {
		var url="<%=cp%>/guest/delete.jsp?num="+num+"&page=<%=current_page%>";
		location.href=url;
	}
}
</script>

</head>

<body>

<div style="width: 600px; margin: 30px auto;">
<div>
	<h3 class="title">| 방명록</h3>
</div>

<form name="guestForm" method="post">
  <table style="width: 100%; margin-top:10px; border-spacing: 0; border-collapse: collapse;">
  <tr height="40" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" align="center">작성자</td>
      <td width="500" style="padding-left:10px;"> 
        <input type="text" name="name" maxlength="20" class="boxTF">
      </td>
  </tr>
  
  <tr style="border-bottom: 1px solid #cccccc;"> 
      <td width="100" bgcolor="#eeeeee" style="padding-top:5px; text-align: center;" valign="top">내&nbsp;&nbsp;&nbsp;용</td>
      <td width="500" valign="top" style="padding:5px 0px 5px 10px;" align="left"> 
        <textarea name="content" cols="72" class="boxTA" style="width:97%; height: 70px;"></textarea>
      </td>
  </tr>
  </table>

  <table style="width: 100%; border-spacing: 0; border-collapse: collapse;">
     <tr align="right"> 
      <td height="45">
          <button type="button" class="btn" onclick="sendGuest();">등록하기</button>
          <button type="reset" class="btn">다시입력</button>
      </td>
    </tr>
  </table>
</form>

<table style="width: 100%; margin-top: 15px; table-layout:fixed; word-break:break-all; border-spacing: 0; border-collapse: collapse;">
<%
	for(GuestDTO dto : list) {
%>
		<tr height='35' bgcolor='#eeeeee'>
		    <td width='50%' style='padding-left: 5px; border:1px solid #cccccc; border-right:none;'>
		          <span style='font-weight: 600;'><%=dto.getName()%></span>
		    </td>
		    <td width='50%' align='right' style='padding-right: 5px; border:1px solid #cccccc; border-left:none;'>
			      <%=dto.getCreated()%> | <a href="javascript:deleteGuest('<%=dto.getNum()%>');">삭제</a>
		    </td>
		 </tr>

		 <tr height='50'>
		     <td colspan='2' style='padding: 5px; white-space: pre;' valign='top'><%=dto.getContent() %></td>
         </tr>
<%
	}
%>

	<tr height='40' align='center'>
		<td colspan='2'><%=dataCount==0?"등록된 게시물이 없습니다" : paging %></td>
	</tr>
</table>
</div>

</body>
</html>
