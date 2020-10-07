[TRIGGER]
 - 미리 정해 놓은 특정 조건을 만족하거나, 어떤 동작을 하면 자동으로 실행되도록 정의한 것 
 - 트리거 실행 조건이 될 수 있는 것 
    1. DML - DELETE, INSERT, UPDATE
    2. DDL - CREATE, ALTER, DROP
    3. DB 작업 - SERVERERROR, LOGON, LOGOFF, STARTUP, SHUTDOWN
 - 유형 (DML 트리거, INSTEAD OF 트리거, 시스템 트리거)
 - 트리거 생성 권한 부여 
   GRANT CREATE TRIGGER TO 사용자;    


 1) 문장 트리거 - DML 문장 실행 횟수와 상관 없이 트리거는 1번만 실행 
 
    CREATE TABLE ex (
        num NUMBER PRIMARY KEY
        , name VARCHAR2(30) NOT NULL
    );
    
    CREATE TABLE ex_time(
        memo VARCHAR2(100)
        , created DATE DEFAULT SYSDATE
    );

    -- 문장 트리거 생성
    CREATE OR REPLACE TRIGGER tri_Ex 
    AFTER INSERT OR UPDATE OR DELETE ON ex 
    BEGIN
        IF INSERTING THEN 
            INSERT INTO ex_time(memo) VALUES('추가');
        ELSIF UPDATING THEN 
            INSERT INTO ex_time(memo) VALUES('수정');
        ELSIF DELETING THEN 
            INSERT INTO ex_time(memo) VALUES('삭제');
        END IF; 
          -- 트리거 안에서 INSERT, DELETE, UPDATE는 자동 COMMIT 되므로 COMMIT 문을 기술하지 않는다.
    END;
    / 
    
    -- 트리거 정보 확인    
    SELECT * FROM user_triggers; -- 목록 확인
    SELECT * FROM user_source;   -- 소스 확인
    
    -- DML문 실행 
    INSERT INTO ex VALUES(1,'a');
    INSERT INTO ex VALUES(2,'b');
    COMMIT;
    
    UPDATE ex SET name = 'aa' WHERE num=1;
    COMMIT;

    DELETE FROM ex;  -- 2번 실행 
    COMMIT;
    
    SELECT * FROM ex_time;  -- 삭제는 2번 실행 되어도 트리거는 1번만 실행됨 
    
    -- 지정시간이 지나면 작업을 하지 못하도록
    CREATE OR REPLACE TRIGGER tri_Ex2
    AFTER INSERT OR UPDATE OR DELETE ON ex
    BEGIN
        IF TO_CHAR(SYSDATE,'D') IN (1, 7) OR
           ( TO_CHAR(SYSDATE, 'HH24') >= 15 AND TO_CHAR(SYSDATE,'HH24') <= 16) THEN 
         RAISE_APPLICATION_ERROR(-20001, '지금은 일을 못함...'); 
        END IF;
   END;
   /
   
   INSERT INTO ex VALUES(1,'a');
   COMMIT;
   SELECT * FROM ex;
    
    
 2) 행 트리거 - DML 문장 실행 횟수(행)만큼 트리거 실행 
               ex) 10개의 행이 삭제되면 트리거도 10번 실행 

    CREATE TABLE score1 (
        hak VARCHAR2(20) PRIMARY KEY 
        , name VARCHAR2(30) NOT NULL
        , kor NUMBER(3) NOT NULL
        , eng NUMBER(3) NOT NULL
        , mat NUMBER(3) NOT NULL 
    );
    
    CREATE TABLE score2 (
        hak VARCHAR2(20) PRIMARY KEY 
        , kor NUMBER(2,1) NOT NULL
        , eng NUMBER(2,1) NOT NULL
        , mat NUMBER(2,1) NOT NULL 
        , FOREIGN KEY(hak) REFERENCES score1(hak)
    );

    CREATE OR REPLACE FUNCTION fnGrade ( 
        pScore NUMBER 
    )
    RETURN NUMBER 
    IS 
        n NUMBER(2,1);
    BEGIN 
        IF pScore>=95 THEN n:=4.5;
        ELSIF pScore>=90 THEN n:=4.0;
        ELSIF pScore>=85 THEN n:=3.5;
        ELSIF pScore>=80 THEN n:=3.0;
        ELSIF pScore>=75 THEN n:=2.5;
        ELSIF pScore>=70 THEN n:=2.0;
        ELSIF pScore>=65 THEN n:=1.5;
        ELSIF pScore>=60 THEN n:=1.0;
        ELSE n:=0.0;
        END IF;
        
        RETURN n; 
    END;
    /
    
    SELECT fnGrade(90) FROM dual;
    
    -- 행 트리거 생성(INSERT)
    CREATE OR REPLACE TRIGGER tri_scoreInsert 
    AFTER INSERT ON score1 
    FOR EACH ROW           -- 행 트리거 
    DECLARE 
    BEGIN
      -- :NEW -> insert한 행 내용 (행트리거만 사용 가능) 
      INSERT INTO score2(hak, kor, eng, mat) VALUES (
            :NEW.hak, fnGrade(:NEW.kor), fnGrade(:NEW.eng), fnGrade(:NEW.mat)
            );
    END;
    /
    
    -- DML문 실행
    INSERT INTO score1 VALUES('1', 'aaa', 90, 85, 70);
    INSERT INTO score1 VALUES('2', 'bbb', 85, 60, 77);
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;
    
    -- 행 트리거 생성 (UPDATE)
    CREATE OR REPLACE TRIGGER tri_scoreUpdate
    AFTER UPDATE ON score1 
    FOR EACH ROW         
    DECLARE 
    BEGIN
      -- :OLD -> update 하기 전 행 내용 (행트리거만 사용 가능)
      -- :NEW -> 새로 update 한 행 내용 (행트리거만 사용 가능)
      UPDATE score2 SET kor = fnGrade(:NEW.kor), eng = fnGrade(:NEW.eng), mat = fnGrade(:NEW.mat)
            WHERE hak = :OLD.hak;
    END;
    /
    
    UPDATE score1 SET kor = 100 WHERE hak ='2';
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;
    
    -- 행 트리거 생성 (DELETE) 
    CREATE OR REPLACE TRIGGER tri_scoreDelete
    BEFORE DELETE ON score1      -- score2의 데이터가 있으면 score1을 삭제 할 수 없으므로 
    FOR EACH ROW         
    DECLARE 
    BEGIN
      -- :OLD -> delete 할 행 내용 (행트리거만 사용 가능)
      DELETE FROM score2 WHERE hak = :OLD.hak; 
    END;
    /
    
    DELETE FROM score1; 
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;
    
 3) 트리거 관리 
    
    ALTER TRIGGER 트리거 이름 ENABLE | DISABLE; 
    
    ALTER TABLE 테이블명 ENABLE | DISABLE ALL TRIGGERS;
    
    SELECT 테이블명 FROM user_triggers; 
    
 
 * 트리거 실습 
  1. 테이블 작성 
   
 -- 상품 테이블
     CREATE TABLE 상품 (
       상품코드    VARCHAR2(6) NOT NULL PRIMARY KEY
      ,상품명      VARCHAR2(30)  NOT NULL
      ,제조사      VARCHAR2(30)  NOT NULL
      ,소비자가격  NUMBER
      ,재고수량    NUMBER DEFAULT 0
    );

 -- 입고 테이블
    CREATE TABLE 입고 (
       입고번호   NUMBER PRIMARY KEY
      ,상품코드   VARCHAR2(6) NOT NULL
                      CONSTRAINT fk_ibgo_no REFERENCES 상품(상품코드)
      ,입고일자   DATE
      ,입고수량   NUMBER
      ,입고단가   NUMBER
    );

 -- 판매 테이블
    CREATE TABLE 판매 (
       판매번호   NUMBER  PRIMARY KEY
      ,상품코드   VARCHAR2(6) NOT NULL
            CONSTRAINT fk_pan_no REFERENCES 상품(상품코드)
      ,판매일자   DATE
      ,판매수량   NUMBER
      ,판매단가   NUMBER
    );

 -- 상품 테이블에 자료 추가
    INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
            ('AAAAAA', '디카', '삼싱', 100000);
    INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
            ('BBBBBB', '컴퓨터', '엘디', 1500000);
    INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
            ('CCCCCC', '모니터', '삼싱', 600000);
    INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
            ('DDDDDD', '핸드폰', '다우', 500000);
    INSERT INTO 상품(상품코드, 상품명, 제조사, 소비자가격) VALUES
             ('EEEEEE', '프린터', '삼싱', 200000);
    COMMIT;
    
   2. 트리거 작성 
    
    <입고 테이블>     
  -- INSERT 트리거 (입고 테이블에 자료가 추가 되는 경우, 상품 테이블의 재고수량이 변경 되도록)
      CREATE OR REPLACE TRIGGER insTrg_lpgo
      AFTER INSERT ON 입고 
      FOR EACH ROW 
      BEGIN
         UPDATE 상품 SET 재고수량 = 재고수량 + :NEW.입고수량 WHERE 상품코드 = :NEW.상품코드;
      END;
      /

 -- 입고 테이블에 데이터 입력
        INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
                      VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
        INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
                      VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
        INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
                      VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
        INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
                      VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
        INSERT INTO 입고 (입고번호, 상품코드, 입고일자, 입고수량, 입고단가)
                      VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);
        COMMIT;  
      
      SELECT * FROM 상품;
      SELECT * FROM 입고;

 -- UPDATE 트리거 (입고 테이블의 자료가 변경 되는 경우, 상품 테이블의 재고수량이 변경)
        CREATE OR REPLACE TRIGGER uptTrg_lpgo
        AFTER UPDATE ON 입고 
        FOR EACH ROW 
        BEGIN 
            UPDATE 상품 SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량 WHERE 상품코드 = :NEW.상품코드;
        END;
        /
        
        UPDATE 입고 SET 입고수량 = 30 WHERE 입고번호 = 5;
        COMMIT;
        
        SELECT * FROM 상품;
        SELECT * FROM 입고;

 -- DELETE 트리거 (입고 테이블의 자료가 삭제되는 경우, 상품 테이블의 재고수량이 변경)
    CREATE OR REPLACE TRIGGER delTrg_lpgo
    AFTER DELETE ON 입고 
    FOR EACH ROW 
    BEGIN
        UPDATE 상품 SET 재고수량 = 재고수량 - :OLD.입고수량 WHERE 상품코드 = :OLD.상품코드;
    END;
    /
    
    DELETE FROM 입고 WHERE 입고번호 = 5;
    COMMIT;
    SELECT * FROM 상품;
    SELECT * FROM 입고;

   <판매 테이블>
 -- INSERT 트리거 (판매 테이블에 자료가 추가되는 경우 상품 테이블의 재고수량이 변경)
    CREATE OR REPLACE TRIGGER insTrg_Pan
    BEFORE INSERT ON 판매 
    FOR EACH ROW 
    
    DECLARE 
        j_qty NUMBER;
    BEGIN 
        SELECT 재고수량 INTO j_qty FROM 상품 WHERE 상품코드 = :NEW.상품코드; 
        IF :NEW.판매수량 > j_qty THEN 
            RAISE_APPLICATION_ERROR(-20007, '판매 오류');
        ELSE
            UPDATE 상품 SET 재고수량 = 재고수량 - :NEW.판매수량 WHERE 상품코드 = :NEW.상품코드;
        END IF;
    END;
    /

    INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES
             (1, 'AAAAAA', '2004-11-10', 5, 1000000);
    COMMIT;
    SELECT * FROM 상품;
    SELECT * FROM 판매;
    
    INSERT INTO 판매 (판매번호, 상품코드, 판매일자, 판매수량, 판매단가) VALUES
             (1, 'AAAAAA', '2004-11-10', 50, 1000000);

 -- UPDATE 트리거 (판매 테이블의 자료가 변경되는 경우 상품 테이블의 재고수량이 변경되도록)
    CREATE OR REPLACE TRIGGER uptTrg_Pan
    BEFORE UPDATE ON 판매
    FOR EACH ROW
    
    DECLARE 
        j_qty NUMBER;
    BEGIN
        SELECT 재고수량 INTO j_qty FROM 상품 WHERE 상품코드 = :NEW.상품코드; 
        IF :NEW.판매수량 > (j_qty + :OLD.판매수량) THEN 
            RAISE_APPLICATION_ERROR(-20007, '판매량이 재고량 보다 많습니다.');
        ELSE
            UPDATE 상품 SET 재고수량 = 재고수량 + :OLD.판매수량 - :NEW.판매수량 WHERE 상품코드 = :NEW.상품코드;
        END IF;
    END;
    /

    UPDATE 판매 SET 판매수량 = 200 WHERE 판매번호 = 1;
    UPDATE 판매 SET 판매수량 = 10 WHERE 판매번호 = 1;
    COMMIT;
    SELECT * FROM 상품;
    SELECT * FROM 판매;


 -- DELETE 트리거 (판매 테이블에 자료가 삭제되는 경우 상품 테이블의 재고수량이 변경)
    CREATE OR REPLACE TRIGGER delTrg_Pan
    AFTER DELETE ON 판매 
    FOR EACH ROW 
    
    BEGIN
       UPDATE 상품 SET 재고수량 = 재고수량 + :OLD.판매수량 WHERE 상품코드 = :OLD.상품코드;   
    END;
    /
    -- DELETE 테스트
    DELETE 판매 WHERE 판매번호 = 1;
    COMMIT;
    
    SELECT * FROM 상품;
    SELECT * FROM 판매;

