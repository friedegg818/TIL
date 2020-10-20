
- Annotation

	1) <context:annotation-config/> 태그를 이용한 등록       
		- @Required 
		  - 필수 property 를 설정 
		  - setter 메소드에 설정 
		  
		- @Autowired  
		  - spring 제공 어노테이션 
		  - byType. 타입으로 의존관계를 자동 설정 (setter 불필요) 
		    - 동일한 타입의 객체가 두 개 이상 존재하면 필드명과 동일한 id 를 찾는다.
		    - 없으면 예외 발생			
			- @Qualifier
			  - @Autowired 와 함께 사용 
			  - 동일한 타입의 객체가 두 개 이상 일 때, id로 의존 관계를 설정 
				ex) Qualifier("test")
			
		- @Inject
		  - java 제공 어노테이션
		  - byType. 타입으로 의존관계를 자동 설정 
			
		- @Resource
		  - java 제공 어노테이션 
		  - byName. 이름으로 의존관계를 자동 설정	
	
		- @PostConstructor : 객체를 설정한 이후 (생성자 실행 후) 초기화 작업 수행 
		- @PreDestroy : 컨테인에서 객체를 제거하기 전 (종료 전) 해야 할 작업 수행 
	
	
	2)  <context:component-scan base-package=" "/> 태그를 이용한 등록 
	     - "com.test7"  | 해당 폴더의 클래스 스캔
		 - "*"          | 모든 폴더의 클래스 스캔 
		 - "test.*"     | test의 모든 하위 폴더의 클래스 스캔
		     
			* 은 충돌을 일으킬 수도 있으므로 잘 사용하지 않는 것이 좋음 
	  
	    - @Component 
	    	- 객체 생성 
			- 첫글자가 소문자인 클래스명이 id로 자동 부여 된다.	
			- @Component("test8.userBean") _ 아이디 지정
			- 자식 annotation 
			  > @Service _ 비즈니스 로직을 담당하는 클래스에 사용 (ex. myUtil, FileManager)		
			  > @Controller _  MVC 패턴, 컨트롤러에만 사용 
			  > @Repository _ DB 작업 _ DAO 클래스에 사용
			  
	    - @Scope 
			- prototype 설정 
			- @Scope(value="prototype") 	
			- @Scope(value="prototype" , proxyMode=Scoped ProxyMode.TARGET_CLASS) 
			
			
