[VIEW]
-- ����ڿ��� ������ ���� �ڷḸ�� ���������� �����ִ� ���� ���̺� (���������� ���� �Ǿ����� ����)
-- ������ X , SQL�� ���� (������ ������ �ִٰ� �����ϸ� ����) 
-- �ӵ��� ������ ���� ����ϴ� ���� �ƴϴ�.

1) VIEW ���� 
  - �� ���� �� Ȯ�� �� ��
     1. �ش�Ǵ� ������ ���� �Ǵ��� 
     2. ���� ������ �÷����� ������ �ִ��� 
  - �� �ۼ� ���� �ο� (������ : sys �Ǵ� system ��������)     
     GRANT CREATE VIEW TO �����;
  - ���� Ȯ�� (����� ��������) 
     SELECT * FROM USER_SYS_PRIVS;      
   -------------------------------------------------------------------------------------------
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum;
   --------------------------------------------------------------------------------------------  
  - ���� ������ VIEW ���� 
    CREATE VIEW panmai 
    AS 
       SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
       FROM book b
       JOIN pub p ON b.pNum = p.pNum
       JOIN dsale d ON b.bCode = d.bCode
       JOIN sale s ON d.sNum = s.sNum
       JOIN cus c  ON s.cNum = c.cNum;
    
    SELECT * FROM panmai;    
        
  - �� ���� Ȯ��    
    SELECT * FROM tab; - ��� Ȯ��. tabtype : view�� ǥ�� 
     
    SELECT * FROM col WHERE tname = 'PANMAI';  - �÷� ���� Ȯ��
    DESC panmai;
     
    SELECT view_name, text FROM user_views; - �ҽ� Ȯ�� 
     
  - �� ����   
    CREATE OR REPLACE VIEW panmai 
    AS 
       SELECT bc.bcCode, bcSubject, b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
       FROM book b
       JOIN bclass bc on b.bcCode = bc.bcCode
       JOIN pub p ON b.pNum = p.pNum
       JOIN dsale d ON b.bCode = d.bCode
       JOIN sale s ON d.sNum = s.sNum
       JOIN cus c  ON s.cNum = c.cNum;
    
    SELECT * FROM panmai;   
    
 ** ���� 
  - ypanmai �� ����� (�⵵, bCode, bName, qty ��, qty*bPrice ��) / �⵵ �������� ���� 
  
     CREATE VIEW ypanmai 
     AS 
         SELECT TO_CHAR(sDate,'YYYY') �⵵, b.bCode å�ڵ�, bName å�̸�, 
                SUM(qty) �Ǹŷ�, SUM(qty*bPrice) �Ǹűݾ� 
         FROM book b 
         JOIN dsale d ON b.bCode = d.bCode 
         JOIN sale s ON d.sNum = s.sNum 
         GROUP BY TO_CHAR(sDate,'YYYY'), b.bCode, bName 
         ORDER BY �⵵ DESC;
          
     SELECT * FROM ypanmai;
     SELECT * FROM ypanmai WHERE �⵵ = 2019;    -- �ξ� �������� 
     
2) VIEW�� �̿��� ������ �߰�, ����, ���� 
 
 - �ܼ� �� : �ϳ��� ���̺�� �ۼ�
     CREATE OR REPLACE VIEW testview2
     AS 
        SELECT num, name 
        FROM test1;
        
     -- INSERT, UPDATE, DELETE ���� (�������� �������� ������)
        INSERT INTO testview2(num, name) VALUES (4, 'oracle'); 
        DELETE FROM testview2 WHERE num=1;
        
 - ���� �� : �ϳ� �̻��� ���̺�� �ۼ� 
     CREATE OR REPLACE VIEW testview1 
     AS 
        SELECT a.num, code, name, memo, score
        FROM test1 a, test2 b WHERE a.num = b.num;
        
    -- INSERT, UPDATE, DELETE �Ұ��� 
       INSERT INTO testview1(num,name,memo) VALUES (4, 'd', 'oracle');  -- ���� 
       UPDATE testview1 SET name = 'aa', score = 100 WHERE num=1;       -- ���� 

3) VIEW ���� 

    DROP VIEW testview1;
    DROP VIEW testview2;
    
