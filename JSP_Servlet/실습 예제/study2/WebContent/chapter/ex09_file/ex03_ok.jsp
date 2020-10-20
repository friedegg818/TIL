<%@page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="javax.swing.plaf.multi.MultiProgressBarUI"%>
<%@page import="java.io.File"%>
<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
	request.setCharacterEncoding("UTF-8");

	// localhost:9090/study2(상대경로)의 실제 computer의 경로 . WebContent 
	String root = pageContext.getServletContext().getRealPath("/");
    //	System.out.println(root); 
	String pathname = root + "uploads" + File.separator + "pds";
	
	File f = new File(pathname);
	if(!f.exists()) { // 폴더가 없으면
		f.mkdirs();
	}	
	
	// enctype = "multipart/form-data" 로 넘어온 데이터는 request.getParameter() 로 넘겨 받지 못한다.
			
 	String encType = "UTF-8";
	int max = 5*1024*1024;   // 최대 업로드 용량(5MB)
	
	MultipartRequest mreq = null;
					// request, 파일 저장 경로, 최대 용량, 파라미터 인코딩, 동일파일명 보호 여부 
	mreq = new MultipartRequest(request, pathname, max, encType, new DefaultFileRenamePolicy());
	
	String name = mreq.getParameter("name");
	String subject = mreq.getParameter("subject");
	// 클라이언트가 업로드 한 실제 파일명
	String originalFilename = mreq.getOriginalFileName("upload");
	// 서버에 저장된 파일명 
	String saveFilename = mreq.getFilesystemName("upload");
	long fileSize = 0;
	if(mreq.getFile("upload")!=null) {
		fileSize = mreq.getFile("upload").length();
	}					
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
</head>
<body>

<p> name : <%=name %> </p>
<p> subject : <%=subject %> </p>
<p> originalFilename : <%=originalFilename %> </p>
<p> saveFilename : <%=saveFilename %> </p>
<p> fileSize : <%=fileSize %> </p>

<p> <a href="down.jsp?file=<%=saveFilename%>&file2=<%=originalFilename%>"> 다운로드 </a> </p>

</body>
</html>