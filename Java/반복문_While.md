# 반복문 

### while 문 
- 조건식을 먼저 비교하여 조건식이 참인 경우 특정 영역을 반복 수행하는 문장
- 반복 횟수가 정해지지 않은 경우에 가장 많이 쓰인다.
- 처음 조건식이 false인 경우 실행문은 단 한 번도 실행하지 않는다.
- 형식  

           while(조건식)  {
                            -- 조건식은 반드시 true, false (정수X) / 조건식 자체가 true인 경우, 무한 루프가 된다.  
			    -- while 속에 while, 다른 반복문도 가능 	
           실행문;
			    -- 1개인 경우 생략 가능(그래도 써주는게 좋음)	
           } 		
           
   [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/White%20EX1-23)
   
#

### do~while 문
- while문과 같이 특정한 영역 반복 수행. 
- 조건식을 나중에 비교 > '적어도 한 번'은 실행한다. 
- 형식	

           do	{
		        실행문;
		       } while(조건식);
 
  [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/doWhile1-4)
   
