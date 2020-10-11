# 제어문
## IF 문 
- if 다음의 조건이 참일 경우, 특정 문장을 수행 하고자 할 때
- 삼항연산자로 표현 되는 모든 식은 if 문으로 바꿀 수 있다. (반대는 불가능) 
- 형식   

	  if(조건식) { 
             실행문_1;
	     실행문_2;
          }
         
       ** 조건식의 결과는 반드시 true or false 
       ** 실행문이 한 개인 경우에만 {} 생략 가능 
       
- 프로그램을 짤 때, 꼭 경우의 수를 생각 할 것! 
- if 의 수를 줄이는게 좋다. (많으면 실수 ↑, 고치기 어려움) 

  [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/IF%20Ex1-6)
  
#
### if 제어문 만들기
- int형 변수 n이 10이상이고 20미만일때 true인 조건식
   
      if( n>=10 && n<20   ) {  }

- char형 변수 ch가 공백이나 탭이 아닐때 true인 조건식
  
      if( ch!=' ' && ch!='\t' ) {  }

- char형 변수 ch가 'x' 또는 'X' 일때 true인 조건식
  
      if( ch=='x' || ch=='X' ) {  }

- int형 변수 n이 4의 배수이고 100의 배수이거나 400의 배수이면 true인 조건식
   
       if( n%4==0 && n%100!=0 || n%400==0 ) {  }
   
- char형 변수 ch가 'y' 나 'Y'가 아닐때 true인 조건식
 
     if( ch!='y' && ch!='Y' ) {  }

- char형 변수 ch가 영문자 일때 true인 조건식
  
      if( ch>='A' && ch<='Z' || ch>='a'&& ch<='z' ) {  }
      if( ch>=65 && ch<=90 || ch>=97 && ch<=122 )  {  }
   
- char형 변수 ch가 영문자가 아닐때 true인 조건식
  
      if(!(ch>='A' && ch<='Z') && !(ch>='a'&& ch<='z')) {  }

- boolean형 변수 b가 false 일 때 true인 조건식

      if( b==false ) {  }
      if( ! b ) {  }

 참고 :: [Scanner > charAt() 에 대한 부가 설명](https://github.com/friedegg818/TIL/blob/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/Test_Scanner.java)

#

<if~else 문>
-if 다음의 조건이 참일 경우와 거짓일 경우에 따라 각각 다른 문장을 수행하고자 할 때
-형식   if(조건식) {
       실행문_1;
	 } else {
	   실행문_2;
	 }
	 
import java.util.Scanner;

public class IfelseEx7 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		String s;
		
		System.out.print("정수?");
		n=sc.nextInt();
		
		if(n%2==0) {
			s="짝수";
		} else     {
			s="홀수";
		}
	    System.out.println(n+":"+s);
	}
}

<다중 선택 if 문> - else if 문
-if문의 처음 조건식이 거짓일 경우 계속된 다른 범위의 값을 추출하기 위해 
-형식  if(조건식_1) {
      실행문_1;
     } else if(조건식_2) {
      실행문_2;
	 } else if(조건식_n) {
      실행문_n; 
	 } else {
	  실행문_o;
	 } 
	  실행문_p;

     조건1이면 실행문1.
	 '그렇지 않고' 조건2면 실행문2.
	 '그렇지 않고' 조건n면 실행문 n.

import java.util.Scanner;

public class IfelseifEx8 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		
		System.out.print("정수?");
		n=sc.nextInt();
		
		if(n%2==0 && n%3==0) {   //  if(n%6==0)  {
			System.out.println(n+" : 2 와 3의 배수");
		} else if(n%2==0) {
			System.out.println(n+" : 2의 배수");
		} else if(n%3==0) {
			System.out.println(n+" : 3의 배수");
		} else {
			System.out.println(n+" : 2 또는 3의 배수가 아님");
		}
		
		// if 문의  순서를 바꿔도 되지만, 바꾸면 안되는 경우도 있다.
		
		sc.close();
	}
}

import java.util.Scanner;

public class IfelseifEx9 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		
		System.out.print("점수?");
		n=sc.nextInt();
		
		if(n>=90)  {
			System.out.println(n+": 수");
		} else if(n>=80) {   // } else if(n>=80 && n<90)  {
			System.out.println(n+": 우");
		} else if(n>=70) {
			System.out.println(n+": 미");
		} else if(n>=60) {
			System.out.println(n+": 양");
		} else {
			System.out.println(n+": 가");
		}
		
		sc.close();		
	}
}

import java.util.Scanner;

public class IfelseifEx10 {    // IfEx6 예제 
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		char ch;
		// if ~ else if 로 코딩하는 것이 더 효율적 
		
		System.out.print("문자?");
		ch=sc.next().charAt(0);
		
		if(ch>='A'&&ch<='Z') {
			System.out.println(ch+" : 대문자");
		} else if (ch>='a'&&ch<='z') {
			System.out.println(ch+" : 소문자");
		} else {
			System.out.println(ch+" : 기타문자");
		}
		
		sc.close();
	}
}

<if 문 중첩>
-if문 안에 또 다른 if문을 두는 제어 구조 
-형식 if(조건식_1) {
       if(조건식_2) {
	    실행문_1;
	   } else {
	   실행문_2;
	   } 
     } else { 
       실행문_3;
     }	   

import java.util.Scanner;

