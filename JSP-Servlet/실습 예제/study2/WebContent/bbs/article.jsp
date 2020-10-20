<%@page import="java.net.URLEncoder"%>
<%@page import="com.bbs.BoardDTO"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.bbs.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page trimDirectiveWhitespaces="true" %>
<%
   String cp = request.getContextPath();
   request.setCharacterEncoding("utf-8");  
   
   BoardDAO dao = new BoardDAO();
   
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("page");
   
   String condition = request.getParameter("condition");
   String keyword = request.getParameter("keyword");
   if(condition==null) {	// 검색이 아닌 경우 
	   condition = "subject";
	   keyword = "";
   }
   keyword = URLDecoder.decode(keyword, "UTF-8");
   
   String query = "page=" + pageNum;
   if(keyword.length()!=0) {
	   query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"UTF-8");
   }
   
   // 조회수 증가
   dao.updateHitCount(num);
   // 게시글 가져오기
   BoardDTO dto = dao.readBoard(num);
   if(dto==null) {
	   response.sendRedirect(cp+"/bbs/list.jsp?" + query);
	   return;
   }
   dto.setContent(dto.getContent().replaceAll("\n", "<br>"));
   
   BoardDTO preReadDto = dao.preReadBoard(num, condition, keyword);
   BoardDTO nextReadDto = dao.nextReadBoard(num, condition, keyword);   
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>study</title>
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
function deleteBoard(num) {
	if(confirm("게시물을 삭제 하시겠습니까?")) {
		var url = "<%=cp%>/bbs/delete.jsp?num="+num+"&<%=query%>";
		location.href = url;
	}
}
 

</script>
</head>

<body>

<div style="width: 600px; margin: 30px auto;">
<table style="width: 100%; border-spacing: 0; border-collapse: collapse;">
<tr height="40"> 
	<td class="title">
		<h3><span>|</span> 게시판</h3>
	</td>
</tr>
</table>

<table style="width: 100%; margin-top: 20px; border-spacing: 0; border-collapse: collapse;">
<tr height="35" style="border-top: 1px solid #cccccc; border-bottom: 1px solid #cccccc;">
    <td colspan="2" align="center">
	   <%=dto.getSubject() %>
    </td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td width="50%" style="padding-left: 5px;">
       이름 : <%=dto.getName() %>
    </td>
    <td width="50%" align="right" style="padding-right: 5px;">
       <%=dto.getCreated() %> | 조회 <%=dto.getHitCount() %>
    </td>
</tr>

<tr style="border-bottom: 1px solid #cccccc;">
  <td colspan="2" style="padding: 10px 5px;" valign="top" height="200">
      <%=dto.getContent() %>
   </td>
</tr>

<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td colspan="2" style="padding-left: 5px;">
       이전글 : 
       <% if(preReadDto!=null) { %>
       		<a href="<%=cp%>/bbs/article.jsp?num=<%=preReadDto.getNum()%>&<%=query%>"><%=preReadDto.getSubject() %></a>
       <% } %>
    </td>
</tr>
<tr height="35" style="border-bottom: 1px solid #cccccc;">
    <td colspan="2" style="padding-left: 5px;">
    다음글 : 
     <% if(nextReadDto!=null) { %>
       		<a href="<%=cp%>/bbs/article.jsp?num=<%=nextReadDto.getNum()%>&<%=query%>"><%=nextReadDto.getSubject() %></a>
     <% } %>
    </td>
</tr>
<tr height="30">
	<td colspan="2" style="padding-right: 5px; text-align: right;">
		<%=dto.getIpAddr() %>
	</td>
</tr>
<tr height="45">
    <td>
        <button type="button" class="btn" onclick="javascript:location.href='<%=cp%>/bbs/update.jsp?num=<%=dto.getNum()%>&page=<%=pageNum%>';">수정</button>
        <button type="button" class="btn" onclick="deleteBoard(<%=dto.getNum()%>);">삭제</button>
    </td>
    <td align="right">
        <button type="button" class="btn" onclick="javascript:location.href='<%=cp %>/bbs/list.jsp?<%=query %>';">리스트</button>
    </td>
</tr>
</table>
</div>

</body>
</html>
