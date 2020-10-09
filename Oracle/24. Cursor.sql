[Cursor] (커서)
 - 여러 레코드로 구성된 작업 영역에서 SQL문을 실행하고, 그 과정에 생긴 정보를 저장하기 위한 그릇 
 - 오라클 서버에 의해 실행되는 모든 SQL문은 연관된 각각의 커서를 소유하고 있다.
 
 1) 암시적 커서 : 오라클이나 PL/SQL 실행 메커니즘에 의해 SQL 문장이 처리 되는 곳에 대한 익명의 주소 
                 SQL문이 실행되는 순간 자동 OPEN - CLOSE 
                 (SQL%ROWCOUNT / SQL%FOUND / SQL%NOTFOUND / SQL%ISOPEN)
                
            -- SQL%ROWCOUNT : 해당 SQL 문에 영향을 받는 행의 수 
                DECLARE 
                    vempNo emp.empNo%TYPE;
                    vcount NUMBER;
                BEGIN
                    vempNo := '8001';
                    DELETE FROM emp WHERE empNo = vempNo; 
                    vCount := SQL%ROWCOUNT;
                    COMMIT;
                    
                    DBMS_OUTPUT.PUT_LINE(vCount || '레코드 삭제'); 
                    
                END;
                /
                
              -- SQL%NOTFOUND ㅣ 해당 SQL문에 영향을 받는 행의 수가 없을 경우 TRUE 
                DECLARE 
                    vempNo emp.empNo%TYPE;
                    vcount NUMBER;
                BEGIN
                    vempNo := '8001';
                    DELETE FROM emp WHERE empNo = vempNo; 
                    vCount := SQL%ROWCOUNT;
                    
                    IF SQL%NOTFOUND THEN 
                        RAISE_APPLICATION_ERROR(-20001, '없음');
                    END IF;
                    
                    COMMIT;
                    
                    DBMS_OUTPUT.PUT_LINE(vCount || '레코드 삭제'); 
                    
                END;
                /
               
           
 2) 명시적 커서 : 프로그래머에 의해 선언되는 이름이 있는 커서 
                * 순서 | 커서 선언(쿼리 만들기) > 커서 OPEN (실행) > FETCH (데이터 가져오기) > 커서 CLOSE 
                         
               -- 오류가 발생하는 상황 
                DECLARE
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                BEGIN
                    SELECT name, sal INTO vname, vsal FROM emp    -- 에러 : 데이터의 양이 너무 많음 
                    DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal);
                END;
                /
                
               -- 명시적 커서 이용 
                DECLARE
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                - 1.커서 선언
                   CURSOR cur_emp IS SELECT name, sal FROM emp;   -- cursor 에는 INTO 절이 없다.
                BEGIN
                - 2.커서 OPEN
                   OPEN cur_emp; 
                   
                   LOOP 
                     - 3.FETCH 
                        FETCH cur_emp INTO vname, vsal;
                        EXIT WHEN cur_emp%NOTFOUND;
                        DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal); 
                   END LOOP; 
                   
                - 4.커서 CLOSE
                   CLOSE cur_emp;   
                END;
                /
                
               -- 파라미터가 있는 커서 (이름에서 한자만 입력하여 출력)
                CREATE OR REPLACE PROCEDURE pEmpSelect 
                (
                    pName VARCHAR2 
                )
                IS
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                    
                    CURSOR cur_emp(cname emp.name%TYPE) IS 
                        SELECT name, sal FROM emp 
                        WHERE INSTR(name, cname) > 0;    
                BEGIN
                    OPEN cur_emp(pName); 
                    LOOP 
                       FETCH cur_emp INTO vname, vsal;
                       EXIT WHEN cur_emp%NOTFOUND;
                       DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal); 
                    END LOOP; 
                                   
                   CLOSE cur_emp;   
                END;
                /
                
                EXEC pEmpSelect('김');

              -- 파라미터 사용하지 않고 조건 검색 (이름에서 성만 입력하여 출력) 
                CREATE OR REPLACE PROCEDURE pEmpSelect 
                (
                    pName VARCHAR2 
                )
                IS
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                    
                    CURSOR cur_emp IS 
                        SELECT name, sal FROM emp 
                        WHERE INSTR(name, pname) = 1;    
                BEGIN
                    OPEN cur_emp; 
                    LOOP 
                       FETCH cur_emp INTO vname, vsal;
                       EXIT WHEN cur_emp%NOTFOUND;
                       DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal); 
                    END LOOP; 
                                   
                   CLOSE cur_emp;   
                END;
                /
                
                EXEC pEmpSelect('이');
                
              -- 커서 FOR LOOP : 자동 OPEN - CLOSE / 선언만 해주면 됨 
                CREATE OR REPLACE PROCEDURE pEmpSelect
                IS
                    CURSOR cur_emp IS 
                        SELECT name, sal FROM emp;
                BEGIN
                    FOR rec IN cur_emp LOOP
                        DBMS_OUTPUT.PUT_LINE(rec.name || ':' || rec.sal);
                    END LOOP;
                END;
                /
                
           -- WHERE CURRENT OF : FETCH문에 의해 가장 최근에 처리된 행을 참조
              CREATE TABLE  emp1  AS  SELECT * FROM  emp;
        
              CREATE OR REPLACE  PROCEDURE pEmpUpdateSeoul
              IS
                 vCnt   NUMBER;
                 vName  emp1.name%TYPE;
                 vSal   emp1.sal%TYPE;
                 CURSOR  cur_emp  IS
                     SELECT  name, sal  FROM  emp1  WHERE city='서울'  FOR  UPDATE; 
                            -- FOR  UPDATE : 커서를 이용하여 UPDATE할 경우 반드시 필요
              BEGIN
                  vCnt := 0;
            
                  OPEN  cur_emp;
                  LOOP
                      FETCH  cur_emp INTO  vname, vsal;
                      UPDATE emp1 SET sal = TRUNC(sal * 1.1) 
                      WHERE CURRENT OF cur_emp;    -- 커서가 현재 위치한 값 
                      EXIT WHEN  cur_emp%NOTFOUND; -- 마지막 데이터를 처리할때 예외가 발생함
                      vCnt := vCnt + 1;
                      DBMS_OUTPUT.PUT_LINE(vCnt || ':' || vname || ':' || vsal);
                  END LOOP;
                  -- 예외가 발생하여 실행 안하고 EXCEPTION 절 실행
                  COMMIT;
                  CLOSE cur_emp;
            
                  EXCEPTION  WHEN  OTHERS THEN   -- 기타 예외가 발생해도 커밋 (try~catch와 유사)
                      COMMIT;
                      DBMS_OUTPUT.PUT_LINE('수정 완료 !!!');
              END;
              /
              
              EXEC pEmpUpdateSeoul;
              