public class IfTest5 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a;
		
		System.out.print("점수?");
		a=sc.nextInt();
		
		if(a>=0 && a<=100) {          // 점수 입력이 올바른 경우 
		   if(a>=95) {
			   System.out.println("점수 : "+a+"평점 : 4.5");
			} else if(a>=90) {
				   System.out.println("점수 : "+a+"평점 : 4.0");
			} else if(a>=85) {
				   System.out.println("점수 : "+a+"평점 : 3.5");
			} else if(a>=80) {			
				   System.out.println("점수 : "+a+"평점 : 3.0");
			} else if(a>=75) {
				   System.out.println("점수 : "+a+"평점 : 2.5");
			} else if(a>=70) {
				   System.out.println("점수 : "+a+"평점 : 2.0");
			} else if(a>=65) {
				   System.out.println("점수 : "+a+"평점 : 1.5");
			} else if(a>=60) {
				   System.out.println("점수 : "+a+"평점 : 1.0");
			} else {
				   System.out.println("점수 : "+a+"평점 : 0.0");
			}
		   
		} else {
			System.out.println("입력오류");
		}
		
		sc.close(); 
	}
}

package test0131;

import java.util.Scanner;

public class IfTest6 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int t; 
		
		System.out.print("근무시간?");
		t=sc.nextInt();
		
		if (t>0 && t<=8) {
			System.out.printf("급여 : "+"%,d%n" ,t*10000);
		} else if (t>8) {
	     	System.out.printf("급여 : "+ "%,d%n", (t-8)*15000+80000);
		}	
		
		sc.close();
		
		/* 
		 int h, pay;
		 
		 System.out.print("근무시간?");
		 h = sc.nextInt();
		 
		 if (h>8) {
		     pay = 8*10000 + (int)((h-8)*10000*1.5);		 
		 } else {
		     pay = h*10000; 
		 }
		 
		 System.out.printf("급여 : %,d\n", pay);
		 
		 sc.clsoe();
		 
		 */
		}
}

import java.util.Scanner;

public class IfEx1 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int a,b;
		char oper; 
		
		System.out.print("두 수?");
		a=sc.nextInt();
		b=sc.nextInt();
		
		System.out.print("연산자 [+,-,*,/]?");
		oper=sc.next().charAt(0);
			
		if(oper=='+') {
			System.out.printf("%d + %d = %d%n", a, b, a+b);
		} else if(oper=='-') {
	     	System.out.printf("%d - %d = %d%n", a, b, a-b);
	    } else if(oper=='*') {
	    	System.out.printf("%d * %d = %d%n", a, b, a*b);
	    } else if(oper=='/') {
	    	System.out.printf("%d / %d = %d%n", a, b, a/b);
        } else {
	    	System.out.println("연산자 입력 오류 !!!");
        }	
	     	sc.close();
	}
}

import java.util.Scanner;

public class IfEx2 {
	public static void main(String[] args) {
		Scanner sc = new Scanner(System.in);
	    int a,b,c;
		int tot;
		double ave;
		String name;
		
		System.out.print("이름?");
		name=sc.next();
		
		System.out.print("세과목 점수?");
		a=sc.nextInt();
		b=sc.nextInt();
		c=sc.nextInt();		
		
		tot=a+b+c;
		ave=(double)tot/3;
		
		if(a>=40 && b>=40 && c>=40 && ave>=60) {
			System.out.println(name+"님은 "+"합격 "+"입니다."); 
		} else if(ave<60) {
		   System.out.println(name+"님은 "+"불합격 "+"입니다.");
		} else { // (a<40 || b<40 \\ c<40) && ave>=60 
			System.out.println(name+"님은 "+"과락 "+"입니다.");
		}
		
		// 식이 간단해 질 수 있는 조건 찾기 
		
		sc.close();				
			
	}
}

import java.util.Scanner;

public class IfEx3 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String hak,name; // 학번.주민.우편.계좌번호 등은 반드시 문자열로 받아야 함 
		int s1, s2, absence, report;
		int score1, score2, attendscore, reportscore;
		int score;
		char grade; 
		
		System.out.print("학번?");
		hak=sc.next();
		System.out.print("이름?");
	    name=sc.next();
	    System.out.print("중간고사 점수?");
		s1=sc.nextInt();
		System.out.print("기말고사 점수?");
		s2=sc.nextInt();
		System.out.print("결석횟수?");
		absence=sc.nextInt();
		System.out.print("레포트 점수?");
		report=sc.nextInt();
		
		//환산점수 계산
		//중간,기말고사 		
		score1=(int)(s1*0.4);
		score2=(int)(s2*0.4);
		//결석점수
		if(absence>=6) 
			attendscore=0;
		else if (absence>=4)
	        attendscore=50;
	    else if (absence>=2)
	     	attendscore=80;
	    else 
	     	attendscore=100;
		attendscore=(int)(attendscore*0.1);
		//리포트점수
		reportscore=(int)(report*0.1);
		//총합
		score=score1+score2+attendscore+reportscore;
		//학점계산
		if(score>=90) grade='A';
		else if(score>=80) grade='B';
		else if(score>=70) grade='C';
		else if(score>=60) grade='D';
		else grade='F';
		//출력
		System.out.print("학번\t이름\t중간\t기말\t출석\t");
		System.out.println("리포트\t합산점수\t학점");
		System.out.print(hak+"\t"+name+"\t"+score1+"\t");
		System.out.print(score2+"\t"+attendscore+"\t");
		System.out.println(reportscore+"\t"+score+"\t"+grade);
		
		sc.close();
	  }
	}
	
<switch~case 문> - 다중 선택문
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
	
[반복문]	
	
