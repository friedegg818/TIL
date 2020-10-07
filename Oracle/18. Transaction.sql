
[트랜잭션(Transaction)]
   -- 하나의 논리적 작업 단위를 구성하는 하나 이상의 sql문 
   -- 사용자 / 오라클 서버 / 개발자 / DBA 등에게 데이터 일치성과 동시발생을 보장하기 위하여 사용함 
 
   - COMMIT 과 ROLLBACK
     - COMMIT : 트랜잭션의 효과를 데이터베이스에 확정 
        - 커밋 전 상태 
           1. 롤백 세그먼트 버퍼가 서버에 생성
           2. 트랜잭션의 소유자는 SELECT문을 사용하여 트랜잭션의 효과를 볼 수 있음 
           3. 데이터베이스의 다른 용법으로는 트랜잭션의 효과를 볼 수 없음 
           4. 영향을 받은 행들은 LOCK 되며 다른 사용자들은 이 안에 있는 데이터를 변경 할 수 없음 
      
        - 커밋 후 상태 
          1. 영향 받은 행에 수용된 LOCK 해제 
          2. 트랜잭션이 완료 된 것으로 표시됨 
          3. 서버의 내부 트랜잭션 테이블이 시스템 변경 번호 생성 > 트랜잭션에 대입 > 번호를 모두 테이블에 저장 
      
     - ROLLBACK : 트랜잭션의 효과를 데이터베이스에 취소 
        - 롤백 후 상태 
          1. 롤백 명령을 실행하면 현재 트랜잭션이 향한 모든 변경을 해제 함 
   
        ------------------------------------------------------------------
        CREATE TABLE  emp1  AS SELECT empNo, name, city FROM emp;
   
        INSERT INTO emp1 VALUES ('9999', 'aaa', '서울');
        SELECT * FROM emp1;
   
        SAVEPOINT a;
   
        UPDATE emp1 SET city='bbb';
        SELECT * FROM emp1;
   
        ROLLBACK TO a;        -- UPDATE만 롤백
		 
        SELECT * FROM emp1;
   
        COMMIT;
        SELECT * FROM emp1;
        ------------------------------------------------------------------


   - 트랜잭션 관련 설정      
     1) SET TRANSACTION
	-------------------------
	cmd>sqlplus  sky/"java$!"
	SQL> SHOW  AUTOCOMMIT
	AUTOCOMMIT OFF            -- DML은 자동  COMMIT 되지 않는다.

	SQL> SET AUTOCOMMIT ON

	SQL> INSERT emp1 VALUES('7777', 'a', 'a');

	SQL> SET AUTOCOMMIT OFF
	-------------------------
 
	-- 커넥션1
	   INSERT INTO emp1 VALUES('5555, 'b', b');
	   SELECT * FROM emp1;

	-- 커넥션2
	   SELECT * FROM emp1;   	-- 추가 된 것이 안보임

	-- 커넥션1
	   COMMIT;

	-- 커넥션2
	   SELECT * FROM emp1;         -- 커밋 후에는 보임

	-- 커넥션1
	   SET TRANSACTION READ ONLY;
	   DELETE FROM emp1;   	       -- 에러. SELECT 만 가능

	   ROLLBACK;

	   SET TRANSACTION READ WRITE;

	    
    2) LOCK TABLE 
	-- 커넥션1
	   SELECT * FROM emp1;

	   UPDATE emp1 SET city='aaa' WHERE empNo='1001';
	   SET TIME ON;

	-- 커넥션2
	   SELECT * FROM emp1  FOR UPDATE  WAIT 5;     -- 5초 후 에러

	-- 커넥션1
	   ROLLBACK;

	   LOCK TABLE  emp1  IN  EXCLUSIVE  MODE;      -- 잠긴 테이블에 DML을 허용하지 않음
				                       -- DML 후 COMMIT 또는 ROLLBACK을 해야 다른 커넥션은 DML 가능
	   DELETE FROM  emp1;

	-- 커넥션2
	   UPDATE  emp1  SET  city='aaa' WHERE empNo='1001';

	-- 커넥션1
	   ROLLBACK;

	-- 커넥션2
	   ROLLBACK;
 
        -------------------------------------------------------
	
        ** 참고 :  COMMIT이 되지 않는 상태 확인
	   -- 관리자(sys 또는 system) 계정에서 확인
 
	     SELECT s.inst_id inst, s.sid||','||s.serial# sid, s.username,
	            s.program, s.status, s.machine, s.service_name,
	            '_SYSSMU'||t.xidusn||'$' rollname, --r.name rollname, 
		    t.used_ublk, 
	            ROUND(t.used_ublk * 8192 / 1024 / 1024, 2) used_bytes,
		    s.prev_sql_id, s.sql_id
	     FROM gv$session s,  		  --v$rollname r,
		  gv$transaction t
	    WHERE s.saddr = t.ses_addr
	    ORDER BY used_ublk, machine;
		
