[��Ÿ����] 
 < ������ ��ũ > 
  - ���� �ο� (������) 
    GRANT CREATE DATABASE LINK TO sky;
  - ������ ��ũ ���� (�Ϲ� ����)
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
    
  - ��ũ ��ȸ 
    SELECT * FROM user_db_links;
    
  - ��ũ ����
    DROP DATABASE LINK link_test;


 <������ ���>
   - EXPORT : ������ ��� �����Ͽ� �ܺη� �������� �� 
     cmd>exp userid=sky/"java$!" file='C:\data\sky.dmp' owner sky
     cmd>dir c:\data
     -------------------------------------------------------------
     SELECT * FROM tab;
     DROP TABLE emp_score PURGE;
     DROP TABLE emp;
     -------------------------------------------------------------    
  - IMPORT : ���� �����Ͽ� �������� (�������� ����) 
    cmd> imp userid=sky/"java$!" file='C:\data\sky.dmp' fromuser=sky touser=sky
    