<while 문> 
- 조건식을 먼저 비교하여 조건식이 참인 경우 특정 영역을 반복 수행하는 문장
- 반복 횟수가 정해지지 않은 경우에 가장 많이 쓰인다.
- 처음 조건식이 false인 경우 실행문은 단 한 번도 실행하지 않는다.
- 형식   while(조건식)  {
             ※ 조건식은 반드시 true, false (정수X) 
			    조건식 자체가 true인 경우, 무한 루프가 된다.  
			 ※ while 속에 while, 다른 반복문도 가능 	
          실행문;
			 ※ 1개인 경우 생략 가능(그래도 써주는게 좋음)	
        } 		
		
public class whileEx1 {
	public static void main(String[] args) {
		int n;
		
		n=0; // 초기화가 필요
		while(n<10) { // while(조건) { 조건>:true 또는 false만 가능 
			n++;
			System.out.println("안:"+n); // 10번 반복 실행 
		}
		System.out.println("밖:"+n);
	 }
}

public class whileEx2 {
	public static void main(String[] args) {
		int n;
		
		n=0; 
		while(n<10) { 
			n+=2;
			System.out.println("안:"+n); // 2 4 6 8 10 
		}	System.out.println("밖:"+n); // 10 
	 }
	}

public class whileEx3 {
	public static void main(String[] args) {
		int n;
		
		n=1; 
		while(n<10) { 
			n+=2;
			System.out.println("안:"+n); // 3 5 7 9 11 
		}	System.out.println("밖:"+n); // 11 
	 }
	}

public class whileEx4 {
	public static void main(String[] args) {
		int n;
		
		n=1; 
		while(n<10) { 
			System.out.println("안:"+n); // 1 3 5 7 9
			n+=2; // 3 5 7 9 11
		}	
		System.out.println("밖:"+n); // 11
	 }
	}

public class whileEx5 {
	public static void main(String[] args) {
		int n;
		
		n=0; 
		while(n++ < 10) { 
			System.out.println("안:"+n); // 1 2 3 4 5 6 7 8 9 10
		}	
		System.out.println("밖:"+n); // 11
	 }
	}

/*
 n=0 
 n<10 → n++(1)
 System.out.println("안:"+1);

 n=1
 n<10 → n++(2)
 System.out.println("안:"+2);
 .
 .
 n=8
 n<10 → n++(9)
 System.out.println("안:"+9);
 
 n=9
 n<10 → n++(10)
 System.out.println("안:"+10);
 
 n<10 : false, n++(11)
 System.out.println("밖:"+11);
 */

 public class whileEx6 {
	public static void main(String[] args) {
		int n;
		
		n=0; 
		while(++n < 10) { 
			System.out.println("안:"+n); // 1 2 3 4 5 6 7 8 9
		}	
		System.out.println("밖:"+n); // 10 
	 }
	}
	
public class WhileEx7 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<10) {
			n++;
			s+=n;
			System.out.println(n+","+s);
		}
		System.out.println("결과:"+s);
		
	}
}

public class WhileEx8 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<100) { // 1~100까지 합 
			n++;
			s+=n;
		}
		System.out.println("결과:"+s);
		
	}
}

public class WhileEx9 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(++n<10) { //  
			s+=n;
		}
		System.out.println("결과:"+s); // 1~9까지합 : 45 
		
	}
}

public class WhileEx10 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n++<10) { //  
			s+=n;
		}
		System.out.println("결과:"+s); // 1~10까지합 : 55 
		
	}
}

public class WhileEx11 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<100) { 
			n+=2;
			s+=n;
		}
		System.out.println("짝수합:"+s); // 
	}
}

public class WhileEx12 {
	public static void main(String[] args) {
		int n,s;
		
		// 1+3+...+97+99 
		n=0;
		s=0;
		while(++n<100) { 
			s+=n;
			n+=1;
		}
		/*
		 n=1;
		 s=0;
		 while(n<100) {
		 	s+=n;
		 	n+=2;              최적의 프로그램 
		 */
		
		System.out.println("홀수합:"+s); // 2500
	}
}

public class WhileEx13 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<100) {    
			n++;
			if(n%2==1)
			s+=n;        // 반복 횟수가 100번 > 안 좋은 방법 
		}
			
		System.out.println("홀수합:"+s); // 
	}
}

public class whileEx14 {
	public static void main(String[] args) {
		int n,s;
		
		// 1*2*3*...*9*10		
        n=0;
        s=1;
        
        while (n<10) {
        	++n; 
        	s=s*n;  // s*=n;
        } 
         System.out.println("결과 : " + s);
         
	}
}

import java.util.Scanner;

public class whileEx15 {
	public static void main(String[] args) {
		//정수를 입력 받아 1부터 입력 받은 수까지 합 구하기 
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s;
		
		System.out.print("정수?");
		num=sc.nextInt();
		
		n=0;
		s=0;
		
		while (n<num) {   // 감이 안잡히면 1~10까지 합 구하는 법 먼저 적고 생각
			n++;
			s+=n;  
		}
		System.out.println("결과:"+s);
			
		sc.close();		
	}
}

public class whileEx16 {
	public static void main(String[] args) {
		//정수를 입력 받아 1부터 입력 받은 수까지 홀수 합 구하기 
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s;
		
		System.out.print("정수?");
		num=sc.nextInt();
		
		n=1;
		s=0;
		
		while (n<=num) {   
			s+=n; 
			n+=2;			 
		}
		System.out.println("결과:"+s);
			
		sc.close();		
	}
}

import java.util.Scanner;

