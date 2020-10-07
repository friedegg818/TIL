----- PL/SQL 2 
[Procedure]
- PL/SQL���� ���� ��ǥ���� ���� 
- ���� �����ؾ� �ϴ� ���� �帧(����)�� �̸� �ۼ��Ͽ� DB���� ������ �ξ��ٰ� �ʿ� �� ������ ����
- Ư���� ������ ó���ϰ� ����� ��ȯ���� �ʴ´�. (java�� void�� ���) 
- ���� �������� �ؼ� �ӵ��� ������.
- Ư¡
  - ��Ű�� ������ �ߺ� ���ǰ� �����ϴ�.
  - ���̺��� �����ȴٰ� ������ ���ν����� ���� �Ǵ� ���� �ƴ�����, ������ ���¿��� �����ϸ� ������ �߻��Ѵ�.
  - ���ν��� �ȿ��� I/U/D �� ����ϴ� ��� COMMIT; �� �ʿ� (�ڵ� COMMIT �ȵ�)
    �� ������ �����ؾ� COMMIT, �ϳ��� �����ϸ� ROLLBACK. (Ʈ����� �۾��� ������ ����) 

- ���ν��� ���� �� ���� 
 1) ����
    ------------------------------------------------
    CREATE [OR REPLACE] PROCEDURE ���ν����� 
    [(�μ� IN|OUT|IN OUT|)]
    IS ���� 
    BEGIN ����� 
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
    ------------------------------------------------- ���ν��� ����� 
    CREATE PROCEDURE pInsertTest
    IS
    BEGIN
        INSERT INTO test(num, name, score, grade) VALUES 
        (test_seq.NEXTVAL, 'ȫ�浿', 80, '��');
        COMMIT;
    END; 
    /    

    SELECT * FROM user_procedures;
    SELECT * FROM user_dependencies;
    SELECT * FROM user_source;
    
    -- ���ν��� ����
    EXEC pInsertTest;
    SELECT * FROM test;
    
    -- ���ν��� ���� (IN �Ķ����) 
    CREATE OR REPLACE PROCEDURE pInsertTest
    (
        pName VARCHAR2,  -- �Ķ���ʹ� ũ�� ��� X
        -- pName test.name%TYPE, 
        pScore IN NUMBER  -- IN�� ���� ���� 
    )
    IS
        vgrade VARCHAR2(20); 
    BEGIN
        IF pScore>=90 THEN vgrade := '��';
        ELSIF pScore>=80 THEN vgrade := '��';
        ELSIF pScore>=70 THEN vgrade := '��';
        ELSIF pScore>=60 THEN vgrade := '��';
        ELSE vgrade := '��';
        END IF;
        
        INSERT INTO test(num, name, score, grade) VALUES 
        (test_seq.NEXTVAL, pName, pScore, vgrade);
        COMMIT;
    END; 
    /    
    EXEC pInsertTest('������', 88);
    EXEC pInsertTest('������', 90);
    
    SELECT * FROM test;
    
    -- ���� ���ν��� 
    -- RAISE_APPLICATION_ERROR(error_number, message) 
    -- ����� ���� ���� �߻�. error_number : -20999 ~ -20000
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
            RAISE_APPLICATION_ERROR(-20001, '������ 0~100�� ����...');
        END IF;
        
        IF pScore>=90 THEN vgrade := '��';
        ELSIF pScore>=80 THEN vgrade := '��';
        ELSIF pScore>=70 THEN vgrade := '��';
        ELSIF pScore>=60 THEN vgrade := '��';
        ELSE vgrade := '��';
        END IF;
        
        UPDATE test SET name = pName, score=pScore, grade=vgrade 
        WHERE num = pNum;
        COMMIT;
    END; 
    / 
    
    EXEC pUpdateTest(1, 'vvv', 99);    
    EXEC pUpdateTest(2, 'aaa', 90);  
    SELECT * FROM test;
    
    EXEC pUpdateTest(2, 'aaa', 999);   -- ���� �߻� 
    
    -- ���� ���ν��� : pDeleteTest 
       -- num �� �Ķ���ͷ� �Ѱ� �޾� ���� ���� ���ڵ� ����       
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
    
    -- �ϳ��� ���ڵ� ��� ���ν��� 
    CREATE OR REPLACE PROCEDURE pSelectListTest
    IS    
    BEGIN 
        FOR rec IN (SELECT num,name,score,grade FROM test)  LOOP
        DBMS_OUTPUT.PUT_LINE(rec.num||':'||rec.name||':'||rec.score||':'||rec.grade);
        END LOOP;         
    END;
    /
    
    EXEC pSelectListTest;
    
    -- ��� ���ڵ� ��� ���ν���
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
 - ���� 
   - 3���� ���̺� �ۼ� 
    - ���̺�� : ex1 
      num NUMBER �⺻Ű 
      name VARCHAR2(30) NOT NULL 
    - ���̺�� : ex2
      num NUMBER �⺻Ű, ex1 ���̺� num�� ����Ű 
      birth DATE NOT NULL
    - ���̺�� : ex3
      num NUMBER �⺻Ű, ex1 ���̺� num�� ����Ű
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
      
   - ������ �ۼ� : ex_seq 
    - �ʱ�:1, ����:1, ĳ�� X 
    CREATE SEQUENCE ex_seq START WITH 1 NOCACHE;
    
   - ex1, ex2, ex3 ���̺� �����͸� �߰��ϴ� ���ν��� : pInsertEx 
    - num�� ������ �̿� 
    - grade �� score >= 90 : 4.0, score >= 80 : 3.0, score >= 70 : 2.0, score >= 60 : 1.0 , ������ 0 
    - score�� 0~100 �ƴϰų� ������ ���̺� �� �ϳ��� ���̺� �����Ͱ� �߰� ���� ������ ��� ���̺� �����Ͱ� �߰����� �ʴ´�.
   
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
            RAISE_APPLICATION_ERROR(-20001, '������ 0~100�� ����...');
        END IF;
   
        IF pScore >= 90 THEN vgrade := '4.0';
        ELSIF pScore >= 80 THEN vgrade := '3.0';
        ELSIF pScore >= 70 THEN vgrade := '2.0';
        ELSIF pScore >= 60 THEN vgrade := '1.0';
        ELSE vgrade := '0';
        END IF;
        
        INSERT INTO ex1(num, name) VALUES (ex_seq.NEXTVAL, pName);
        INSERT INTO ex2(num, birth) VALUES (ex_seq.CURRVAL, pBirth);    -- ex1�� �ִ� ��ȣ�� ����ؾ� �ϹǷ� 
        INSERT INTO ex3(num, score, grade) VALUES (ex_seq.CURRVAL, pScore, vgrade);
        COMMIT;
   END;
   /  

   EXEC pInsertEx('������','2017-05-15',60);
   
    -- ���� ���ν���
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
               RAISE_APPLICATION_ERROR(-20001, '������ 0~100�� ����...');
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

         -- ���� ���ν���
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

      -- ��ȣ(num)�� �ش��ϴ� �ϳ��� ex1, ex2, ex3 ���̺� ���ڵ� ���
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
      
      
  2) OUT �Ķ���� 
   - ȣ���� ���ν����� ���� �Ѱ��ش�. 
   - ���� ���� 
   CREATE OR REPLACE PROCEDURE pSelectOutEx ( 
        pNum IN NUMBER 
        ,pName OUT VARCHAR2 
        ,pScore OUT NUMBER 
    )
    IS 
    BEGIN
        -- pNum := 1;  -- ����. IN �Ķ���ʹ� �б� ���� 
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
        -- �ٸ� ���ν��� ȣ��(���ν��� �ȿ����� EXEC ���� ����)
        pSelectOutEx(pNum, vname, vscore);  -- pname, pscore �ڸ����� �ݵ�� ������ �;� �� (��� �Ұ�) 
        DBMS_OUTPUT.PUT_LINE(vname || ':' || vscore);
    END; 
    / 
    
    SELECT * FROM ex1;
    
    EXEC pSelectEx(3);
      
      
