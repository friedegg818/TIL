----- PL/SQL 2 
[Procedure]
- PL/SQL에서 가장 대표적인 구조 
- 자주 실행해야 하는 업무 흐름(쿼리)을 미리 작성하여 DB내에 저장해 두었다가 필요 할 때마다 실행
- 특정한 로직을 처리하고 결과를 반환하지 않는다. (java의 void와 비슷) 
- 선행 컴파일을 해서 속도가 빠르다.
- 특징
  - 패키지 내에서 중복 정의가 가능하다.
  - 테이블이 삭제된다고 연관된 프로시저가 삭제 되는 것은 아니지만, 삭제된 상태에서 실행하면 오류가 발생한다.
  - 프로시저 안에서 I/U/D 문 사용하는 경우 COMMIT; 이 필요 (자동 COMMIT 안됨)
    → 끝까지 성공해야 COMMIT, 하나라도 실패하면 ROLLBACK. (트랜잭션 작업에 굉장히 용이) 

- 프로시저 생성 및 실행 
 1) 형식
    ------------------------------------------------
    CREATE [OR REPLACE] PROCEDURE 프로시저명 
    [(인수 IN|OUT|IN OUT|)]
    IS 변수 
    BEGIN 실행부 
    END;
    /
   ------------------------------------------------
    CREATE TABLE test ( 
        num NUMBER PRIMARY KEY
        ,name VARCHAR2(30) NOT NULL 
        ,score NUMBER(3) NOT NULL 
        ,grade VARCHAR2(10) NOT NULL
    );
    
    CREATE SEQUENCE test_seq;
    
    SELECT * FROM tab;
    SELECT * FROM seq;
    ------------------------------------------------- 프로시저 만들기 
    CREATE PROCEDURE pInsertTest
    IS
    BEGIN
        INSERT INTO test(num, name, score, grade) VALUES 
        (test_seq.NEXTVAL, '홍길동', 80, '우');
        COMMIT;
    END; 
    /    

    SELECT * FROM user_procedures;
    SELECT * FROM user_dependencies;
    SELECT * FROM user_source;
    
    -- 프로시저 실행
    EXEC pInsertTest;
    SELECT * FROM test;
    
    -- 프로시저 수정 (IN 파라미터) 
    CREATE OR REPLACE PROCEDURE pInsertTest
    (
        pName VARCHAR2,  -- 파라미터는 크기 명시 X
        -- pName test.name%TYPE, 
        pScore IN NUMBER  -- IN은 생략 가능 
    )
    IS
        vgrade VARCHAR2(20); 
    BEGIN
        IF pScore>=90 THEN vgrade := '수';
        ELSIF pScore>=80 THEN vgrade := '우';
        ELSIF pScore>=70 THEN vgrade := '미';
        ELSIF pScore>=60 THEN vgrade := '양';
        ELSE vgrade := '가';
        END IF;
        
        INSERT INTO test(num, name, score, grade) VALUES 
        (test_seq.NEXTVAL, pName, pScore, vgrade);
        COMMIT;
    END; 
    /    
    EXEC pInsertTest('가가가', 88);
    EXEC pInsertTest('나나나', 90);
    
    SELECT * FROM test;
    
    -- 수정 프로시저 
    -- RAISE_APPLICATION_ERROR(error_number, message) 
    -- 사용자 정의 예외 발생. error_number : -20999 ~ -20000
    CREATE OR REPLACE PROCEDURE pUpdateTest
    (
        pNum IN test.num%TYPE,
        pName IN test.name%TYPE,        
        pScore IN test.score%TYPE 
    )
    IS
        vgrade VARCHAR2(20); 
    BEGIN
        IF pScore < 0 OR pScore > 100 THEN 
            RAISE_APPLICATION_ERROR(-20001, '점수는 0~100만 가능...');
        END IF;
        
        IF pScore>=90 THEN vgrade := '수';
        ELSIF pScore>=80 THEN vgrade := '우';
        ELSIF pScore>=70 THEN vgrade := '미';
        ELSIF pScore>=60 THEN vgrade := '양';
        ELSE vgrade := '가';
        END IF;
        
        UPDATE test SET name = pName, score=pScore, grade=vgrade 
        WHERE num = pNum;
        COMMIT;
    END; 
    / 
    
    EXEC pUpdateTest(1, 'vvv', 99);    
    EXEC pUpdateTest(2, 'aaa', 90);  
    SELECT * FROM test;
    
    EXEC pUpdateTest(2, 'aaa', 999);   -- 예외 발생 
    
    -- 삭제 프로시저 : pDeleteTest 
       -- num 을 파라미터로 넘겨 받아 조건 만족 레코드 삭제       
    CREATE OR REPLACE PROCEDURE pDeleteTest
    (
         pNum IN test.num%TYPE
    )
    IS    
    BEGIN      
        DELETE FROM test
        WHERE num = pNum;
        COMMIT;
    END;  
    /    
    
    EXEC pDeleteTest(1);
    SELECT * FROM test;
    
    -- 하나의 레코드 출력 프로시저 
    CREATE OR REPLACE PROCEDURE pSelectListTest
    IS    
    BEGIN 
        FOR rec IN (SELECT num,name,score,grade FROM test)  LOOP
        DBMS_OUTPUT.PUT_LINE(rec.num||':'||rec.name||':'||rec.score||':'||rec.grade);
        END LOOP;         
    END;
    /
    
    EXEC pSelectListTest;
    
    -- 모든 레코드 출력 프로시저
    CREATE OR REPLACE PROCEDURE pSelectOneTest 
    (
        pNum IN NUMBER 
    )
    IS 
        rec test%ROWTYPE; 
    BEGIN 
        SELECT * INTO rec FROM test WHERE num = pNum;
        DBMS_OUTPUT.PUT_LINE(rec.num||':'||rec.name||':'||rec.score||':'||rec.grade);
    END;
    /
    
    
  ----------------------------------------------------------
 - 문제 
   - 3개의 테이블 작성 
    - 테이블명 : ex1 
      num NUMBER 기본키 
      name VARCHAR2(30) NOT NULL 
    - 테이블명 : ex2
      num NUMBER 기본키, ex1 테이블 num의 참조키 
      birth DATE NOT NULL
    - 테이블명 : ex3
      num NUMBER 기본키, ex1 테이블 num의 참조키
      score NUMBER(3) NOT NULL
      grade NUMBER(2,1) NOT NULL 
      
      CREATE TABLE ex1 (
        num NUMBER
        , name VARCHAR2(30) NOT NULL 
        , CONSTRAINT pk_ex1_num PRIMARY KEY(num)
      );
      
      CREATE TABLE ex2 (
        num NUMBER PRIMARY KEY
        , birth DATE NOT NULL
        , CONSTRAINT fk_ex2_num FOREIGN KEY (num) REFERENCES ex1(num)
        );
         
      CREATE TABLE ex3 (
        num NUMBER PRIMARY KEY
        , score NUMBER(3) NOT NULL
        , grade NUMBER(2,1) NOT NULL
        , CONSTRAINT fk_ex3_num FOREIGN KEY(num) REFERENCES ex1(num)
      );
      
   - 시퀀스 작성 : ex_seq 
    - 초기:1, 증분:1, 캐시 X 
    CREATE SEQUENCE ex_seq START WITH 1 NOCACHE;
    
   - ex1, ex2, ex3 테이블에 데이터를 추가하는 프로시저 : pInsertEx 
    - num은 시퀀스 이용 
    - grade 는 score >= 90 : 4.0, score >= 80 : 3.0, score >= 70 : 2.0, score >= 60 : 1.0 , 나머지 0 
    - score가 0~100 아니거나 세개의 테이블 중 하나의 테이블에 데이터가 추가 되지 않으면 모든 테이블에 데이터가 추가되지 않는다.
   
   CREATE OR REPLACE PROCEDURE pInsertEx 
   (
      pName ex1.name%TYPE
      , pBirth ex2.birth%TYPE
      , pScore NUMBER 
   )
   IS 
     vgrade ex3.grade%TYPE;
   BEGIN
        IF pScore < 0 OR pScore > 100 THEN 
            RAISE_APPLICATION_ERROR(-20001, '점수는 0~100만 가능...');
        END IF;
   
        IF pScore >= 90 THEN vgrade := '4.0';
        ELSIF pScore >= 80 THEN vgrade := '3.0';
        ELSIF pScore >= 70 THEN vgrade := '2.0';
        ELSIF pScore >= 60 THEN vgrade := '1.0';
        ELSE vgrade := '0';
        END IF;
        
        INSERT INTO ex1(num, name) VALUES (ex_seq.NEXTVAL, pName);
        INSERT INTO ex2(num, birth) VALUES (ex_seq.CURRVAL, pBirth);    -- ex1에 있는 번호를 사용해야 하므로 
        INSERT INTO ex3(num, score, grade) VALUES (ex_seq.CURRVAL, pScore, vgrade);
        COMMIT;
   END;
   /  

   EXEC pInsertEx('보보보','2017-05-15',60);
   
    -- 수정 프로시저
          CREATE OR REPLACE PROCEDURE pUpdateEx (
              pNum    NUMBER
              ,pName    VARCHAR2
              ,pBirth  DATE
              ,pScore  NUMBER
          )
          IS
            vgrade NUMBER(2,1);
          BEGIN
             IF pScore < 0 OR pScore > 100 THEN
               RAISE_APPLICATION_ERROR(-20001, '점수는 0~100만 가능...');
             END IF;
             
             IF pScore >= 90 THEN vgrade := 4.0;
             ELSIF pScore >= 80 THEN vgrade := 3.0;
             ELSIF pScore >= 70 THEN vgrade := 2.0;
             ELSIF pScore >= 60 THEN vgrade := 1.0;
             ELSE vgrade := 0.0;
             END IF;
             
             UPDATE ex1 SET name=pName WHERE num=pNum;
             UPDATE ex2 SET birth=pBirth WHERE num=pNum;
             UPDATE ex3 SET score=pScore, grade=vgrade  WHERE num=pNum;
            COMMIT;
          END;
          /

         -- 삭제 프로시저
         CREATE OR REPLACE PROCEDURE pDeleteEx
         (
            pNum NUMBER
         )
         IS
         BEGIN
             DELETE FROM ex3 WHERE num=pNum;
             DELETE FROM ex2 WHERE num=pNum;
             DELETE FROM ex1 WHERE num=pNum;
    
             COMMIT;
    
         END;
         /

      -- 번호(num)에 해당하는 하나의 ex1, ex2, ex3 테이블 레코드 출력
      CREATE OR REPLACE PROCEDURE pSelectOneEx
      ( 
          pNum  IN  NUMBER
      )
      IS
          TYPE MYTYPE IS RECORD (
             num ex1.num%TYPE
             ,name ex1.name%TYPE
             ,birth ex2.birth%TYPE
             ,score ex3.score%TYPE
             ,grade ex3.grade%TYPE
         );
         rec MYTYPE;
      BEGIN
         SELECT e1.num, name, birth, score, grade INTO rec
         FROM ex1 e1
         LEFT OUTER JOIN ex2 e2 ON e1.num=e2.num
         LEFT OUTER JOIN ex3 e3 ON e1.num=e3.num
         WHERE e1.num=pNum;
         DBMS_OUTPUT.PUT(rec.num || ':');
         DBMS_OUTPUT.PUT(rec.name || ':');
         DBMS_OUTPUT.PUT(rec.birth || ':');
         DBMS_OUTPUT.PUT_LINE(rec.score || ':' || rec.grade);
      END;
      /

      EXEC pSelectOneEx(1);
      
      
  2) OUT 파라미터 
   - 호출한 프로시저로 값을 넘겨준다. 
   - 쓰기 전용 
   CREATE OR REPLACE PROCEDURE pSelectOutEx ( 
        pNum IN NUMBER 
        ,pName OUT VARCHAR2 
        ,pScore OUT NUMBER 
    )
    IS 
    BEGIN
        -- pNum := 1;  -- 에러. IN 파라미터는 읽기 전용 
        SELECT name, score INTO pName, pScore
        FROM ex1 a 
        JOIN ex3 b ON a.num=b.num 
        WHERE a.num = pNum; 
    END;
    /    
    
    CREATE OR REPLACE PROCEDURE pSelectEx ( 
        pNum IN NUMBER 
    ) 
    IS
        vname VARCHAR2(30);
        vscore NUMBER(3);
    BEGIN 
        -- 다른 프로시저 호출(프로시저 안에서는 EXEC 생략 가능)
        pSelectOutEx(pNum, vname, vscore);  -- pname, pscore 자리에는 반드시 변수가 와야 함 (상수 불가) 
        DBMS_OUTPUT.PUT_LINE(vname || ':' || vscore);
    END; 
    / 
    
    SELECT * FROM ex1;
    
    EXEC pSelectEx(3);
      
      