public class whileEx17 {
	public static void main(String[] args) {
		//정수를 입력 받아 1부터 입력 받은 수까지 홀수를 
		//한 줄에 5개씩 출력하고 마지막에  합 구하기    
		Scanner sc=new Scanner(System.in);
		int num;
		int n, s, cnt;
		
		System.out.print("정수?");
		num=sc.nextInt();
		
		n=1;
		s=0;
		cnt=0;
		
		while (n<=num) {   
			s+=n; 
			System.out.print(n+"\t");   
			// n : 홀수 만들기, s: 합 구하기 > n or s는 건드리면 안 됨 > 새로운 변수 필요 
			cnt++;  // 홀수 출력 개수 카운트 
			if(cnt%5==0) // 한줄에 5개 출력했으면 라인 넘기기 
				System.out.println();
			
			n+=2; // 홀수 만들기  
		}
	    if(cnt%5!=0)
			System.out.println(); 
		
		System.out.println("결과:"+s);  //  "\n결과:" 로 하면 5로 떨어질 경우 한 줄 더 띄워짐 
			
		sc.close();		
	}
}

import java.util.Scanner;

public class whileEx18 {
	public static void main(String[] args) {
		// 정수를 입력 받아 입력 받은 숫자의 각 자리의 합을 구하기 
		Scanner sc=new Scanner(System.in);
		int n, s;
		n=0; // 초기화. but 꼭 주지 않아도 됨. 대신 주려면 입력 전에 줘야 함 
		s=0;
		
		System.out.print("숫자를 입력하세요."); 
		n=sc.nextInt();
			
		while (n!=0) {
			s += n%10; // s에 n을 10으로 나눈 나머지를 더하기 
			           // 어떤 숫자를 10으로 나누면 맨 끝자리 수가 나옴
		System.out.printf("sum=%3d num=%d%n", s,n);
		               // %3d > 정수를 3자리로 표현 
		
		n /= 10; // n을 10으로 나눈 몫을 다시 n에 부여  
		         // (=마지막 자리 수 떼고 남은 수) 
	}
		System.out.println("각 자리수의 합:"+s);
		
		sc.close();		
	}
}

public class whileEx19 {
	public static void main(String[] args) {
		// 1부터 몇까지 더하면 누적합계가 100을 넘지 않는 제일 큰 수가 되는가 
		int s=0;
		int n=0;
		
		while ((s+=++n) <= 100) {
			// s → n의 값을 1씩 증가시켜서 합한 값 
			// 이러한 s가 100을 넘지 않으면 ↓ 같은 형식으로 출력 			
			System.out.printf("%d - %d%n", n, s);
			}
	}
}

public class whileEx20 {
	public static void main(String[] args) {
		//단을 입력 받아 입력 받은 단의 구구단 출력 
		Scanner sc=new Scanner(System.in);
		int dan, n; 
		
		System.out.print("단[1-9]?");
		dan=sc.nextInt();
		
		n=0;
		while (n<9) {
			n++; 
			System.out.printf("%d*%d=%d\n", dan,n,dan*n);
		}
		sc.close();
	}
}

public class whileEx21 {
	public static void main(String[] args) {
		// 1~100까지 합을 출력하되 수가 10의 배수가 될 때마다 합 출력 
		// 1~10 : 55
		// 1~20 : 210
		//      :
		// 1~100 : 5050 
	
	int n, s;
	n=0;
	s=0;
	
	while (n<100) {
		++n;
		s+=n;
		
		if (n%10==0) {
			System.out.println("1~"+n+"까지 합:"+s);
		}  
		
	} 
	
public class whileEx22 {
	public static void main(String[] args) {
		// 1+(1+2)+(1+2+3)+...+(1+2+...+10) 결과 
		int n, s, ss;
		
		n=0;
		s=0;
		ss=0;
		
		while (n<10) {
			n++;
			s+=n;
			ss+=s; 
			
		} System.out.print("결과:"+ss);
					
	}
}

public class whileEx23 {
	public static void main(String[] args) {
		// 1/2 + 2/3 + ... + 9/10 결과 
		
		int n;
		double s;
		
		n=0;
		s=0;
		
		while (n<9) {
			n++; 
			s += (double)n/(n+1);			
		}
		// System.out.println("결과:"+s); 
		System.out.printf("결과: %.2f\n",s);
	}
}

<do~while 문> 
-while문과 같이 특정한 영역 반복 수행. 
-조건식을 나중에 비교 > '적어도 한 번'은 실행한다. 
-형식		do	{
		실행문;
		} while(조건식);

public class WhileEx1 {
	
	public static void main(String[] args) {
/*
		int n=0;
		
		do {
			n++;
			System.out.println("안:"+n);
		} while(n<10);
		System.out.println("밖:"+n);
*/
/*	
		int n, s;
		n=s=0;
		
		do {
			n++;
			s+=n;
		} while(n<10);
		System.out.println("결과:"+s);
*/
		int n=10;
		while(n<10) { // 처음 조건을 만족하지 않으면 한번도 실행 X (첫 조건이 중요)
			n++;
			System.out.println("while 안:"+n);
		}
		System.out.println("while 밖:"+n);
		
		n=10;
		do { // 적어도 한번은 실행 
			n++;
			System.out.println("do~while 안:"+n);
		} while(n<10);
		System.out.println("do~while 밖:"+n);
	
	}
}

import java.util.Scanner;

// 단을 입력 받아 구구단 출력. 단, 입력 받은 단이 1~9를 벗어나면 재입력.
public class WhileEx2 {

	public static void main(String[] args) {
		int dan, n;
		Scanner sc=new Scanner(System.in);
		
		do {
			System.out.print("단?");
			dan=sc.nextInt();
		} while(dan<1 || dan>9);
			
		n=0;
		while(n<9) {
			n++;
			System.out.printf("%d*%d=%d%n",dan,n,dan*n);
		}
			sc.close();		
	}
}

import java.util.Scanner;

// 단을 입력 받아 구구단 출력. 단, 입력 받은 단이 1~9를 벗어나면 재입력.
public class WhileEx3 {

	public static void main(String[] args) {
		int dan=0, n;
		boolean b;
		Scanner sc=new Scanner(System.in);
		
		// do~while문으로 작성하는 것이 더 효율적임 
		b=true;
		while(b) {
			System.out.print("단?");
			dan=sc.nextInt();
			if(dan>=1 && dan<=9)
				b=false;
		} 
			
		n=0;
		while(n<9) {
			n++;
			System.out.printf("%d*%d=%d%n",dan,n,dan*n);
		}
			sc.close();		
	}
}

public class WhileEx4 {

	public static void main(String[] args) {
		int n;
		int s,cnt;

		n=s=cnt=0;
				
		while (n<100) {
			n++;
			if(n%3==0 || n%5==0) {
				s+=n; // 합
			    cnt++; // 개수
			}
		  }
		System.out.println("합:"+s);
		System.out.println("평균:"+(s/cnt));
	}
}

※ while 기본 문제 풀이 ※

import java.util.Scanner;

public class Whiletest1 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int num;
		int n,s,s1,s2;
				
		System.out.print("수?");
		num=sc.nextInt();
		
		n=0;
		s=s1=s2=0;
				
		while (n<num) {
			n++;
			s+=n; 	
			if(n%2==0)
				s1+=n; // 짝수합
			else 
				s2+=n; // 홀수합
		}
		System.out.println("1~"+n+"까지의 합 ="+s);
		System.out.println("1~"+n+"까지의 짝수합 ="+s1);
		System.out.println("1~"+n+"까지의 홀수합 ="+s2);
		
		sc.close();
	}
	}
	
