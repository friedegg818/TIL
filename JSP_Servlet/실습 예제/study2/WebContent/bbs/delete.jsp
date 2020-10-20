<%@page import="java.net.URLEncoder"%>
<%@page import="com.bbs.BoardDTO"%>
<%@page import="java.net.URLDecoder"%>
<%@page import="com.bbs.BoardDAO"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%
   String cp = request.getContextPath();
   request.setCharacterEncoding("utf-8");  
   
   BoardDAO dao = new BoardDAO();
   
   int num = Integer.parseInt(request.getParameter("num"));
   String pageNum = request.getParameter("page");
   
   String condition = request.getParameter("condition");
   String keyword = request.getParameter("keyword");
   if(condition==null) {	
	   condition = "subject";
	   keyword = "";
   }
   keyword = URLDecoder.decode(keyword, "UTF-8");
   
   String query = "page=" + pageNum;
   if(keyword.length()!=0) {
	   query+="&condition="+condition+"&keyword="+URLEncoder.encode(keyword,"UTF-8");
   }
   
   dao.deleteBoard(num);
   
   response.sendRedirect(cp+"/bbs/list.jsp?"+query);
   	
 %>