
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
         
