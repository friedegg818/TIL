### 클라이언트-서버간 HTTP 통신 구조 
1. 클라이언트가 서버로 요청을 보냄 
2. 요청 받은 서버에서 특정 백엔드 로직 실행 
3-4. DB에서 데이터를 가져옴 
5. 특정 백엔드 로직 실행 
6. 서버에서 브라우저로 응답 

<img src="/Vue/img/axios5_통신구조.png">   


### 개발자 도구의 네트워크 패널 보기
- 네트워크 패널    

  <img src="/Vue/img/axios6_네패.png">   
  
- Headers : 특정 요청/정보에 대한 부가적인 정보를 담고 있음   

  <img src="/Vue/img/axios7_헤더.png">
 
- Preview : Response가 어떤 식으로 되어 있는지 간략하게 보여줌   

  <img src="/Vue/img/axios8_프리뷰.png">   
  
- Response : 데이터 정보가 담겨 있음 

:: 참고 :: [HTTP 프로토콜](https://joshua1988.github.io/web-development/http-part1/)
