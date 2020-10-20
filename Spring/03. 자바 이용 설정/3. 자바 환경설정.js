
- 순수 자바를 이용한 환경설정 

	- 실행 파일에서 
	  - 스프링 컨테이너 생성
	    AbstractApplicationContext context = new AnnotationConfigApplicationContext(SpringConfig.class);
	  - 컨테이너에서 해당 객체 가져오기 
	    UserBean bean = (UserBean)context.getBean("demo2.bean");  
		 * getBean의 인자에 id 혹은 name 입력 
		 
	- 환경 설정 파일 
	  - @Configuration  
	    - @Bean 
		  - 객체 생성 
		  - 기본적으로 아이디는 메소드명 
		  - 별도로 이름을 지정 할 수 있음 
		  
		 @Configuration
		  public class SpringConfig {

			@Bean(name="demo2.bean", initMethod="init", destroyMethod="destroy")	
			public UserBean beanDevice() {
				return new UserBean();
			}
			  
