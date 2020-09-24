### 클라이언트-서버간 HTTP 통신 구조 
1. 클라이언트가 서버로 요청을 보냄 
2. 요청 받은 서버에서 특정 백엔드 로직 실행 
3. DB로 데이터 요청
4. DB에서 서버로 데이터 전송
5. 특정 백엔드 로직 실행 
6. 서버에서 브라우저로 응답 
#
<img src="/Vue/img/axios5_통신구조.png">   

#
### 개발자 도구의 네트워크 패널 보기
- 네트워크 패널    

  <img src="/Vue/img/axios6_네패.png">   
#
- Headers : 특정 요청/정보에 대한 부가적인 정보를 담고 있음   

  <img src="/Vue/img/axios7_헤더.png">
# 
- Preview : Response가 어떤 식으로 되어 있는지 간략하게 보여줌   

  <img src="/Vue/img/axios8_프리뷰.png">   
#  
- Response : 데이터 정보가 담겨 있음   

  <img src="/Vue/img/axois9_리스펀스.png">
#  

:: 참고 :: [HTTP 프로토콜에 대하여](https://joshua1988.github.io/web-development/http-part1/)
:: 인프런 [ Vue.js 시작하기 - Age of Vue.js (장기효) ] 강의 내용을 바탕으로 작성함
