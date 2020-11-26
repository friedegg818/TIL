-- ��� ����� ����
SELECT * FROM all_users;

-- ���ο� ����� �߰�
CREATE USER purple IDENTIFIED BY "java$!";

-- ����ڿ��� ���� �ο�
GRANT CONNECT, RESOURCE TO purple;
GRANT CREATE SESSION, CREATE VIEW TO purple;

-- �⺻ ���̺����̽� ���� 
ALTER USER purple DEFAULT TABLESPACE USERS;
ALTER USER purple TEMPORARY TABLESPACE TEMP;
ALTER USER purple DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


