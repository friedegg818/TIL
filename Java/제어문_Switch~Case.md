# 제어문_Switch~case 문 (다중 선택문)
- switch문의 수식 결과 값과 case문의 상수가 일치하는 곳의 문장을 실행 
- 가독성이 높지만 제한적임 
- 메뉴 같은 것 만들 때 많이 사용함 
- 형식   switch(수식){ // 수식: 변수 or 연산식
             ※ byte,short,char,int,String(7.0),enum(열거형)가능 
			    long, float, double, boolean 불가능 
		case 상수_1:문장_1; break;
		case 상수_2:문장_2; break;
		     ※ 상수에는 '값(리터널)'만 가능! 문자 리터널도 포함. 
			 ※ break; 문장을 빠져나오기 위한 기능. 맨 마지막엔 안 써도 됨.
		[default:문장_n; [break;]]
		     ※ 만족하는 상수가 없는 경우 실행, 생략 가능, 위치 상관 X 
		}

public class SwitchEx1 {
	public static void main(String[] args) {
		int a=4;
		
		switch (a) { // 변수,연산식
		case 3: System.out.print("*"); // a==3,  
		case 2: System.out.print("#"); 
		case 1: System.out.print("$");
		}
	}
}

public class SwitchEx2 {
	public static void main(String[] args) {
		int a=13;
		
		// a%3 > 0,1,2  
		
		switch(a%3) { // 수식
		case 0: System.out.println(a+" : 3의배수"); break;
		case 1: System.out.println(a+" : 3의배수아님"); break;
		case 2: System.out.println(a+" : 3의배수아님"); break; 
		/*
		case 1: 
		case 2: System.out.println(a+" : 3의배수아님"); break;
		case 1과 2의 문장이 동일 할 때에는 위와 같이 작성하여도 실행 OK 
		*/
		}
		
		}
	}

import java.util.Scanner;

public class SwitchEx3 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a;
		
		System.out.print("정수?");
		a=sc.nextInt();

		/*
		switch(a) {
		case 3:System.out.print("*");
		case 2:System.out.print("*");
		case 1:System.out.print("*");
		}
		*/
		
		switch(a) {
		case 3:System.out.println("***"); break;
		case 2:System.out.println("**"); break;
		case 1:System.out.println("*"); break;
		}
		
		sc.close();		
	}
}

import java.util.Scanner;

public class SwitchEx4 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String s;
		
		System.out.println("영어로 요일(mon,tue,wed,thu,fri,sat,sun)?");
		s=sc.next();
		
		switch(s) { // String도 가능(7.0부터)
		case "mon" : System.out.println("월요일"); break;
		case "tue" : System.out.println("화요일"); break;
		case "wed" : System.out.println("수요일"); break;
		case "thu" : System.out.println("목요일"); break;
		case "fri" : System.out.println("금요일"); break;
		case "sat" : System.out.println("토요일"); break;
		case "sun" : System.out.println("일요일"); break;
		}
		
		 sc.close();
		 }
}

public class SwitchEx5 {
	public static void main(String[] args) {
		int a=12;
		
		switch(a%2) {   // case 구문 안에 switch 구문을 사용 할 수 있다.
		case 0: System.out.println("2의배수"); // break;를 쓰면 밑의 switch 자체를 실행 할 수 없으므로 오류
				switch(a%3) {
				case 0: System.out.println("3의배수"); break; // 두번째 switch를 나감
				case 1: case 2: System.out.println("3의배수아님"); break;
		        } break;
		case 1: System.out.println("2의배수아님");
				switch(a%3) {
				case 0: System.out.println("3의배수"); break;
				case 1: case 2: System.out.println("3의배수아님"); break;
				} break;
		}
	}
}

public class SwitchEx6 {
	public static void main(String[] args) {
		int n=4;
		
		switch(n) {
		case 3 : System.out.println("CBA"); break;
		case 2 : System.out.println("BA"); break;
		case 1 : System.out.println("A"); break;
		default : System.out.println("에러"); 
		}
	}
}

import java.util.Scanner;

public class SwitchEx7 {
	public static void main(String[] args) {
		// 한 문자를 입력 받아 입력 받은 문자가 숫자인지 확인
		// if를 쓰는게 더 효율적 
		Scanner sc=new Scanner(System.in);
		char c; 
		
		System.out.print("문자?");
		c=sc.next().charAt(0);
		
		switch(c) {
		case '0':case '1':case '2':case '3': case'4':
		case '5':case '6':case '7':case '8': case'9':	
			System.out.println(c+" 숫자...");
			break;
		default : System.out.println(c+" 숫자가 아님...");
			break;
		}
		/*
		 if(c>='0' && c<='9') {
		 	System.out.println(c+" 숫자...");
		}	else {
			System.out.println(c+" 숫자가 아님...");
		}
		 */
		
		
		sc.close();		
	}
}

import java.util.Scanner;
/*
 점수를 입력 받아 수,우,미,양,가 구하기
 단, 입력 받은 점수에는 오류가 없다.
 */

public class SwitchEx8 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int s;
		char grade;
		
		System.out.print("점수[0~100]?");
		s=sc.nextInt();
		
		switch(s/10) { // 관계 연산자(<,>..) X 
		case 10: case 9: grade='수'; break;
		case 8: grade='우'; break;
		case 7: grade='미'; break;
		case 6: grade='양'; break;
		default: grade='가'; break;
		}
		 System.out.println(s+":"+grade);
		 
		 sc.close();		
	}
}

import java.util.Scanner;
/*
 두수 및 연산자 입력 받아 사칙연산
 */

public class SwitchEx9 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		int n1, n2;
		String oper;
		
		System.out.print("두 수?");
		n1=sc.nextInt();
		n2=sc.nextInt();
		System.out.print("연산자[+-*/]?");
		oper=sc.next();
		
		switch (oper) {
		case "+": System.out.println(n1+"+"+n2+"="+(n1+n2)); break;
		case "-": System.out.println(n1+"-"+n2+"="+(n1-n2)); break;
		case "*": System.out.println(n1+"*"+n2+"*"+(n1*n2)); break;
		case "/": System.out.println(n1+"/"+n2+"/"+(n1/n2)); break;
		}
		
		sc.close();		
		}		
	}
	
import java.util.Scanner;
/*
 년도와 월을 입력 받아 월의 마지막 날짜 출력 
 */
public class SwitchEx10 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int y,m,d;
		
		System.out.print("년도?");
		y=sc.nextInt();
		System.out.print("월?");
		m=sc.nextInt();
		
		// 2월 : 년도가 4의 배수이고 100의 배수가 아니거나 400의 배수이면 29일,
		//      그렇지 않으면 28일 
		switch(m) {
		case 1: case 3: case 5: case 7: case 8: case 10: case 12:
			d = 31; break;
		case 4: case 6: case 9: case 11: 
			d = 30; break;
		case 2: 
			if(y%4==0 && y%100!=0 || y%400==0) {
				d=29; 
			} else { 
				d=28;
			}
			break;
		default: d=0; break; // 오류를 없애기 위해 d에 초기값 부여 
		}
		
		if(d!=0) {
			System.out.println(y+"년 "+m+"월 마지막 날짜는 "+d+"일 입니다.");
		} else {
			System.out.println("입력 오류...");
		}
		sc.close();
      }
	}	

    ※ Math.random() : 0<=n<1 범위의 수를 임의로 추출 > 복원추출 	
	
