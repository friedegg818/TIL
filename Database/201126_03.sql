[PL/SQL]
- SQLP에 절차적인 언어의 기능을 추가하여 확장 한 것 (ex.IF-THEN, WHILE 루프)
- 블록 위주의 언어 
  - 기본 단위 : 블록, 프로시저, 함수 
  - 위의 단위들은 다수의 서브블록들을 포함 할 수 있음 
  
- 장점 
  - SQL로는 얻을 수 없는 PL/SQL의 절차적 프로그래밍 기능 
  - 모듈화된 프로그램 개발
  - 커서와 예외 사항 처리 
  - 코드의 재사용성을 높임 
  - 네트워크 통신량을 줄임으로써 성능 향상 (여러 SQL문을 하나의 블록으로 묶어서, 한 번의 호출로 블록 전체를 서버로 보내므로) 

- 기본 구조 
    -- 선언절 : 변수와 객체들을 선언
       [DECLARE 
          <상수> 
          <변수>
          <커서>
          <사용자 정의 예외사항>] 
 
    -- 실행절 : 변수를 처리(필수) 
    -- 실행절의 SQL문에는 데이터 정의어(CREATE,ALTER,DROP)와 데이터 제어어(GRANT, REVOKE) 등 사용 불가 
         BEGIN 
           <SQL문 or PL/SQL문>
    -- 예외 사항 처리절 : 실행 중 발생한 예외나 에러 처리 
            [ <EXCEPTION>
                <예외 사항 처리>] 
         END;
         
- 제어 구조 유형 
  - 조건문 예시 
     if <조건> then <PL/SQL문> else <PL/SQL문> end if;
    
  - for 반복문 예시 
     for <인덱스 변수> in <범위> loop <PL/SQL문> end loop; 
    
  - while 반복문 예시 
     while <조건> loop 
       <PL/SQL문>
     end loop; 
     
- PL/SQL문의 질의 결과로 다수의 행이 반환 될 경우, 결과 중 첫번째 행만 전달한다. 

- 커서(Cursor)
  - 질의가 다수의 행들을 결과로 반환 할 때 선언하여 질의의 결과의 각 행을 처리하고 현재 어떤 행을 처리하고 있는지 유지 하는 것 
  - 질의의 결과로 반환되는 행(활성 집합)내의 한 행을 가리키는 포인터 
  
- 커서 사용 단계
  1. 블록의 선언절에서 커서 선언 
     CURSOR 커서_이름 IS SELECT문;

  2. 커서 사용 전, 실행전에서 커서 열기 
     OPEN 커서_이름; 
 
  3. FETCH문을 사용하여 활성 집합에 있는 행을 하나씩 차례대로 검색 
     FETCH 커서_이름 INTO 변수_리스트; 

  4. 커서를 닫기 
     CLOSE 커서_이름;
     
- 예시
  -- 3번 부서의 사원들의 평균 급여가 2800000원 이상이면 3번 부서에 속한 사원들의 이름과 직책과 급여를 검색하고, 
  -- 그렇지 않으면 "3번 부서의 평균 급여가 2800000 미만입니다." 라는 메세지를 인쇄 하는 코드
  
  -- PL/SQL은 기본적으로 결과물을 보여주지 않기 때문에, 결과를 보고 싶을 경우 SERVEROUTPUT을 ON으로 설정 
  set serveroutput on;  
  
  DECLARE 
    avg_salary NUMBER;
    l_empname VARCHAR2(10);
    l_title VARCHAR2(10);
    l_salary NUMBER;
    
    -- 커서를 이용하여 employee 정보 가져오기 
    CURSOR get_employee_rec IS 
    SELECT empname, title, salary 
    FROM employee 
    WHERE dno = 3;
    
  BEGIN
    SELECT AVG(salary)
    INTO avg_salary
    FROM employee
    WHERE dno = 3;
    
    IF avg_salary >= 2800000 THEN 
       FOR emp_rec IN get_employee_rec 
       
       LOOP
         l_empname := emp_rec.empname;
         l_title   := emp_rec.title;
         l_salary  := emp_rec.salary;
       END LOOP;
       
     ELSE 
       dbms_output.put_line('3번 부서의 평균 급여가 2800000 미만입니다.');
     END IF;
  END;
  /
  