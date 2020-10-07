�� Ʈ�����
 �� Ʈ�����(Transaction)
   �� COMMIT �� ROLLBACK
   
   CREATE TABLE  emp1  AS SELECT empNo, name, city FROM emp;
   
   INSERT INTO emp1 VALUES ('9999', 'aaa', '����');
   SELECT * FROM emp1;
   
   SAVEPOINT a;
   
   UPDATE emp1 SET city='bbb';
   SELECT * FROM emp1;
   
   ROLLBACK TO a;
         -- UPDATE�� �ѹ�
		 
   SELECT * FROM emp1;
   
   COMMIT;
   SELECT * FROM emp1;


   �� Ʈ����� ���� ����
     1) SET TRANSACTION

-------------------------
cmd>sqlplus  sky/"java$!"
SQL> SHOW  AUTOCOMMIT
AUTOCOMMIT OFF  -- DML�� �ڵ�  COMMIT ���� �ʴ´�.

SQL> SET AUTOCOMMIT ON

SQL> INSERT emp1 VALUES('7777', 'a', 'a');

SQL> SET AUTOCOMMIT OFF
-------------------------
-- Ŀ�ؼ�1
INSERT INTO emp1 VALUES('5555, 'b', b');
SELECT * FROM emp1;

-- Ŀ�ؼ�2
SELECT * FROM emp1;
        -- �߰��Ȱ� �Ⱥ���

-- Ŀ�ؼ�1
COMMIT;

-- Ŀ�ؼ�2
SELECT * FROM emp1;
        -- ����

-- Ŀ�ؼ�1
SET TRANSACTION READ ONLY;
DELETE FROM emp1;
       -- ����. SELECT �� ����
	   
ROLLBACK;

SET TRANSACTION READ WRITE;

     2) LOCK TABLE

-- Ŀ�ؼ�1
SELECT * FROM emp1;

UPDATE emp1 SET city='aaa' WHERE empNo='1001';
SET TIME ON;

-- Ŀ�ؼ�2
SELECT * FROM emp1  FOR UPDATE  WAIT 5;
     -- 5�� �� ����
	 
-- Ŀ�ؼ�1
ROLLBACK;

LOCK TABLE  emp1  IN  EXCLUSIVE  MODE;
               -- ��� ���̺� DML�� ������� ����
			   -- DML �� COMMIT �Ǵ� ROLLBACK�� �ؾ� �ٸ� Ŀ�ؼ��� DML ����
DELETE FROM  emp1;


-- Ŀ�ؼ�2
UPDATE  emp1  SET  city='aaa' WHERE empNo='1001';

-- Ŀ�ؼ�1
ROLLBACK;

-- Ŀ�ؼ�2
ROLLBACK;

      -------------------------------------------------------
      -- COMMIT�� ���� �ʴ� ���� Ȯ��
      -- ������(sys �Ǵ� system) �������� Ȯ��
        SELECT s.inst_id inst, s.sid||','||s.serial# sid, s.username,
                    s.program, s.status, s.machine, s.service_name,
                    '_SYSSMU'||t.xidusn||'$' rollname, --r.name rollname, 
                    t.used_ublk, 
                   ROUND(t.used_ublk * 8192 / 1024 / 1024, 2) used_bytes,
                   s.prev_sql_id, s.sql_id
        FROM gv$session s,
                  --v$rollname r,
                  gv$transaction t
        WHERE s.saddr = t.ses_addr
        ORDER BY used_ublk, machine;