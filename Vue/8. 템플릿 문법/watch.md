## watch 속성
- data의 변화에 따라 특정 로직을 실행 할 수 있는 뷰의 속성
- 값의 변화를 추적함   

  <img src="/Vue/img/watch2.png">

#
### watch vs computed _ [참고 코드](https://github.com/friedegg818/TIL/blob/master/Vue/8.%20%ED%85%9C%ED%94%8C%EB%A6%BF%20%EB%AC%B8%EB%B2%95/watch-vs-computed.html) 
- **computed**
> - 단순한 값의 계산
> - 로직이 실행 될 때의 기준 값이 data의 속성 
> - data에 할당 된 값들 사이의 **종속 관계**를 세팅하고자 할 때 용이함 

- **watch**
> - 매번 실행 되는 것이 부담스러운, 무거운 로직들 사용 
> - 특정 프로퍼티의 **변경 시점에 특정 액션**을 취하고자 할 때 적합함   

- watch 보다는 **computed 가 대부분의 서비스에 적합**하다.    
#
:: 인프런 [ Vue.js 시작하기 - Age of Vue.js (장기효) ] 강의 내용을 바탕으로 작성함