public class Whiletest2 {

	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		
		while (n<10) {
			n++;
			s+=n;
			n++;
			s-=n;
		}
		System.out.println("결과 :"+s);
	}
}

public class Whiletest3 {
	
	public static void main(String[] args) {
		char a;
		int cnt;
		
		a='A';
		cnt=0;
		while(a<='Z' ) {
			System.out.print(a+"\t");
			cnt++; // 출력 개수
			if(cnt%5==0) System.out.println();			
			a++; // 형변환이 일어나지 않아서 가능 
		}
			
	}
}

public class Whiletest5 {

	public static void main(String[] args) {
		int n,s;
		
		s=n=0;
		
		while (s<=100)  {
			n++;
			s+=n; 
		} 
		System.out.println("최소의 n : "+n);
		System.out.println("합  : " +s);
	}
}

import java.util.Scanner;

public class Whiletest6 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n1,n2,temp;
		int s,n;
		
		System.out.print("두 수?");
		n1=sc.nextInt();
		n2=sc.nextInt();
		
		if (n1>n2) { // 적은수는 n1, 큰수는 n2에 저장 
			temp=n1; n1=n2; n2=temp;
		}
		
		s=0;
		n=n1;
		while(n <= n2) {
			s+=n;
			n++;
		}
		System.out.println("결과 : "+s);
		
		sc.close();
	}
}

public class Whiletest7 {

	public static void main(String[] args) {
		int x,y,t;
			
		x=100;
		y=0;
		t=0;
		
		while (x>=y) { // 만나는건 따라잡는게 아님. 초과해야 함 
			t++;
			x+=2;
			y+=5;		
		} System.out.println("x : "+x+" y : "+y);
		  System.out.println("걸린시간 : "+t+"초");
		
	}
}

public class Whiletest8 {
	public static void main(String[] args) {
		int n,s,t; 
		
		n=0; s=0;
		t=1;		
		while (n<20) {
			// System.out.print(t+" "); 1 2 4 7 11.. 나열하기 
			s+=t;
			n++;
			t+=n;
		}
		System.out.println("결과:"+s);
	}
}

public class Whiletest9 {
	public static void main(String[] args) {
		// 피보나치수열 
		// 앞에 2개 초기값 무조건 주고 시작 
		int a=1, b=1, c;
		int s, n;
		
		n=2;
		s=2;
		while(n<8) {
		//	System.out.println(a+","+b);
			c=a+b;
			s+=c;
			a=b;
			b=c;
			n++;
		}
		System.out.println("결과:"+s);
	}
}

<for 문>
- 반복횟수가 정해져 있을 때 사용되는 반복문 
- 형식 	for (초기식 ; 조건식 ; 증감식) {
			실행문				
			}
	·초기식 - 무조건 실행
	·조건식 - 반드시 true or false. 참이면 실행문 수행. 
	·증감식 - 실행문 수행 후 재초기 (초기값 변경)
	·다시 조건식 > 참 > 실행 > 증감식 > .... 
	·거짓이면 for문을 빠져나감 
- for <-> while 

public class ForEx1 {
	public static void main(String[] args) {
		int n;

		/*
		for(n=1; n<=10; n++) { //for(초기;조건;증감식) {
			System.out.println("안:"+n);
		}
		*/
		
		n=1; 
		for( ; n<=10 ; ) {
			System.out.println("안:"+n);
			n++;
		}
		System.out.println("밖:"+n);
	}
}

