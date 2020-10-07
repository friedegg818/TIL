 [ 트랜잭션(Transaction) ]
 
   ο COMMIT 과 ROLLBACK
   
   CREATE TABLE  emp1  AS SELECT empNo, name, city FROM emp;
   
   INSERT INTO emp1 VALUES ('9999', 'aaa', '서울');
   SELECT * FROM emp1;
   
   SAVEPOINT a;
   
   UPDATE emp1 SET city='bbb';
   SELECT * FROM emp1;
   
   ROLLBACK TO a;
         -- UPDATE만 롤백
		 
   SELECT * FROM emp1;
   
   COMMIT;
   SELECT * FROM emp1;


   ο 트랜잭션 관련 설정
     1) SET TRANSACTION

	-------------------------
	cmd>sqlplus  sky/"java$!"
	SQL> SHOW  AUTOCOMMIT
	AUTOCOMMIT OFF  -- DML은 자동  COMMIT 되지 않는다.

	SQL> SET AUTOCOMMIT ON

	SQL> INSERT emp1 VALUES('7777', 'a', 'a');

	SQL> SET AUTOCOMMIT OFF
	-------------------------
	-- 커넥션1
	INSERT INTO emp1 VALUES('5555, 'b', b');
	SELECT * FROM emp1;

	-- 커넥션2
	SELECT * FROM emp1;
		-- 추가된거 안보임

	-- 커넥션1
	COMMIT;

	-- 커넥션2
	SELECT * FROM emp1;
		-- 보임

	-- 커넥션1
	SET TRANSACTION READ ONLY;
	DELETE FROM emp1;
	       -- 에러. SELECT 만 가능

	ROLLBACK;

	SET TRANSACTION READ WRITE;

	     2) LOCK TABLE

	-- 커넥션1
	SELECT * FROM emp1;

	UPDATE emp1 SET city='aaa' WHERE empNo='1001';
	SET TIME ON;

	-- 커넥션2
	SELECT * FROM emp1  FOR UPDATE  WAIT 5;
	     -- 5초 후 에러

	-- 커넥션1
	ROLLBACK;

	LOCK TABLE  emp1  IN  EXCLUSIVE  MODE;
		       -- 잠긴 테이블에 DML을 허용하지 않음
				   -- DML 후 COMMIT 또는 ROLLBACK을 해야 다른 커넥션은 DML 가능
	DELETE FROM  emp1;


	-- 커넥션2
	UPDATE  emp1  SET  city='aaa' WHERE empNo='1001';

	-- 커넥션1
	ROLLBACK;

	-- 커넥션2
	ROLLBACK;

	      -------------------------------------------------------
	      -- COMMIT이 되지 않는 상태 확인
	      -- 관리자(sys 또는 system) 계정에서 확인
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
		
