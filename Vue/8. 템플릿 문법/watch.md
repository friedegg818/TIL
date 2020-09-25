## watch 속성
- data의 변화에 따라 특정 로직을 실행 할 수 있는 뷰의 속성
- 값의 변화를 추적함   

  <img src="/Vue/img/watch2.png">

#
### watch vs computed
- **computed**
> - 단순한 값의 계산
> - 로직이 실행 될 때의 기준 값이 data의 속성 
> - data에 할당 된 값들 사이의 **종속 관계**를 세팅하고자 할 때 용이함 

- **watch**
> - 매번 실행 되는 것이 부담스러운, 무거운 로직들 사용 
> - 특정 프로퍼티의 **변경 시점에 특정 액션**을 취하고자 할 때 적합함   

> - <img src="/Vue/img/watchvscomputed.png">
   

- watch 보다는 **computed 가 대부분의 서비스에 적합**하다. 
#
### computed 를 이용한 직관적 코드 작성  
- 클래스 코드 작성   
  - *v-bind:class*  의 설정 값에 직접 조건을 설정하면 코드가 복잡해 질 수 있으므로 computed 속성을 이용한다. 
  - p 태그의 클래스명을 조건에 맞게 설정 함으로써 css 등도 자동 변경이 가능하다.         
  - 예시    
    
    <img src="/Vue/img/computed-usage.png">   

#
:: 인프런 [ Vue.js 시작하기 - Age of Vue.js (장기효) ] 강의 내용을 바탕으로 작성함
