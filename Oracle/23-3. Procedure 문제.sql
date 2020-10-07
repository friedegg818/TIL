# - 문제 
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
      

-------------------------------------------------------------------------------------------------------------------

 
 - 문제2 
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
