[SQL]
 - 비절차적 언어 
   : 사용자는 원하는 데이터만 명시하면 되고, 처리하는 방법은 명시하지 않아도 된다. 
   
 - 기능(구성요소) 
   1. 데이터 검색 
     - 데이터베이스로부터 데이터를 검색
     - SELECT문 
     
   2. 데이터 조작어
     - 데이터 정의어로 정의된 데이터베이스 스키마 내의 데이터를 수정하는데 사용 
     - 데이터 삽입/삭제/수정 
     - INSERT, DELETE, UPDATE 
     
   3. 데이터 정의어 
     - 릴레이션 생성/제거, 애트리뷰트 추가/제거, 뷰 생성/제거, 인덱스 생성/제거 등 
     - 릴레이션을 생성 할 때 여러가지 유형의 무결성 제약조건들을 명시 할 수 있음 
     - CREATE, ALTER, DROP, RENAME 등 
     
   4. 트랜잭션 제어 
     - 트랜잭션의 시작, 철회, 완료 등을 명시하기 위해 사용 
     - COMMIT, ROLLBACK, SAVEPOINT
     
   5. 데이터 제어어
     - 릴레이션에 대한 권한을 부여하거나 취소함
     - GRANT, REVOKE 
     
  - 키워드(예약어) + 사용자 정의 단어로 이루어짐 
    - 키워드는 정확하게 입력해야 하고, 한 개의 키워드가 두 줄에 걸쳐서 입력 될 수 없음
    - 사용자 정의 단어들은 릴레이션, 애트리뷰트, 뷰 등 여러가지 데이터베이스 객체들의 이름을 나타내기 위해 사용 
    - 키워드는 테이블이나 애트리뷰트의 이름으로 사용 불가 
  - SQL문의 대부분의 구성요소는 대소문자를 구분 하지 않음 (문자열 데이터 제외) 
  
  ---------------------------------------------------------------------------------------------------
  
[데이터 정의어]
  - 종류 
   - CREATE DOMAIN/ TABLE/ VIEW/ INDEX  
   - ALTER TABLE
   - DROP DOMAIN/ TABLE/ VIEW/ INDEX
   
  - 테이블 생성시(릴레이션 정의) 주로 사용되는 오라클 데이터 타입 
   - INTEGER or INT : 정수형
   - NUMBER : 숫자 
   - CHAR or CHARACTER : 문자열
   - VARCHAR or VARCHAR2 : 가변 길이 문자열
   - DATE : 날짜형
   - BLOB : 멀티미디어 데이터 등 
 
  - 제약 조건
   - 종류 
     1. NOT NULL 
      - 애트리뷰트에 NULL 값을 허용 하지 않을 때 명시 
     2. UNIQUE 
      - 동일한 값을 갖는 튜플이 두 개 이상 존재하지 않도록 보장
     3. DEFAULT 
      - 애트리뷰트에 널값 대신에 특정 값을 기본 값으로 지정 할 수 있음
     4. CHECK 
      - 한 애트리뷰트가 가질 수 있는 값들의 범위를 지정 
      
    - 기본키 제약 조건 
      PRIMARY KEY(EMPNO)
   
    - 참조 무결성 제약 조건 
      FOREIGN KEY(MANAGER) REFERENCES EMPLOYEE(EMPNO),
      FOREIGN KEY(DNO) REFERENCES DEPARTMENT(DEPNO) ON DELETE CASCADE; 
      -- ON DELETE CASCADE : 기본 키의 값이 삭제되면, 그 값을 참조하는 모든 튜플들이 연쇄적으로 삭제됨 
      
   - 무결성 제약조건의 추가/삭제 
     ALTER TABLE STUDENT ADD CONSTRAINT STUDENT_PK PRIMARY KEY(STNO); --추가
     ALTER TABLE STUDENT DROP CONSTRAINT STUDENT_PK; --삭제 
    
 
  
  