public class ForEx2 {
	public static void main(String[] args) {
		int n;
/*
		for(n=1; n<=10; n+=2) { // 홀수 
			System.out.println("안:"+n);  // 1 3 5 7 9 
		}
		System.out.println("밖:"+n); // 11
*/
	
		for(n=2; n<=10; n+=2) { // 짝수 
			System.out.println("안:"+n); // 2 4 6 8 10
		}
		System.out.println("밖:"+n); // 12
	}
}

public class ForEx3 {
	public static void main(String[] args) {
		
		// for에서 변수 선언 가능 → for문을 벗어나면 쥬금 
		for(int n=1; n<=5; n++) {
			System.out.println("안:"+n);
		}
		// System.out.println("밖:"+n); // 컴파일 오류. 
			// for에서 선언한 변수는 밖에서 사용 불가 
	}
}

public class ForEx4 {
	public static void main(String[] args) {
		/* 1~100까지 합 구하기 
		int s=0; 
		
		for(int n=1; n<=100; n++) {
			s+=n;
		}
		System.out.println("결과:"+s); */
		
		/* 1~100까지 홀수 합 구하기 
		 int s=0; 		
		 
		for(int n=1; n<=100; n+=2) {
			s+=n;
		}
		System.out.println("홀수합:"+s); */
		
		/* 1~100까지 홀수 합 구하기 
		int s, n;
		for(n=2, s=0; n<=100; n+=2) { // 초기값에서 , 찍고 초기값 가능 (증감식도 가능)
			s+=n;
		}
		System.out.println("짝수합:"+s); */
		
		int s, n;
		for(n=1, s=0; n<=100; s+=n, n++) // 권하지 않는 방식 
			;
		System.out.println("합:"+s);
		
	}	
}

public class ForEx5 {
	public static void main(String[] args) {
		
	/* int n;
		for(n=10; n<=1; n++) { // 조건을 만족하지 않으면 한 번도 실행 안 함 
			System.out.println("안:"+n);
		}
		System.out.println("밖:"+n); // 10  
											*/
		
		int n;
		for(n=10; n>=1; n--) {
			System.out.println("안:"+n); // 10 9 ... 2 1
		}
		System.out.println("밖:"+n); // 0 
	}
}

public class ForEx6 {  // for문 이해가 어려울 때 참고 할 것 
	public static void main(String[] args) {
		int n, s;
		s=0;
		for(n=1; n<=10; n++) {
			s+=n;
			System.out.println("안:"+n+","+s);
		}
		System.out.println("밖:"+n+","+s);
	}
}

public class ForEx7 {
	public static void main(String[] args) {
		// A~Z 출력(단, 한줄에 5개씩)
		int cnt=0;
		for(char a='A'; a<='Z'; a++) {
			System.out.print(a+" ");
			if(++cnt%5==0) {
				System.out.println();
			}
		}
	}
}

public class ForEx8 {
	public static void main(String[] args) {
		// 1~100까지 수 중 3 또는 5의 배수를 한줄에 5개씩 출력하고 
		// 마지막에 합과 평균 출력 
		
		int cnt=0;
		int s=0;
		for(int n=1; n<=100; n++) {
			if(n%3==0 || n%5==0) {
				System.out.printf("%5d",n); // 자리수 맞추기 위해 printf 사용
				s+=n;
				if(++cnt%5==0) {
				System.out.println();
				}
			}
		} 
		  System.out.println("\n합:"+s); // 라인 내려주기 위해 \n
		  System.out.printf("평균:%d%n", s/cnt);
	}
}

public class ForEx9 {
	public static void main(String[] args) {
		int i;
		for(i=1; i<=10; i++) {
			System.out.println("안:"+i); // 1번 반복
			i=10; // for문 안에서 반복문에 사용된 변수를 변경하면
			      // 반복 횟수가 바뀐다.
		}
		System.out.println("밖:"+i);
	}
}

※무한루프 설명
public class Fortest9 {
	public static void main(String[] args) {
		
		
/*		int s, n;
		s=n=0;
		while(n<10) {
			n++;
			s+=n;
		}
		System.out.println(s); 


		int s=0;
		for(int n=1; n<=10; n++) {
			s+=n;
		}
		System.out.println(s);

	// break : switch~case, while, do~while, for문 탈출
		int s=0, n=0;
		while(true) { // 무한루프(infinite loop)
			n++;
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);

		int s=0, n=0; 
		for( ;  ; ) { // 무한루프(infinite loop)
			n++;
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);	
*/
		
		int s,n;
		for(s=0,n=1;  ; n++) { // 무한루프(infinite loop)
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);	
	}
}

public class Fortest10 {
	public static void main(String[] args) {
		
		int count=0;
		
/*
 	float a=2000000000, b=2000000050; 
 	System.out.println(a==b); // true 
 				float형은 정밀도가 낮아 a와 b를 같은 숫자로 봐버림
 				-> 반복횟수에 쓰지 않는다.  
 				& 실수는 증감형으로 쓰지 않는다. 
 				  정확한 결과가 나오지 않을 수 있기 때문에 
 */		
		for(float f=2000000000; f<2000000000+50; f++) {
			count++;
		}
		System.out.println(count); // 0
	}
}

※최대값 구하기 

import java.util.Scanner;

public class quiz5 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		int max;
		
		max=0; 
		System.out.print("5개의 정수를 입력 하세요...");
		for(int i=1; i<=5; i++) {
			n=sc.nextInt();   
			if(i==1) { // 처음 입력 받은 수를 max의 초기값으로 
				max=n; 
			} else if(max<n) { // 그 후로는 초기값과 입력받은 값을 비교
				max=n;
			}
		}
		System.out.println("최대값:"+max);
		
		sc.close();
	}
}

