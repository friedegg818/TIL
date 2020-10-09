[오라클 계정관리]
 - 오라클의 자원을 효율적으로 관리하기 위해 필요
 - 관리자(sys) 또는 CREATE USER 시스템 권한을 가져야 사용자를 생성 할 수 있다.
 
 1) 계정 조회 
    SELECT * FROM ALL_USERS;  -- DB 모든 사용자의 기본 정보 조회
    SELECT * FROM DBA_USERS;  -- DB 모든 사용자의 상세 정보 조회 (암호 포함)
    SELECT * FROM USER_USERS; -- 현재 사용자의 정보 조회 

 2) 계정 생성 및 변경 (sys 또는 system) 
    ------------------------------------------------------------------------------ 1
  - 11g 방식으로 계정 생성 및 삭제 
    ALTER SESSION SET "_ORACLE_SCRIPT" = true;
  
  - sky0 계정 생성
    CREATE USER sky0 IDENTIFIED BY 12345;
      → 계정이 생성되어도 바로 CONN 는 불가능
      
  - DB 접속 권한 부여   
    GRANT CREATE SESSION TO sky0;
  
  - 계정 삭제   
    DROP USER sky0;  -- 접속 중이면 삭제 불가 
    ------------------------------------------------------------------------------ 2 
  - 계정 추가 및 변경 
    CREATE USER sky0 IDENTIFIED BY 12345;
    GRANT CONNECT, RESOURCE TO sky0; 
     - CONNECT 롤 : 접속 권한 
     - RESOURCE 롤 : 테이블 생성, 프로시저 생성 등의 권한
     
  - 계정 수정 : 테이블스페이스 및 용량 
    - 12C 부터는 테이블 스페이스 용량을 주지 않으면 테이블 생성 불가 
    - 11g 에서는 RESOURCE 롤에 QUOTA 가 UNLIMITED 로 자동 지정되지만(숨겨져있음) 12C부터는 없어짐
      ALTER USER sky0 DEFAULT TABLESPACE USERS;
      ALTER USER sky0 TEMPORARY TABLESPACE TEMP;
      ALTER USER sky0 QUOTA UNLIMITED ON USERS;

  - 계정 LOCK 확인 & 해제
    SELECT * FROM dba_users;
    ALTER USER sky0 ACCOUNT UNLOCK;   
    ------------------------------------------------------------------------------ 3 
  - 한번에 지정 (계정 생성 및 테이블 스페이스, 용량 지정)   
    CREATE USER sky0 IDENTIFIED BY 12345
        DEFAULT TABLESPACE USERS
        TEMPORARY TABLESPACE TEMP
        QUOTA UNLIMITED ON USERS;
   
  - 권한 부여
    GRANT CONNECT, RESOURCE TO sky0; 
    
  - 권한 회수   
    REVOKE CONNECT FROM sky0;
    ------------------------------------------------------------------------------ 
    
 3) 시스템 권한     
  - 권한 : 특정 타입의 SQL 문을 실행하거나 데이터베이스, 객체에 접근 할 수 있는 권리 
  - 사용자가 데이터베이스에서 특정 작업을 수행 할 수 있도록 함 
  - ANY > 사용자가 모든 스키마에서 권한을 가짐 
  
   * 시스템 권한 관련된 데이터 사전  
     SELECT * FROM SYSTEM_PRIVILEGE_MAP;  -- 전체 시스템 권한 목록 조회 
     SELECT * FROM DBA_SYS_PRIVS;         -- 모든 유저의 시스템 권한 목록 조회 
     SELECT * FROM USER_SYS_PRIVS;        -- 사용자의 시스템 권한 목록 조회 
  
   * 주요 시스템 권한 
     CREATE USER
     SELECT ANY TABLE | 모든 유저의 테이블 조회 권한 
     CREATE ANY TABLE | 모든 유저의 테이블 생성 권한
     CREATE SESSION   | 데이터베이스 접속 권한 
     CREATE TABLE 
     CREATE VIEW 
     CREATE MATERIALIZED VIEW 
     CREATE SEQUENCE 
     CREATE SYNONYM
     CREATE PROCEDURE
     CREATE TRIGGER
     CREATE DATABASE LINK
     SYSDBA | 데이터베이스를 관리하는 최고 권한
     SYSOPER | 데이터베이스를 관리하는 권한 
    
 4) 오브젝트 권한   
  - 지정된 한 객체에 특별한 작업을 수행 할 수 있게 한다. (테이블,뷰,시퀀스,프로시저,함수,패키지..)
  - 기본적으로 소유한 객체에 대해서는 모드 권한이 자동적으로 획득 된다. 
  - 객체 소유자는 다른 사용자에게 특정 객체 권한을 부여 할 수 있다. 
  - PUBLIC 으로 부여한 권한은 회수 할 때도 PUBLIC 으로 해야 한다.
  
  * 오브젝트 권한 관련 데이터 사전
    SELECT * FROM USER_TAB_PRIVS;        -- 객체 권한 소유자/부여자/피부여자 출력
    SELECT * FROM USER_TAB_PRIVS_MADE;   -- 사용자가 부여한 모든 객체 권한
    SELECT * FROM USER_TAB_PRIVS_RECD;   -- 사용자가 부여 받은 모든 객체 권한 
    SELECT * FROM USER_COL_PRIVS;        -- 객체 권한 소유자/부여자/피부여자의 컬럼의 객체 권한
    SELECT * FROM USER_COL_PRIVS_MADE;   -- 사용자가 부여한 객체 컬럼에 대한 모든 객체 권한
    SELECT * FROM USER_COL_PRIVS_RECD;   -- 사용자가 부여 받은 객체 컬럼에 대한 모든 객체 권한
    
   * 객체에 따른 권한
     SELECT  | Table, View, Sequence
     INSERT  | Table, View 
     UPDATE  | Table, View 
     DELETE  | Table, View 
     ALTER   | Table, Sequence
     INDEX   | Table
     EXECUTE | Procedure
       
  - 오브젝트 권한 부여   
    GRANT INSERT, SELECT ON jobs TO sky;
    
  - 오브젝트 권한 회수   
    REVOKE INSERT, SELECT ON jobs FROM sky;
    
    SELECT * FROM hr.jobs;  -- 가능 
    
 5) ROLE (롤) 
  - 서로 연관된 권한의 묶음 (권한 부여와 회수가 쉬움) 
  - CREATE ROLE 권한을 가지고 있는 USER 에 의해 생성됨 
  - ROLE 에 ROLE 을 부여 할 수 있다 
  - 순서 : ROLE 생성 > ROLE 에 권한 부여 > 사용자에게 ROLE 을 부여 
   
  * 기본적으로 제공하는 롤 
    CONNECT ROLE : 오라클에 접속 할 수 있는 권한 
    RESOURCE ROLE : 테이블 생성, 프로시저 생성 등의 일반적인 권한 
    DBA ROLE : 모든 시스템 권한이 부여된 롤, 데이터베이스 관리자에게만 부여 
    
  * 롤 관련 데이터 사전 
    SELECT * FROM ROLE_SYS_PRIVS;   -- 롤에 부여된 시스템 권한
    SELECT * FROM ROLE_TAB_PRIVS;   -- 롤에 부여된 테이블 권한
    SELECT * FROM ROLE_ROLE_PRIVS;  -- 롤 안의 롤 확인
    SELECT * FROM USER_ROLE_PRIVS;  -- 현재 사용자가 ACCESS 할 수 있는 롤 
    
  - 롤 생성 및 권한 부여 
    CREATE ROLE role; 
    GRANT privilege TO role; 
    GRANT role TO user [PUBLIC]; 
  
  - 롤 권한 회수   
    REVOKE role FROM user;
   
  - 롤 수정   
    ALTER ROLE role;
  
  - 롤 삭제  
    DROP ROLE role;
    