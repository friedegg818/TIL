# 반복문

### for 문 
- 반복횟수가 정해져 있을 때 사용되는 반복문 
- 형식 

      for (초기식 ; 조건식 ; 증감식) {
		    	실행문				
       }
        
	  · 초기식 - 무조건 실행
	  · 조건식 - 반드시 true or false. 참이면 실행문 수행. 
	  · 증감식 - 실행문 수행 후 재초기 (초기값 변경)
	  · 다시 조건식 > 참 > 실행 > 증감식 > .... 
	  · 거짓이면 for문을 빠져나감 
  
- while 과 반대 개념  

  [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/ForEx)   
  [무한루프 설명](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/%EB%AC%B4%ED%95%9C%EB%A3%A8%ED%94%84)   
  [최대값 구하기](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/for%20%EC%B5%9C%EB%8C%80%EA%B0%92)
 
 
#
### 다중 for 문 
- for문 안에 다른 for문을 포함한 문 (중첩 횟수 제한 없음) 
- 형태 	

          for(초기식 ; 조건식 ; 증감식) { 
	                 실행문	  				
	       for(초기식 ; 조건식 ; 증감식) {
	                 실행문			
		}			
	   }

   [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/%EB%8B%A4%EC%A4%91%20For%20Ex)   
   [Math.random(난수 발생)](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/%EB%B0%98%EB%B3%B5%EB%AC%B8_%EB%82%9C%EC%88%98%20%EB%B0%9C%EC%83%9D)   
   
   