public class quiz5_1 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int n;
		int max;
		
		max=Integer.MIN_VALUE; // 가장 적은 값을 초기값으로
		System.out.println("5개 정수 입력...");
		for(int i=1; i<=5; i++) {
			n=sc.nextInt();
			if(max<n) {
				max=n;
			}
		}
		System.out.println("최대값:"+max);
		
		sc.close();
	}
}

<다중 for문> 
-for문 안에 다른 for문을 포함한 문 (중첩 횟수 제한 X) 
-형태 	for(  ;  ;  )
			for(  ;  ;  )
			
			}
			
		}
		
public class ForEx1 {
	public static void main(String[] args) {
		for(int i=1; i<=3; i++) {     // 3번 실행 
			System.out.println("i:"+i);
			for(int j=1; j<=2; j++) {  // 3*2 6번 실행 
				System.out.println("i:"+i+", j:"+j);
			}
			System.out.println("---------------"); // 3번 실행 
		}
	}
}

public class ForEx2 {
	public static void main(String[] args) {
		for(int i=1; i<=3; i++) {    
			System.out.println("i:"+i);
			for(int j=1; j<=i; j++) {  // 1+2+3 6번 반복
				System.out.println("i:"+i+", j:"+j);
			}
			System.out.println("---------------");  
		}
	}
}

public class ForEx3 {
	public static void main(String[] args) {
		
		int c;
		
		System.out.println("구구단");
		for(int a=2; a<=9; a++) {
			System.out.println(">>"+a+"단<<");
			for(int b=1; b<=9; b++) {
				c=a*b;
				System.out.printf("%d*%d=%2d\n", a,b,c);
             }
			System.out.println("-----------------\n");
	     }
      }
   }

public class ForEx4 {
	public static void main(String[] args) {
		
		int c;
		
		System.out.println("구구단");
		for(int a=2; a<=9; a++) {
				for(int b=1; b<=9; b++) {
				c=a*b;
				System.out.printf("%d*%d=%2d\t", a,b,c);
             }
			System.out.println();
	     }
      }
   }

public class ForEx5 {
	public static void main(String[] args) {
		
		/*for(int i=1; i<=10; i++) {
			for(int j=i; j<=i+9; j++) {
				System.out.printf("%3d", j);
			}
			System.out.println(); */
	
	
		int i,j;         // for를 while로 바꾸기 
		i=1; 					
		while(i<=10) {
			j=i;			
			while(j<=i+9) { 
				System.out.printf("%3d", j);
				j++;
			} 
			System.out.println();
			i++;
	     }
    }
}

public class ForEx6 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=i; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		
		System.out.println();
		
		for(int i=5; i>=1; i--) {
			for(int j=1; j<=i; j++) {
				System.out.print("*");
			}
			System.out.println();
		}		
	}
}

public class ForEx7 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=5-i; j++) {
				System.out.print(" ");
			}
			for(int j=1; j<=i; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		
		
		System.out.println(); // for문을 2번만 사용하기 
		
		for(int i=0; i<5; i++) {   // 줄 수 
			for(int j=5; j>0; j--) { // 한 줄에 출력하는 수 
				System.out.print(j<=i+1?"*":" ");
			} 
			System.out.println();
		} 
				
	}
}

public class ForEx8 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=5-i; j++) { // 앞 공백 (손대지x) 
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) {
				System.out.print("*");
			}
			System.out.println();
		}

System.out.println(); // for문을 2번만 사용하기 
		
		int s=9;
		for(int i=s/2+1; i<=s; i++) {
			for(int j=0; j<i; j++) {  // 조건식에 숫자 외에 바깥에 있는 변수도 가져다 쓸 수 있다 
				                      // 반복횟수가 달라짐 
				System.out.print((s-i)<=j?"*":" ");
			}
			System.out.println();
		}
				
	}
}

public class ForEx9 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=5-i; j++) {  
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		
		for(int i=4; i>=1; i--) {   // 이것만 뒤집어 주면 됨 
			for(int j=1; j<=5-i; j++) {  // 공백 1,2,3,4 
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) { // * 7,5,3,1 
				System.out.print("*");
			}
			System.out.println();
		}
		System.out.println();
		
		int s=5; // 홀수만 가능 
		int n;		
		n=s/2;
		for(int i=0; i<s; i++) {
			for(int j=0; j<s-n; j++) { // n으로 증감을 조정 
				System.out.print(j>=n?"*":" ");
			}
			n=i<(s/2)?n-1:n+1;
			System.out.println();
			}				
		
		}
}

※ 난수 

public class RandomEx {

	public static void main(String[] args) {
		int n;
		// 0 <= Math.random() < 1 사이의 난수 
		//			ex) 0.1, 0.07, 0.000005 ... 
		for(int i=1; i<=100; i++) {
			n = (int)(Math.random()*100)+1; // *100하면 아무리 커도 99 
											// > n은 1~100사이의 난수
			System.out.printf("%5d", n);
			if(i%10==0)
				System.out.println();
		}
	}
}

 import java.util.Scanner;

public class whilequiz6 {

		public static void main(String[] args) {
			Scanner sc=new Scanner(System.in);
			int com, user, cnt;
			
			// 1~100 사이 난수 발생 
			com = (int)(Math.random()*100)+1;
			
			// 카운트 변수 초기화 
			cnt=0;
			while(true) { // 무한 루프 
				System.out.println("수?");
				user=sc.nextInt();
				cnt++;
				
				if(com>user) {
					System.out.println("입력한 수보다 더 큽니다.");
				} else if(com<user) {
					System.out.println("입력한 수보다 더 작은 수 입니다.");
				} else {
					System.out.println(cnt+"번에 성공했습니다."); 
					break; // 같으면 무한 루프를 빠져나옴 
				}
			}
			
			sc.close();
		}
}

