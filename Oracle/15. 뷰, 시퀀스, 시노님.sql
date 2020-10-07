
[VIEW]
-- 사용자에게 접근이 허용된 자료만을 제한적으로 보여주는 가상 테이블 (물리적으로 구현 되어있지 않음)
-- 데이터 X , SQL만 저장 (쿼리만 가지고 있다고 생각하면 쉬움) 
-- 속도가 느려서 자주 사용하는 편은 아니다.

1) VIEW 생성 
  - 뷰 생성 전 확인 할 것
     1. 해당되는 쿼리가 실행 되는지 
     2. 연산 수식은 컬럼명을 가지고 있는지 
     
  - 뷰 작성 권한 부여 (관리자 : sys 또는 system 계정에서)     
     GRANT CREATE VIEW TO 사용자;
     
  - 권한 확인 (사용자 계정에서) 
     SELECT * FROM USER_SYS_PRIVS;   
     
   -------------------------------------------------------------------------------------------
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum;
   --------------------------------------------------------------------------------------------  
  
  - 위의 쿼리로 VIEW 생성 
    CREATE VIEW panmai 
    AS 
       SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
       FROM book b
       JOIN pub p ON b.pNum = p.pNum
       JOIN dsale d ON b.bCode = d.bCode
       JOIN sale s ON d.sNum = s.sNum
       JOIN cus c  ON s.cNum = c.cNum;
    
    SELECT * FROM panmai;    
        
  - 뷰 정보 확인    
    SELECT * FROM tab; - 목록 확인. tabtype : view로 표시 
     
    SELECT * FROM col WHERE tname = 'PANMAI';  - 컬럼 정보 확인
    DESC panmai;
     
    SELECT view_name, text FROM user_views; - 소스 확인 
     
  - 뷰 수정   
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
    
 ** 예제 
  - ypanmai 뷰 만들기 (년도, bCode, bName, qty 합, qty*bPrice 합) / 년도 내림차순 정렬 
  
     CREATE VIEW ypanmai 
     AS 
         SELECT TO_CHAR(sDate,'YYYY') 년도, b.bCode 책코드, bName 책이름, 
                SUM(qty) 판매량, SUM(qty*bPrice) 판매금액 
         FROM book b 
         JOIN dsale d ON b.bCode = d.bCode 
         JOIN sale s ON d.sNum = s.sNum 
         GROUP BY TO_CHAR(sDate,'YYYY'), b.bCode, bName 
         ORDER BY 년도 DESC;
          
     SELECT * FROM ypanmai;
     SELECT * FROM ypanmai WHERE 년도 = 2019;    -- 훨씬 간단해짐 
     
     
2) VIEW를 이용한 데이터 추가, 수정, 삭제 
 
 - 단순 뷰 : 하나의 테이블로 작성
     CREATE OR REPLACE VIEW testview2
     AS 
        SELECT num, name 
        FROM test1;
        
     -- INSERT, UPDATE, DELETE 가능 (제약조건 위반하지 않으면)
        INSERT INTO testview2(num, name) VALUES (4, 'oracle'); 
        DELETE FROM testview2 WHERE num=1;
        
 - 복합 뷰 : 하나 이상의 테이블로 작성 
     CREATE OR REPLACE VIEW testview1 
     AS 
        SELECT a.num, code, name, memo, score
        FROM test1 a, test2 b WHERE a.num = b.num;
        
    -- INSERT, UPDATE, DELETE 불가능 
       INSERT INTO testview1(num,name,memo) VALUES (4, 'd', 'oracle');  -- 에러 
       UPDATE testview1 SET name = 'aa', score = 100 WHERE num=1;       -- 에러 

3) VIEW 삭제 

    DROP VIEW testview1;
    DROP VIEW testview2;
    
4) WITH CHECK OPTION 
-- 조건 컬럼 값을 변경하지 못하게 하는 옵션 
-- 뷰를 이용한 참조 무결성 검사 
-- INSERT / UPDATE 수행이 불가하다.

    CREATE OR REPLACE VIEW empView 
    AS 
      SELECT empNo, name, city, sal FROM emp1 
      WHERE city = '서울'
      WITH CHECK OPTION CONSTRAINT wc_empView;

    UPDATE empView SET city = '부산' WHERE empNo = '1059';  -- 에러 : WITH CEHCK OPTIO 조건에 위배 (ORA-01402) 
    