[사용자 정의 함수] 
- return 이 있음 (결과를 반환)  <- 프로시저와의 차이점 
- 시스템이 정의 하는 함수와 똑같은 역할 
- 사용자 정의 함수 생성 
   --------------------------------------------------------------------
    CREATE [OR REPLACE] FUNCTION 함수명 
    [(인수 데이터타입)] 
    RETURN 데이터타입
    IS 변수
    BEGIN 실행부 
    RETURN 반환값;
    END; 
    /
   --------------------------------------------------------------------
    *성별 
     CREATE OR REPLACE FUNCTION fnGender 
     (
        rrn VARCHAR2     -- 크기 명시 안함
     )  
     RETURN VARCHAR2     -- 크기 명시 안함 
     IS 
        s VARCHAR2(6) := '여자';   -- 초기값
     BEGIN
        IF LENGTH(rrn) != 14 THEN 
            RAISE_APPLICATION_ERROR(-20001, '주민번호 오류..');
        END IF;
        
        IF MOD(SUBSTR(rrn,8,1),2)=1 THEN 
            s := '남자';
        END IF;
        
        RETURN s;
     END;
     /
 
    *생일
     CREATE OR REPLACE FUNCTION fnBirth
     (
        rrn VARCHAR2     
     )  
     RETURN DATE  
     IS 
     BEGIN
        IF LENGTH(rrn) != 14 THEN 
            RAISE_APPLICATION_ERROR(-20001, '주민번호 오류..');
        END IF;
        
        RETURN TO_DATE(SUBSTR(rrn,1,6),'RRMMDD');
     END;
     /
     
     *나이 
     CREATE OR REPLACE FUNCTION fnAge
     (
        rrn VARCHAR2     
     )  
     RETURN NUMBER   
     IS 
        a NUMBER;
        b DATE; 
     BEGIN
        IF LENGTH(rrn) != 14 THEN 
            RAISE_APPLICATION_ERROR(-20001, '주민번호 오류..');
        END IF;
        
        b := TO_DATE(SUBSTR(rrn,1,6), 'RRMMDD');
        a := TRUNC(MONTHS_BETWEEN(SYSDATE,b)/12);
        
        RETURN a;
     END;
     /
    
     SELECT name, rrn, fnGender(rrn) 성별, TO_CHAR(fnBirth(rrn),'YYYY-MM-DD') 생일, fnAge(rrn) 나이 FROM emp;
     

 
 - 문제 
    -- 테이블 작성 
     CREATE TABLE score1 (
        hak VARCHAR2(20) 
        , name VARCHAR2(30) NOT NULL
        , kor NUMBER(3) NOT NULL
        , eng NUMBER(3) NOT NULL 
        , mat NUMBER(3) NOT NULL 
        , CONSTRAINT pk_sc1_hak PRIMARY KEY(hak)
        );
        
     CREATE TABLE score2 (
        hak VARCHAR2(20)
        , kor NUMBER(2,1) NOT NULL
        , eng NUMBER(2,1) NOT NULL
        , mat NUMBER(2,1) NOT NULL
        , CONSTRAINT pk_sc2_hak PRIMARY KEY(hak)
        , CONSTRAINT fk_sc2_hak FOREIGN KEY(hak) REFERENCES score1(hak) ON DELETE CASCADE
        );  
        
     -- 사용자 정의 함수   
     CREATE OR REPLACE FUNCTION fnGrade
     (
        s NUMBER
     )
     RETURN VARCHAR2
     IS
      g VARCHAR2(10); 
     BEGIN
       IF s>=95 AND s<=100  THEN g := '4.5';
            ELSIF s>=90 THEN g := '4.0';
            ELSIF s>=85 THEN g := '3.5';
            ELSIF s>=80 THEN g := '3.0';
            ELSIF s>=75 THEN g := '2.5';
            ELSIF s>=70 THEN g := '2.0';
            ELSIF s>=65 THEN g := '1.5';
            ELSIF s>=60 THEN g := '1.0';
            ELSE g := '0';
            END IF;
            
        RETURN g; 
     END;
     /
    
    -- 삽입 프로시저
    CREATE OR REPLACE PROCEDURE pScoreInsert
       (
          phak score1.hak%TYPE
          , pname score1.name%TYPE
          , pkor score1.kor%TYPE
          , peng score1.eng%TYPE 
          , pmat score1.mat%TYPE 
       )
       IS 
       BEGIN
           IF (pkor < 0 OR pkor > 100) OR (peng < 0 OR peng > 100) OR (pmat < 0 OR pmat > 100) THEN 
                RAISE_APPLICATION_ERROR(-20001, '점수는 0~100만 가능...');   
           END IF;
            
            INSERT INTO score1(hak, name, kor, eng, mat) VALUES (phak, pname, pkor, peng, pmat);
            INSERT INTO score2(hak, kor, eng, mat) VALUES (phak, fngrade(pkor), fngrade(peng), fngrade(pmat));   
            
            COMMIT;
       END;
       /   
       
       EXEC pScoreInsert('1111','가가가',23,73,58);
       EXEC pScoreInsert('2222','나나나',74,45,95);
       EXEC pScoreInsert('3333','다다다',56,100,83);
       
       SELECT * FROM score1;
       SELECT * FROM score2;
       
     -- 수정 프로시저 
      CREATE  OR  REPLACE  PROCEDURE  pScoreUpdate
      (
              phak    IN  VARCHAR2
              ,pname  IN  VARCHAR2
              ,pkor   IN  NUMBER
              ,peng   IN  NUMBER
              ,pmat   IN  NUMBER
      )
      IS
      BEGIN
            IF  pkor<0 OR  pkor>100 OR peng<0 OR peng>100 OR pmat<0 OR pmat>100 THEN
                 RAISE_APPLICATION_ERROR(-20001, '점수는 0~100사이만 가능합니다.');
            END IF;
      
            UPDATE score1 SET name=pname, kor=pkor, eng=peng, mat=pmat WHERE hak=phak;
            UPDATE score2 SET kor=fnGrade(pkor), eng=fnGrade(peng), mat=fnGrade(pmat) WHERE hak=phak;
            COMMIT;
      END;
      / 
     
     -- 삭제 프로시저   
     CREATE OR REPLACE PROCEDURE pScoreDelete 
     (
        phak score1.hak%TYPE
     )
     IS
     BEGIN
        DELETE FROM score1
            WHERE hak = phak;
            COMMIT;
     END;
     /
     
     EXEC pScoreDelete('1111');
     
     COMMIT;