4) WITH CHECK OPTION 
-- ���� �÷� ���� �������� ���ϰ� �ϴ� �ɼ� 
-- �並 �̿��� ���� ���Ἲ �˻� 
-- INSERT / UPDATE ������ �Ұ��ϴ�.

    CREATE OR REPLACE VIEW empView 
    AS 
      SELECT empNo, name, city, sal FROM emp1 
      WHERE city = '����'
      WITH CHECK OPTION CONSTRAINT wc_empView;

    UPDATE empView SET city = '�λ�' WHERE empNo = '1059';  -- ���� : WITH CEHCK OPTIO ���ǿ� ���� (ORA-01402) 
    
5) WITH READ ONLY 
-- �並 ���� ���� ������ �Ұ����ϰ� ����� �ɼ� 


[SEQUENCE] 
-- ������ ���� ���� ���������� ������Ű�� ���� ����ϴ� ��ü 
-- �⺻ Ű ���� �ڵ����� �����ϰ�, Ŀ��&�ѹ��� ���� ���� ��ȣ�� �����Ǹ� ����ؼ� �������� �����Ѵ�.
    
1) ������ ����
CREATE SEQUENCE �������� 
    START WITH     -- ���� �� 
    INCREMENT BY   -- ���� �� (�����ϸ� 1, ��� ���� ��� ����) 
    [NO]MAXVALUE   -- ���� �� �� �ִ� �ִ밪 
    [NO]MINVALUE   -- ���� �� �� �ִ� �ּҰ� / CYCLE �� ���� �� 
    [NO]CYCLE      -- ��ȯ (�ּ� OR �ִ밪 ���� �� ���� ��� ����) / CYCLE ���� �� �ݵ�� CACHE�� �����ؾ� ��
    [NO]CACHE      -- �̸� �Ҵ� �ϴ� �������� �� / �߰��� ���α׷��� ����Ǹ� �ǳʶٴ� ���ڰ� �����
                   -- �ƹ��͵� ���� ������ �⺻���� 20�� ĳ�� 

 - 1���� 1�� ���� 
     CREATE SEQUENCE seq0;     

 - 1���� 1�� ����
   CREATE SEQUENCE seq1 START WITH 1 INCREMENT BY 1 
        NOMAXVALUE NOCYCLE NOCACHE;  

 - 100���� 1�� ���� 
    CREATE SEQUENCE seq2 START WITH 100 INCREMENT BY 1 
        MINVALUE 1 MAXVALUE 1000;
        
 - 3���� 999���� 3�� ����. cache 5��
   CREATE SEQUENCE seq3 START WITH 3 INCREMENT BY 3 
        MINVALUE 3 MAXVALUE 999 CACHE 5;
        
 - 9���� 4�� ����         
   CREATE SEQUENCE seq4 START WITH 9 INCREMENT BY 4 
       MINVALUE 3 MAXVALUE 12 CYCLE CACHE 2;     
   
     INSERT INTO t1 VALUES(seq1.NEXTVAL, seq2.NEXTVAL, seq3.NEXTVAL, seq4.NEXTVAL); 
     SELECT * FROM t1;    -- (1, 1, 100, 3, 9) ...
     
2) ������ Ȯ��
   SELECT * FROM seq;  -- * ������ �̸����� seq ��� �Ұ� 
    
3) ������ ���� 
   DROP SEQUENCE seq1;   
     
     
[SYNONYM] 
-- �ٸ� ������� ��ü�� ���� �� ���� �������� �ذ��ϱ� ���� ����ϴ� ���Ǿ�(����)
 - Private Synonym : Ư�� ����ڸ� �̿� ���� , ���� ����ڸ� ���� ����� ���Ǿ� 
 - Public Synonym  : ���� ����� �׷��� ����, DBA ������ ���� �����(������)�� ���� ����. ex) DUAL ���̺� 

1) �ó�� ���� 
 - sky �������� hr ������ employees ���̺� ���� Ȯ�� 
    SELECT * FROM hr.employees;  -- ���� : ������ ���� 
    SELECT * FROM user_sys_privs; -- ������� �ý��� ���� Ȯ�� 
    GRANT SELECT ON employees TO sky; -- hr �������� ���� �ο�     
    SELECT * FROM hr.employees;  -- ��ȸ ���� 
    SELECT * FROM employees; -- �Ұ��� 
    
 - �ó�� ���� ���� �ο� (������ ����) 
    GRANT CREATE SYNONYM TO sky;
 
 - �ó�� ���� 
    CREATE SYNONYM employees FOR hr.employees; 
    SELECT * FROM employees;  -- �տ� hr.�� ������ �ʾƵ� ��ȸ ����
    
2) �ó�� ���� Ȯ��
    SELECT * FROM syn;

3) �ó�� ����
    DROP SYNONYM employees;