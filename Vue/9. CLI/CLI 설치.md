## 프로젝트 생성 도구 - Vue CLI
- Command Line Interface
- 명령어를 통한 특정 액션을 수행 하는 도구 (명령어 실행 도구) 
#
### 설치 
- 설치 전 VSCode 에서 확인 할 것 
  - Terminal > New Terminal 실행 후    
    **node -v** : 현재 노드 버전 확인 (10.x 이상)   
    **npm -v** : npm 버전 확인 (6.x 이상)   
	
    <img src="/Vue/img/cli1.png">
   
- **npm install -g @vue/cli**    

  <img src="/Vue/img/cli2.png">
  
- 설치 완료 후 메세지와 함께 버전이 표기 된다.    

  <img src="/Vue/img/cli3.png">
  

#

### 설치 시 문제점 해결 
- permission 에러 : 설치한 라이브러리가 위치하는 폴더에 파일 쓰기 권한이 없기 때문에 발생 
  - 해결 : 앞에 sudo 를 붙여주기 → **sudo** npm install -g @vue/cli 
 
- 해당 루트 참고 (mac / windows 순)

  <img src="/Vue/img/cli4.png">

#
:: 인프런 [ Vue.js 시작하기 - Age of Vue.js (장기효) ] 강의 내용을 바탕으로 작성함
