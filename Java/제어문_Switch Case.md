# 제어문
### Switch~case 문 (다중 선택문)
- switch문의 수식 결과 값과 case문의 상수가 일치하는 곳의 문장을 실행 
- 가독성이 높지만 제한적임 
- 메뉴 같은 것 만들 때 많이 사용함 
- 형식  

       switch(수식){ // 수식: 변수 or 연산식
                                -- byte,short,char,int,String(7.0),enum(열거형)가능 / long, float, double, boolean 불가능 
       case 상수_1:문장_1; break;
       case 상수_2:문장_2; break;
	    	                -- 상수에는 '값(리터널)'만 가능! 문자 리터널도 포함. 
			                -- break; 문장을 빠져나오기 위한 기능. 맨 마지막엔 안 써도 됨.
       [default:문장_n; [break;]]
		                      -- 만족하는 상수가 없는 경우 실행, 생략 가능, 위치 상관 X 
       }
  
  [관련소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/Switch%20EX1-10)