import java.util.Scanner;

public class HapEx {

	// 1~4를 누르면 각각의 연산(1~입력한 숫자까지)을 수행하는 프로그램 짜기 
	
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int num, s;
		int ch;
		int start, offset; // start>시작값, offset>증가분
		
		while(true) {
			do {
				System.out.print("1.합 2.홀수합 3.짝수합 4.종료 =>");
				ch=sc.nextInt();
			} while(ch<1||ch>4);
			
			if(ch==4) break;  // 4를 누르면 프로그램 종료
			
			System.out.print("원하는 수?");
			num=sc.nextInt();
			
			switch(ch) {
			case 1: start=1; offset=1; break; // 자연수합
			case 2: start=1; offset=2; break; // 홀수합
			default: start=2; offset=2; break; // 짝수합 
			} // case 3: 으로 쓸 경우 start와 offset을 초기화 해야 함. 
			
			s=0;
			for(int i=start; i<=num; i+=offset) {
				s+=i;
			}
			System.out.println("결과 : "+s);
		}
		
		sc.close();
	}
}

<break 문> 
- 반복문(while/do while/for), switch문 내의 블록으로부터 빠져나오기 위해 사용
- if문에서는 절대 사용 X  
- break 라벨명: 
  1)반복문이 다중으로 작성된 경우 특정한 반복문을 빠져 나오기 위해 사용 
  2)빠져나오려는 반복문 윗줄에 <라벨명:> 적어줌. 라벨명은 어떤 것이든 상관 X 
  3)한 프로그램에서 동일한 이름으로 라벨명 사용 불가 
  4)빠져나오려고 할 때 <break 라벨명;> 작성
  
import java.util.Scanner;

public class BreakEx1 {

	public static void main(String[] args) {
		// 정수를 입력 받아 입력 받은 수의 합 구하기
		// 단, 입력 받은 수가 0이면 프로그램 종료 
		Scanner sc=new Scanner(System.in);
		int n,s;
		
		s=0;
		System.out.print("정수입력[종료 : 0]?");
		while(true) {
			n=sc.nextInt(); // 숫자를 계속적으로 입력 
			if(n==0) break; // 0을 누르면 숫자 입력+밑의 실행문 종료 
			
			s+=n;
		}
		
		System.out.println("결과 : "+s);
		
		sc.close();
	}
}  
  
 <continue 문> 
- 반복문(while/do while/for)만 영향을 받음
- continue를 만나면 다시 조건식으로 올라가라는 뜻 
- continue 라벨명:
  1)반복문이 다중으로 작성된 경우 두개 이상의 반복문 조건식으로 올라가기 위해 사용되는
  2)다시 시행하려는 반복문 윗줄에 <라벨명:> 

import java.util.Scanner;

public class ContinueEx1 {

	public static void main(String[] args) {
		// 5개의 홀수를 입력 받아 입력 받은 홀수의 합 구하기 
		// 단, 입력 받은 수가 0보다 적거나 짝수이면 다시 입력 받기 
		
		Scanner sc=new Scanner(System.in);
		int s,n;
		
		System.out.println("0이상의 5개 홀수 입력...");
		
		s=0;
		for(int i=1; i<=5; i++) {
			n=sc.nextInt(); 
			if(n<0 || n%2==0) {
				i--;   // 짝수를 입력했을때에는 입력한 갯수 카운트 안해야하므로
				continue;
			}			
			s+=n;
		}			
		System.out.println("결과:"+s);
		sc.close();			
	}
}

import java.util.Scanner;

public class ContinueEx2 {

	public static void main(String[] args) {
		// 5개의 홀수를 입력 받아 입력 받은 홀수의 합 구하기 
		// 단, 입력 받은 수가 0보다 적거나 짝수이면 다시 입력 받기 
		
		Scanner sc=new Scanner(System.in);
		int s,n,i;
		
		System.out.println("0이상의 5개 홀수 입력...");
		
		s=i=0;
		while(i<5) { 
		  n=sc.nextInt();
		  if(n<0 || n%2==0) {
			  continue; 
			  // continue 밑줄에 적은 것은 절대 실행 안됨 
		  	}
		  	s+=n;
		  	i++;
		  }	
		  System.out.println("결과:"+s);
		  sc.close();	
		
/*	
 	s=0;
		for(int i=1; i<=5; i++) {
			n=sc.nextInt(); 
			if(n<0 || n%2==0) {
				i--;   // 짝수를 입력했을때에는 입력한 갯수 카운트 안해야하므로
				continue;
			}			
			s+=n;
		}			
		System.out.println("결과:"+s);
		

		sc.close();		
*/	
	}
}

public class ContinueEx3 {

	public static void main(String[] args) {
		// continue labelName;
		
 		for(int i=1; i<=3; i++) {
			for(int j=1; j<=3; j++) { 
				if(i+j==4) {
					continue; // 두번째 for로 올라감 
				}
				System.out.println(i+","+j); 
			}	
		}

/*		
 		AAA:
		for(int i=1; i<=3; i++) {
			for(int j=1; j<=3; j++) { 
				if(i+j==4) {
					continue AAA; 
				}	
				System.out.println(i+","+j);  // 1,1  1,2  2,1
			}	
		}
*/	
	
	}
}

