## v-on 
- **methods** 속성과 **v-on** 을 이용하여 **키보드, 마우스 이벤트** 처리 가능  

  [ *인스턴스가 다음과 같은 methods 속성을 가지고 있을 때* ]
  
  <img src="/Vue/img/von1.png"> 
#
- 마우스 이벤트 처리 : **v-on:click="메소드이름"** 

  <img src="/Vue/img/von3.png"> 
#
- 키보드 이벤트 처리 : **v-on:keyup="메소드이름"**

  <img src="/Vue/img/von4.png">
  
  - keyup 외에 keypress 등 다른 종류도 있음 
  - keyup.enter 와 같이 특정 키를 눌렀을 때만 이벤트가 발생 하도록 할 수 있음    
  
    <img src="/Vue/img/von5.png"> 
 #
:: 인프런 [ Vue.js 시작하기 - Age of Vue.js (장기효) ] 강의 내용을 바탕으로 작성함 