** 하나의 트리거로 작성
CREATE OR REPLACE TRIGGER Trg_IN
AFTER INSERT OR UPDATE OR DELETE ON 입고 
FOR EACH ROW

BEGIN 
    IF INSERTING THEN 
        UPDATE 상품 SET 재고수량 = 재고수량 + :NEW.입고수량 WHERE 상품코드 = :NEW.상품코드;        
    ELSIF UPDATING THEN
        UPDATE 상품 SET 재고수량 = 재고수량 - :OLD.입고수량 + :NEW.입고수량 WHERE 상품코드 = :NEW.상품코드;
    ELSIF DELETING THEN 
        UPDATE 상품 SET 재고수량 = 재고수량 - :OLD.입고수량 WHERE 상품코드 = :OLD.상품코드;
    END IF;
END;


[Package]
 - 오라클에 저장된 서로 관련 있는 PL/SQL 프로시저, 함수, 타입 등을 논리적으로 묶어 놓은 집합 
 - 선언부 + 본문(구현부) 
 - 패키지 내에서는 프로시저와 함수의 오버로딩이 가능 
 - 패키지 목록 확인 
   SELECT * FROM user_objects WHERE object_type = 'PACKAGE'; 
   SELECT * FROM user_objects WHERE object_type = 'PACKAGE_BODY'; 
   SELECT * FROM user_procedures WHERE object_type = 'PACKAGE';  -- 패키지 내의 프로시저, 함수 목록
   
 1) 패키지 생성 
  - 선언부 | 패키지에 포함될 PL/SQL 프로시저, 함수, 커서, 변수, 예외절 선언 (패키지 전체에 적용됨)
   * 형식 
    CREATE OR REPLACE PACKAGE 패키지명 IS
        [변수 선언절] 
        [커서 선언절]
        [예외 선언절]
        [함수 선언절]       FUNCTION 함수명(인수) RETURN 리턴타입;
        [프로시저 선언절]    PROCEDURE 프로시저명(인수); 
    END 패키지명; 
    
  - 구현부 | 패키지에서 선언된 프로시저나 함수의 몸체 구현 
   * 형식
    CREATE OR REPLACE PACKAGE BODY 패키지명 IS
        [함수 구현]
           FUNCTION 함수명(인수) 
           RETURN 리턴타입
           IS 변수 선언 
           BEGIN 함수 몸체 구현
           RETURN 리턴값; 
           END;
        [프로시저 구현]
           PROCEDURE 프로시저명(인수)
           IS 변수선언
           BEGIN 프로시저 몸체 구현
           END;
    END 패키지명;
   
 2) 패키지 내 프로시저 OR 함수 실행 
    EXEC 패키지명.프로시저명(인수); 
    
 3) 패키지 삭제 
    DROP PACKAGE 패키지명;  -- 선언부와 몸체 삭제
    DROP PACKAGE BODY 패키지명; -- 몸체 삭제
    
   -----------------------------------------------------------------------------------------------------
    - 패키지 선언
    CREATE OR REPLACE PACKAGE pEmp IS 
        FUNCTION fnTax(p IN NUMBER) RETURN NUMBER;
        PROCEDURE empList(pName VARCHAR2);
        PROCEDURE empList;                 -- 프로시저 중복정의 
    END pEmp;
    /
    
    - 몸체 구현
    CREATE OR REPLACE PACKAGE BODY pEmp IS 
        FUNCTION fnTax(p IN NUMBER) 
        RETURN NUMBER
        IS 
            t NUMBER := 0;
        BEGIN
            IF p >= 3000000 THEN t := TRUNC(p * 0.03, -1); 
            ELSIF p >= 2000000 THEN t := TRUNC(p * 0.02, -1);
            ELSE t := 0;
            END IF;
            
            RETURN t;
        END;
        
        PROCEDURE empList(pName VARCHAR2)
        IS 
            vName VARCHAR2(30);
            vSal NUMBER;
            CURSOR cur_emp IS 
                SELECT name, sal FROM emp WHERE INSTR(name, pName)=1; 
        BEGIN
            OPEN cur_emp;
            LOOP 
                FETCH cur_emp INTO vName, vSal; 
                EXIT WHEN cur_emp%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(vName||' '||vSal); 
            END LOOP;
            CLOSE cur_emp;
        END;
        
        PROCEDURE empList
        IS 
        BEGIN 
            FOR rec IN (SELECT name, sal+bonus pay, fnTax(sal+bonus) tax FROM emp) LOOP
                DBMS_OUTPUT.PUT_LINE(rec.name||' '||rec.pay||' '||rec.tax); 
            END LOOP;
        END;
    END pEmp;
    /
    
    - 패키지 실행 
    EXEC pEmp.empList('김');
    EXEC pEmp.empList();
    
    - 패키지 목록 확인 
    SELECT * FROM user_objects;
    SELECT * FROM user_procedures;
    
    - 패키지 삭제 
    DROP PACKAGE pEmp;
         