3) 커서 변수
 - 실행된 결과를 저장 할 수 있는 것 
 - REF CURSOR 커서 타입 
    > 강한 커서 타입(한 줄만 저장 가능) 
       TYPE refcur_emp IS REF CURSOR RETURN emp%ROWTYPE;     
    > 약한 커서 타입 (언제든지 사용 가능, 무엇이든지 담을 수 있음, 여러줄 저장 가능)
       TYPE refcur IS REF CURSOR;       
 - SYS_REFCURSOR : 대표적인 약한 커서 타입. 오픈된 자료형을 가질 수 있음 (2줄 이상 저장 가능) 
 
  -- SYS_REFCURSOR 사용하여 프로시저 생성 
         CREATE OR REPLACE PROCEDURE pEmpSelectList
         (
            pName IN VARCHAR2, 
            pResult OUT SYS_REFCURSOR    -- 결과가 pResult로 들어가므로 OUT 사용 
         )
         IS 
         BEGIN
            OPEN pResult FOR
                SELECT name, sal FROM emp 
                WHERE INSTR(name, pName) > 0; 
         END;
         /
 
  -- 제대로 작동 하는지 확인 
         CREATE OR REPLACE PROCEDURE pEmpSelectResult
         (
            pName IN VARCHAR2
         )
         IS
            vname   emp.name%TYPE;
            vsal    emp.sal%TYPE;
            vResult SYS_REFCURSOR;
         BEGIN
            pEmpSelectList(pName, vResult); 
            
            LOOP 
                FETCH vResult INTO vname, vsal; 
                EXIT WHEN vResult%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(vName || ':' || vsal);
            END LOOP;
         END;
         /
 
         EXEC pEmpSelectResult('김');
         

[동적 쿼리] Dynamic SQL
 - 프로시저 등에서 텍스트 쿼리를 입력 받아 동적으로 쿼리를 생성 
 - EXECUTE IMMEDIATE 
    - 테이블 작성 및 시퀀스 작성 권한 부여 
      -- 관리자 계정 
      GRANT CREATE TABLE TO sky;
      GRANT CREATE SEQUENCE TO sky;
      -- sky 계정 (유저의 시스템 권한 확인)
      SELECT * FROM user_sys_privs;

    CREATE OR REPLACE PROCEDURE pBoardCreate
    (
        pName VARCHAR2 
    )
    IS 
        s VARCHAR2(1000);
    BEGIN
        s := 'CREATE TABLE ' || pName;
        s := s || '(num NUMBER PRIMARY KEY';
        s := s || ', name VARCHAR2(30) NOT NULL';
        s := s || ', subject VARCHAR2(200) NOT NULL';
        s := s || ', content VARCHAR2(4000) NOT NULL';
        s := s || ', hitCount NUMBER DEFAULT 0';
        s := s || ', created DATE DEFAULT SYSDATE)';   
        
        FOR t IN (SELECT tname FROM tab WHERE tname = UPPER(pName)) LOOP 
            EXECUTE IMMEDIATE 'DROP TABLE ' || pName || ' PURGE'; 
            DBMS_OUTPUT.PUT_LINE(pName || ' 테이블 삭제...'); 
            EXIT;
        END LOOP;
        
        EXECUTE IMMEDIATE s;     -- 동적 쿼리 실행. 테이블 생성. 
        
        FOR i IN (SELECT sequence_name FROM seq WHERE sequence_name=UPPER(pName||'_seq')) LOOP 
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || pName || '_seq';
            DBMS_OUTPUT.PUT_LINE(pName || '_seq 시퀀스 삭제...'); 
            EXIT;
        END LOOP; 
        
        EXECUTE IMMEDIATE 'CREATE SEQUENCE ' || pName || '_seq';    -- 시퀀스 생성.
        
        DBMS_OUTPUT.PUT_LINE('테이블 및 시퀀스 작성 성공...');    
    END;
    /
    
    SELECT * FROM tab;
    SELECT * FROM seq;
    
    EXEC pBoardCreate('board');
        
