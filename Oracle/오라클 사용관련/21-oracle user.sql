[����Ŭ ��������]
 - ����Ŭ�� �ڿ��� ȿ�������� �����ϱ� ���� �ʿ�
 - ������(sys) �Ǵ� CREATE USER �ý��� ������ ������ ����ڸ� ���� �� �� �ִ�.
 
 1) ���� ��ȸ 
    SELECT * FROM ALL_USERS;  -- DB ��� ������� �⺻ ���� ��ȸ
    SELECT * FROM DBA_USERS;  -- DB ��� ������� �� ���� ��ȸ (��ȣ ����)
    SELECT * FROM USER_USERS; -- ���� ������� ���� ��ȸ 

 2) ���� ���� �� ���� (sys �Ǵ� system) 
    ------------------------------------------------------------------------------ 1
  - 11g ������� ���� ���� �� ���� 
    ALTER SESSION SET "_ORACLE_SCRIPT" = true;
  
  - sky0 ���� ����
    CREATE USER sky0 IDENTIFIED BY 12345;
      �� ������ �����Ǿ �ٷ� CONN �� �Ұ���
      
  - DB ���� ���� �ο�   
    GRANT CREATE SESSION TO sky0;
  
  - ���� ����   
    DROP USER sky0;  -- ���� ���̸� ���� �Ұ� 
    ------------------------------------------------------------------------------ 2 
  - ���� �߰� �� ���� 
    CREATE USER sky0 IDENTIFIED BY 12345;
    GRANT CONNECT, RESOURCE TO sky0; 
     - CONNECT �� : ���� ���� 
     - RESOURCE �� : ���̺� ����, ���ν��� ���� ���� ����
     
  - ���� ���� : ���̺����̽� �� �뷮 
    - 12C ���ʹ� ���̺� �����̽� �뷮�� ���� ������ ���̺� ���� �Ұ� 
    - 11g ������ RESOURCE �ѿ� QUOTA �� UNLIMITED �� �ڵ� ����������(����������) 12C���ʹ� ������
      ALTER USER sky0 DEFAULT TABLESPACE USERS;
      ALTER USER sky0 TEMPORARY TABLESPACE TEMP;
      ALTER USER sky0 QUOTA UNLIMITED ON USERS;

  - ���� LOCK Ȯ�� & ����
    SELECT * FROM dba_users;
    ALTER USER sky0 ACCOUNT UNLOCK;   
    ------------------------------------------------------------------------------ 3 
  - �ѹ��� ���� (���� ���� �� ���̺� �����̽�, �뷮 ����)   
    CREATE USER sky0 IDENTIFIED BY 12345
        DEFAULT TABLESPACE USERS
        TEMPORARY TABLESPACE TEMP
        QUOTA UNLIMITED ON USERS;
   
  - ���� �ο�
    GRANT CONNECT, RESOURCE TO sky0; 
    
  - ���� ȸ��   
    REVOKE CONNECT FROM sky0;
    ------------------------------------------------------------------------------ 
    
 3) �ý��� ����     
  - ���� : Ư�� Ÿ���� SQL ���� �����ϰų� �����ͺ��̽�, ��ü�� ���� �� �� �ִ� �Ǹ� 
  - ����ڰ� �����ͺ��̽����� Ư�� �۾��� ���� �� �� �ֵ��� �� 
  - ANY > ����ڰ� ��� ��Ű������ ������ ���� 
  
   * �ý��� ���� ���õ� ������ ����  
     SELECT * FROM SYSTEM_PRIVILEGE_MAP;  -- ��ü �ý��� ���� ��� ��ȸ 
     SELECT * FROM DBA_SYS_PRIVS;         -- ��� ������ �ý��� ���� ��� ��ȸ 
     SELECT * FROM USER_SYS_PRIVS;        -- ������� �ý��� ���� ��� ��ȸ 
  
   * �ֿ� �ý��� ���� 
     CREATE USER
     SELECT ANY TABLE | ��� ������ ���̺� ��ȸ ���� 
     CREATE ANY TABLE | ��� ������ ���̺� ���� ����
     CREATE SESSION   | �����ͺ��̽� ���� ���� 
     CREATE TABLE 
     CREATE VIEW 
     CREATE MATERIALIZED VIEW 
     CREATE SEQUENCE 
     CREATE SYNONYM
     CREATE PROCEDURE
     CREATE TRIGGER
     CREATE DATABASE LINK
     SYSDBA | �����ͺ��̽��� �����ϴ� �ְ� ����
     SYSOPER | �����ͺ��̽��� �����ϴ� ���� 
    
 4) ������Ʈ ����   
  - ������ �� ��ü�� Ư���� �۾��� ���� �� �� �ְ� �Ѵ�. (���̺�,��,������,���ν���,�Լ�,��Ű��..)
  - �⺻������ ������ ��ü�� ���ؼ��� ��� ������ �ڵ������� ȹ�� �ȴ�. 
  - ��ü �����ڴ� �ٸ� ����ڿ��� Ư�� ��ü ������ �ο� �� �� �ִ�. 
  - PUBLIC ���� �ο��� ������ ȸ�� �� ���� PUBLIC ���� �ؾ� �Ѵ�.
  
  * ������Ʈ ���� ���� ������ ����
    SELECT * FROM USER_TAB_PRIVS;        -- ��ü ���� ������/�ο���/�Ǻο��� ���
    SELECT * FROM USER_TAB_PRIVS_MADE;   -- ����ڰ� �ο��� ��� ��ü ����
    SELECT * FROM USER_TAB_PRIVS_RECD;   -- ����ڰ� �ο� ���� ��� ��ü ���� 
    SELECT * FROM USER_COL_PRIVS;        -- ��ü ���� ������/�ο���/�Ǻο����� �÷��� ��ü ����
    SELECT * FROM USER_COL_PRIVS_MADE;   -- ����ڰ� �ο��� ��ü �÷��� ���� ��� ��ü ����
    SELECT * FROM USER_COL_PRIVS_RECD;   -- ����ڰ� �ο� ���� ��ü �÷��� ���� ��� ��ü ����
    
   * ��ü�� ���� ����
     SELECT  | Table, View, Sequence
     INSERT  | Table, View 
     UPDATE  | Table, View 
     DELETE  | Table, View 
     ALTER   | Table, Sequence
     INDEX   | Table
     EXECUTE | Procedure
       
  - ������Ʈ ���� �ο�   
    GRANT INSERT, SELECT ON jobs TO sky;
    
  - ������Ʈ ���� ȸ��   
    REVOKE INSERT, SELECT ON jobs FROM sky;
    
    SELECT * FROM hr.jobs;  -- ���� 
    
 5) ROLE (��) 
  - ���� ������ ������ ���� (���� �ο��� ȸ���� ����) 
  - CREATE ROLE ������ ������ �ִ� USER �� ���� ������ 
  - ROLE �� ROLE �� �ο� �� �� �ִ� 
  - ���� : ROLE ���� > ROLE �� ���� �ο� > ����ڿ��� ROLE �� �ο� 
   
  * �⺻������ �����ϴ� �� 
    CONNECT ROLE : ����Ŭ�� ���� �� �� �ִ� ���� 
    RESOURCE ROLE : ���̺� ����, ���ν��� ���� ���� �Ϲ����� ���� 
    DBA ROLE : ��� �ý��� ������ �ο��� ��, �����ͺ��̽� �����ڿ��Ը� �ο� 
    
  * �� ���� ������ ���� 
    SELECT * FROM ROLE_SYS_PRIVS;   -- �ѿ� �ο��� �ý��� ����
    SELECT * FROM ROLE_TAB_PRIVS;   -- �ѿ� �ο��� ���̺� ����
    SELECT * FROM ROLE_ROLE_PRIVS;  -- �� ���� �� Ȯ��
    SELECT * FROM USER_ROLE_PRIVS;  -- ���� ����ڰ� ACCESS �� �� �ִ� �� 
    
  - �� ���� �� ���� �ο� 
    CREATE ROLE role; 
    GRANT privilege TO role; 
    GRANT role TO user [PUBLIC]; 
  
  - �� ���� ȸ��   
    REVOKE role FROM user;
   
  - �� ����   
    ALTER ROLE role;
  
  - �� ����  
    DROP ROLE role;
    