5) WITH READ ONLY 
-- 뷰를 통한 내용 수정을 불가능하게 만드는 옵션 


[SEQUENCE] 
-- 유일한 정수 값을 연속적으로 생성시키기 위해 사용하는 객체 
-- 기본 키 값을 자동으로 생성하고, 커밋&롤백의 영향 없이 번호가 생성되면 계속해서 시퀀스가 증가한다.
    
1) 시퀀스 생성
CREATE SEQUENCE 시퀀스명 
    START WITH     -- 시작 값 
    INCREMENT BY   -- 증가 값 (생략하면 1, 양수 음수 모두 가능) 
    [NO]MAXVALUE   -- 생성 할 수 있는 최대값 
    [NO]MINVALUE   -- 생성 할 수 있는 최소값 / CYCLE 시 시작 값 
    [NO]CYCLE      -- 순환 (최소 OR 최대값 도달 후 값을 계속 생성) / CYCLE 설정 시 반드시 CACHE를 지정해야 함
    [NO]CACHE      -- 미리 할당 하는 데이터의 수 / 중간에 프로그램이 종료되면 건너뛰는 숫자가 생긴다
                   -- 아무것도 적지 않으면 기본으로 20개 캐시 

 - 1부터 1씩 증가 
     CREATE SEQUENCE seq0;     

 - 1부터 1씩 증가
   CREATE SEQUENCE seq1 START WITH 1 INCREMENT BY 1 
        NOMAXVALUE NOCYCLE NOCACHE;  

 - 100부터 1씩 증가 
    CREATE SEQUENCE seq2 START WITH 100 INCREMENT BY 1 
        MINVALUE 1 MAXVALUE 1000;
        
 - 3부터 999까지 3씩 증가. cache 5개
   CREATE SEQUENCE seq3 START WITH 3 INCREMENT BY 3 
        MINVALUE 3 MAXVALUE 999 CACHE 5;
        
 - 9부터 4씩 증가         
   CREATE SEQUENCE seq4 START WITH 9 INCREMENT BY 4 
       MINVALUE 3 MAXVALUE 12 CYCLE CACHE 2;     
   
     INSERT INTO t1 VALUES(seq1.NEXTVAL, seq2.NEXTVAL, seq3.NEXTVAL, seq4.NEXTVAL); 
     SELECT * FROM t1;    -- (1, 1, 100, 3, 9) ...
     
2) 시퀀스 확인
   SELECT * FROM seq;  -- * 시퀀스 이름으로 seq 사용 불가 
    
3) 시퀀스 삭제 
   DROP SEQUENCE seq1;   
     
     
     
[SYNONYM] 
-- 다른 사용자의 객체를 참조 할 때의 불편함을 해결하기 위해 사용하는 동의어(별명)
 - Private Synonym : 특정 사용자만 이용 가능 , 개별 사용자를 위한 비공개 동의어 
 - Public Synonym  : 공용 사용자 그룹이 소유, DBA 권한을 가진 사용자(관리자)만 생성 가능. ex) DUAL 테이블 

1) 시노님 생성 
 - sky 계정에서 hr 계정의 employees 테이블 내용 확인 
    SELECT * FROM hr.employees;  -- 에러 : 권한이 없음 
    SELECT * FROM user_sys_privs; -- 사용자의 시스템 권한 확인 
    GRANT SELECT ON employees TO sky; -- hr 계정에서 권한 부여     
    SELECT * FROM hr.employees;  -- 조회 가능 
    SELECT * FROM employees; -- 불가능 
    
 - 시노님 생성 권한 부여 (관리자 계정) 
    GRANT CREATE SYNONYM TO sky;
 
 - 시노님 생성 
    CREATE SYNONYM employees FOR hr.employees; 
    SELECT * FROM employees;  -- 앞에 hr.을 붙이지 않아도 조회 가능
    
2) 시노님 정보 확인
    SELECT * FROM syn;

3) 시노님 삭제
    DROP SYNONYM employees;

