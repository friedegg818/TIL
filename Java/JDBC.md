# JDBC
 - 자바에서 데이터베이스에 일관된 방식으로 접근 할 수 있도록 제공하는 API
 
       → 자바를 이용한 데이터베이스 접속/SQL 문장 실행/SQL 실행 결과 데이터 가져오기..
   
 - JDBC API 클래스와 인터페이스는 java.sql 과 javax.sql 에 포함 되어 있음
 - 특징 
   - ANSI SQL-92 표준을 지원
   - 공통된 SQL 인터페이스를 바탕으로 만들어짐   
#   
### JDBC 드라이버
  - JDBC API를 통해 데이터베이스 연결을 제공 
  - JDBC 드라이버 타입 
  
        - Type 1,2,3 (이전 사용 방식)
        - Type 4 (Native-Protocol Pure Java Driver)
	    - 순수 자바이며 특정 데이터 소스에 대한 네트워크 프로토콜을 구현하는 드라이버 
	    - 데이터 소스에 직접 연결하는 방식
	    - DBMS 벤더에서 제공하며, 특정 DBMS에 의존적
	   
#
###
  - SQLException : 데이터베이스 액세스 에러 및 그 외의 에러에 대한 정보를 제공하는 예외 

#
### DriverManager 클래스
  - JDBC 드라이버를 관리하기 위한 기본적인 클래스
  - 데이터베이스 드라이버를 선택하고 새로운 데이터베이스 연결을 생성하는 기능 
  - 주요 메소드
    - getConnection :  DB에 연결 하여 Connection 객체 반환 
    
          ** 서버 IP / 포트번호 / SID / 사용자명 / 패스워드 	
 
          ** DBMS별 JDBC 드라이버 클래스 및 URL 형식 
	  
            · ORACLE 	    
	           드라이버 클래스   |  oracle.jdbc.driver.OracleDriver 	      
	           URL 형식 
	            ORACLE 12C 이상 | jdbc:oracle:thin:@//[HOST][:PORT]/SERVICE 
	            ORACLE 11g      |  jdbc:oracle.thin:@서버주소:포트번호:SID
    
 # 
### Connection 인터페이스
  - 특정 데이터베이스와의 연결을 나타내는 객체 
  - 쿼리를 실행하는 Statement, PreparedStatement 등의 객체를 생성 
  - COMMIT, ROLLBACK 등의 트랜잭션 처리를 위한 메소드 제공 
  - DriverManager.getConnecton() 메소드를 호출하여 생성 
  
