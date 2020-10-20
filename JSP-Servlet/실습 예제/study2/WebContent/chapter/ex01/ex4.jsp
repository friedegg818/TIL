<%@page contentType="text/html; charset=UTF-8"%>
<%@page trimDirectiveWhitespaces="true" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<script type="text/javascript">
   function check() {
      var f = document.myForm;
      
      if(! f.name.value){
         alert("이름을 입력 하세요..");
         return false;
      }
      
      if(! /^(\d)+$/.test(f.age.value)){
         alert("나이를 입력 하세요...");
         return false;
      }
      return true;
   }
</script>
</head>
<body>
   <form name="myForm" action="ex4_ok.jsp" method="post" onsubmit="return check();">
      <p>이름 : <input type="text" name="name"></p>
      <p>나이 : <input type="text" name="age"></p>
      <p>
         <button type="submit">보내기</button>
      </p>
   </form>
</body>
</html>