### 인스턴스란? 
- 뷰로 개발 할 때 필수로 생성해야 하는 코드 
- 생성 후 인스턴스 안에 어떤 속성과 API(기능)가 있는지 콘솔창에서 확인 가능    
	var vm = **new Vue();**    
	console.log(vm);   
#
### 인스턴스와 생성자 함수 
- 생성자 함수 : 어떠한 정보를 담은 객체를 생성하는 것 

	function **Person**(name, job) {   
	>		this.name = name;   
	>		this.job = job;   
	}   

	var p = new Person('josh', 'developer');   

- 생성자 함수로서 new Vue 를 사용하는 이유 : 생성자 함수로 새로운 **객체를 생성 할 때 마다 미리 정의해 놓은 함수 사용 가능** 
	
	*// Vue라는 생성자 함수에 미리 logText라는 함수를 넣어놓음*   
	function Vue() {   
	>	this.logText = function() {   
	>		console.log('hello');   
		}   
	}   
	
	*// 새로 생성한 객체 vm 에서 logText 바로 사용*   
	var vm = new Vue();   
	vm.logText();    	

* 참고 : [생성자 함수 사용하기](https://developer.mozilla.org/ko/docs/Web/JavaScript/Guide/Obsolete_Pages/Core_JavaScript_1.5_Guide/Creating_New_Objects/Using_a_Constructor_Function)
#
### 인스턴스 옵션 속성 
- 형식    
	new Vue({ 	  
	>	el; ,   
	>	template: ,   
	>	data: ,   
	>	methods: ,   
	>	created: ,   
	>	watch: ,   
	});    

- el: 인스턴스가 그려지는 화면의 시작점 (특정 HTML 태그)
- template: 화면에 표시 할 요소 (HTML, CSS)
- data: 뷰의 반응성이 반영된 데이터 속성 
- methods: 화면의 동작과 이벤트 로직을 제어하는 메소드 
- created: 뷰의 라이프 사이클과 관련된 속성 
- watch: data에서 정의한 속성이 변화 했을 때, 추가 동작을 수행 할 수 있게 정의하는 속성 


