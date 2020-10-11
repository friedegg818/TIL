# 제어문 

### If 문
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

   *참고* :: [Scanner > charAt() 에 대한 부가 설명](https://github.com/friedegg818/TIL/blob/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/Test_Scanner.java)

#

### if~else 문
- if 다음의 조건이 참일 경우와 거짓일 경우에 따라 각각 다른 문장을 수행하고자 할 때
- 형식   

       if(조건식) {
        실행문_1;
	  } else {
        실행문_2;
         }

   [관련 소스](https://github.com/friedegg818/TIL/blob/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/IfelseEx7.java)

#
### 다중 선택 if 문 - else if 문
- if문의 처음 조건식이 거짓일 경우 계속된 다른 범위의 값을 추출하기 위해 
- 형식  

      if(조건식_1) {
       실행문_1;
      } else if(조건식_2) {
       실행문_2;
	  } else if(조건식_n) {
       실행문_n; 
	  } else {
	   실행문_o;
	  } 
	   실행문_p;

       ** 조건1이면 실행문1.
	    '그렇지 않고' 조건2면 실행문2.
	    '그렇지 않고' 조건n면 실행문 n.

    [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/Ifelse%20Ex8-10)

#
### if 문 중첩
- if문 안에 또 다른 if문을 두는 제어 구조 
- 형식 

      if(조건식_1) {
       if(조건식_2) {
	    실행문_1;
	    } else {
	    실행문_2;
	    } 
      } else { 
        실행문_3;
      }	   

   [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/IF%20Ex11-13)

