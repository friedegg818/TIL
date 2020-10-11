 
 < 데이터 링크 > 
  - 권한 부여 (관리자) 
    GRANT CREATE DATABASE LINK TO sky;
    
  - 데이터 링크 설정 (일반 유저)
    CREATE DATABASE LINK link_test
         CONNECT TO sky IDENTIFIED BY "java$!"
         USING 
         '(DESCRIPTION=(ADDRESS=(PROTOCOL=TCP)
              (HOST=211.238.142.52)(PORT=1521))
              (CONNECT_DATA=(SERVICE_NAME=XE)))';
              
    SELECT * FROM emp@link_test;
    SELECT * FROM tab@link_test;
    
    SELECT * FROM emp
    UNION ALL
    SELECT * FROM emp@link_test;
    
  - 링크 조회 
    SELECT * FROM user_db_links;
    
  - 링크 삭제
    DROP DATABASE LINK link_test;


 <논리적인 백업>
   - EXPORT : 파일을 모두 압축하여 외부로 내보내는 것 
     cmd>exp userid=sky/"java$!" file='C:\data\sky.dmp' owner sky
     cmd>dir c:\data
     -------------------------------------------------------------
     SELECT * FROM tab;
     DROP TABLE emp_score PURGE;
     DROP TABLE emp;
     -------------------------------------------------------------    
  - IMPORT : 압축 해제하여 가져오기 (논리적으로 복원) 
    cmd> imp userid=sky/"java$!" file='C:\data\sky.dmp' fromuser=sky touser=sky
    
