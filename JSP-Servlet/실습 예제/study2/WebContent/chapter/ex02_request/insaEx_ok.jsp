<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.util.Calendar"%>
<%@page import="java.text.NumberFormat"%>
<%
	String cp=request.getContextPath();
	request.setCharacterEncoding("utf-8");

    // 1 (닭)  2(개)  3(돼지)  4(쥐)  5(소)  6(호랑이)  7(토끼 )  8(용)  9(뱀)  10(말)  11(양)  12(원숭이)
	String []tt={"원숭이", "닭","개","돼지","쥐","소","호랑이","토끼","용","뱀","말","양"};

	String name=request.getParameter("name");
	String birth=request.getParameter("birth");
	String phone=request.getParameter("phone");
	int salary=Integer.parseInt(request.getParameter("salary"));
	String sbonus=request.getParameter("bonus");	// bonus는 입력 안 할 수도 있으므로 
	int bonus=0;
	if(sbonus.length()!=0)
		bonus=Integer.parseInt(sbonus);
	
	String str = birth.replaceAll("(\\.|\\/|\\-)", "");
			
	int y=Integer.parseInt(str.substring(0, 4));
	int m=Integer.parseInt(str.substring(4, 6));
	int d=Integer.parseInt(str.substring(6, 8));
	
	// 띠 구하기 
	int idx=y%12;
	String t=tt[idx];
	
	// 세금 
	int total_pay=salary+bonus;
	int tax=0;
	if(total_pay>=3000000) {
		tax=(int)(total_pay*0.03);
	}else if(total_pay>=2000000) {
			tax=(int)(total_pay*0.02);
	} 
	
	// 실수령액 
	int pay=total_pay-tax;
	
	// 원화기호, 세자리마다 (,) 찍으려고 
	NumberFormat nf = NumberFormat.getCurrencyInstance();	
	
	// 나이 구하기 
	Calendar cal=Calendar.getInstance();
    cal.set(Calendar.YEAR, y);
    cal.set(Calendar.MONTH, m-1);
    cal.set(Calendar.DATE, d);
    
    Calendar now = Calendar.getInstance ();
    
    int age = now.get(Calendar.YEAR) - cal.get(Calendar.YEAR);
    if ( (cal.get(Calendar.MONTH) > now.get(Calendar.MONTH))
            || (cal.get(Calendar.MONTH) == now.get(Calendar.MONTH) 
              && cal.get(Calendar.DAY_OF_MONTH) > now.get(Calendar.DAY_OF_MONTH))) {
        age--;
    }
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="icon" href="data:;base64,iVBORw0KGgo=">
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
	font-size: 14px;
	font-family: 맑은 고딕, 돋움;
}
</style>

</head>
<body>

<div style="width: 400px; margin:30px auto;">
	<h3>| 인사관리</h3>

	<table border="1" style="width: 100%; border-spacing: 0; border-collapse: collapse;">
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">이름</td>
		   <td width="300" style="padding-left: 10px">
		         <%=name%>
		   </td>
		</tr>
		<tr height="25">
		   <td align="right" style="padding-right: 5px">생년월일</td>
		   <td style="padding-left: 10px">
		         <%=birth%>
		   </td>
		</tr>
		<tr height="25">
		   <td align="right" style="padding-right: 5px">띠</td>
		   <td width="300" style="padding-left: 10px">
		         <%=t%>
		   </td>
		</tr>
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">나이</td>
		   <td width="300" style="padding-left: 10px">
		         <%=age%>
		   </td>
		</tr>
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">전화번호</td>
		   <td width="300" style="padding-left: 10px">
		         <%=phone%>
		   </td>
		</tr>
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">기본급</td>
		   <td width="300" style="padding-left: 10px">
		         <%=nf.format(salary)%>
		   </td>
		</tr>
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">수당</td>
		   <td width="300" style="padding-left: 10px">
		         <%=nf.format(bonus)%>
		   </td>
		</tr>
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">세금</td>
		   <td width="300" style="padding-left: 10px">
		         <%=nf.format(tax)%>
		   </td>
		</tr>
		<tr height="25">
		   <td width="100" align="right" style="padding-right: 5px">실급여</td>
		   <td width="300" style="padding-left: 10px">
		         <%=nf.format(pay)%>
		   </td>
		</tr>
	</table>
</div>

</body>
</html>