[����� ���� �Լ�] 
- return �� ���� (����� ��ȯ)  <- ���ν������� ������ 
- �ý����� ���� �ϴ� �Լ��� �Ȱ��� ���� 
- ����� ���� �Լ� ���� 
   --------------------------------------------------------------------
    CREATE [OR REPLACE] FUNCTION �Լ��� 
    [(�μ� ������Ÿ��)] 
    RETURN ������Ÿ��
    IS ����
    BEGIN ����� 
    RETURN ��ȯ��;
    END; 
    /
   --------------------------------------------------------------------
    *���� 
     CREATE OR REPLACE FUNCTION fnGender 
     (
        rrn VARCHAR2     -- ũ�� ��� ����
     )  
     RETURN VARCHAR2     -- ũ�� ��� ���� 
     IS 
        s VARCHAR2(6) := '����';   -- �ʱⰪ
     BEGIN
        IF LENGTH(rrn) != 14 THEN 
            RAISE_APPLICATION_ERROR(-20001, '�ֹι�ȣ ����..');
        END IF;
        
        IF MOD(SUBSTR(rrn,8,1),2)=1 THEN 
            s := '����';
        END IF;
        
        RETURN s;
     END;
     /
 
    *����
     CREATE OR REPLACE FUNCTION fnBirth
     (
        rrn VARCHAR2     
     )  
     RETURN DATE  
     IS 
     BEGIN
        IF LENGTH(rrn) != 14 THEN 
            RAISE_APPLICATION_ERROR(-20001, '�ֹι�ȣ ����..');
        END IF;
        
        RETURN TO_DATE(SUBSTR(rrn,1,6),'RRMMDD');
     END;
     /
     
     *���� 
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
            RAISE_APPLICATION_ERROR(-20001, '�ֹι�ȣ ����..');
        END IF;
        
        b := TO_DATE(SUBSTR(rrn,1,6), 'RRMMDD');
        a := TRUNC(MONTHS_BETWEEN(SYSDATE,b)/12);
        
        RETURN a;
     END;
     /
    
     SELECT name, rrn, fnGender(rrn) ����, TO_CHAR(fnBirth(rrn),'YYYY-MM-DD') ����, fnAge(rrn) ���� FROM emp;
     

 
 - ���� 
    -- ���̺� �ۼ� 
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
        
     -- ����� ���� �Լ�   
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
    
    -- ���� ���ν���
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
                RAISE_APPLICATION_ERROR(-20001, '������ 0~100�� ����...');   
           END IF;
            
            INSERT INTO score1(hak, name, kor, eng, mat) VALUES (phak, pname, pkor, peng, pmat);
            INSERT INTO score2(hak, kor, eng, mat) VALUES (phak, fngrade(pkor), fngrade(peng), fngrade(pmat));   
            
            COMMIT;
       END;
       /   
       
       EXEC pScoreInsert('1111','������',23,73,58);
       EXEC pScoreInsert('2222','������',74,45,95);
       EXEC pScoreInsert('3333','�ٴٴ�',56,100,83);
       
       SELECT * FROM score1;
       SELECT * FROM score2;
       
     -- ���� ���ν��� 
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
                 RAISE_APPLICATION_ERROR(-20001, '������ 0~100���̸� �����մϴ�.');
            END IF;
      
            UPDATE score1 SET name=pname, kor=pkor, eng=peng, mat=pmat WHERE hak=phak;
            UPDATE score2 SET kor=fnGrade(pkor), eng=fnGrade(peng), mat=fnGrade(pmat) WHERE hak=phak;
            COMMIT;
      END;
      / 
     
     -- ���� ���ν���   
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