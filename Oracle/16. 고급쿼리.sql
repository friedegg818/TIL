[고급 쿼리]

1) 계층형 쿼리  
-- 2차원 구조의 테이블로 저장된 데이터를 계층형 구조의 결과로 반환하는 쿼리 
   ---------------------------------------------------------------------
     SELECT num, subject, LEVEL, parent FROM soft
     START WITH num=1
     CONNECT BY PRIOR num = parent;                -- 상위에서 하위로 출력 
   --------------------------------------------------------------------- 
   - CONNECT BY PRIOR : 각 행이 어떻게 연결 될지를 오라클에게 알려주는 역할 
     - CONNECT BY : 계층적 질의에서만 사용
     - PRIOR : 이전 행과 다른 행을 연결하는 연산자, PRIOR 뒤에 오는 컬럼이 중요
   - LEVEL : 검색 된 결과에 대하여 계층별로 레벨 번호 출력  
     - 루트 1, 하위로 갈수록 1씩 증가 
     - CONNECT BY 에서만 사용 가능 
   - START WITH num = 1 : 출력 시작 위치(최상위 계층 행) 
   - PRIOR num = parent : 계층적 관계 지정 
     - 나(num)를 부모(parent)로 사용하는 행 (부하직원 검색) 
     - parent 컬럼 : 상위 정보를 가진 컬럼 
   ------------------------------------------------------------------------------- 
    - 조직도  
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=1
      CONNECT BY PRIOR num = parent;    
      
    - 최상위 하나만 출력 
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=1
      CONNECT BY PRIOR parent = num;
    
    - 하위에서 상위로 출력 (전체 X, 한 그룹만) 
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=15
      CONNECT BY PRIOR parent = num;    
      ( = CONNECT BY num = PRIOR parent;)     
    -------------------------------------------------------------------------------     
    - 정렬 
     - ORDER BY / GROUP BY : 잘못된 정렬 (계층 구조가 깨짐)
         SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
         START WITH num=1
         CONNECT BY PRIOR num = parent
         ORDER BY subject;
    
     - ORDER SIBLINGS BY : 같은 레벨에 한해 정렬 
         SELECT num, subject, LEVEL, parent FROM soft
         START WITH num=1
         CONNECT BY PRIOR num = parent
         ORDER SIBLINGS BY subject;
     ------------------------------------------------------------------------------- 
     - 상위에서 하위로 출력 (전체X, 한 그룹만)
       SELECT num, subject, LEVEL, parent FROM soft
       START WITH num=3
       CONNECT BY PRIOR num = parent;
     
     - WHERE 절은 마지막에 평가되며 num이 3인 것만 출력되지 않음 
       SELECT num, subject, LEVEL, parent FROM soft
       WHERE num != 3
       START WITH num=1
       CONNECT BY PRIOR num = parent;
     
     - DB와 DB 하위도 출력하지 않음 
       SELECT num, subject, LEVEL, parent FROM soft
       WHERE num != 3
       START WITH num=1
       CONNECT BY PRIOR num = parent AND num != 3;
     ------------------------------------------------------------------------------- 
     - LEVEL 응용 
         SELECT ROWNUM FROM dual WHERE ROWNUM <=20; -- 1번 출력
         SELECT LEVEL v FROM dual CONNECT BY LEVEL <= 20; -- 20번 출력     
         SELECT 1 FROM dual CONNECT BY LEVEL <=10; -- 10번 출력 
      
      ** 날짜에서 이용 
         SELECT TO_DATE('2020-03-19')+LEVEL-1 FROM dual CONNECT BY LEVEL <= 7;
     -------------------------------------------------------------------------------    
     - CONNECT_BY_ROOT : 최상위 행 출력   
        SELECT num, subject, LEVEL, parent, CONNECT_BY_ROOT subject
        FROM soft
        START WITH num=1
        CONNECT BY PRIOR num = parent;    
        
        SELECT num, subject, LEVEL, parent, CONNECT_BY_ROOT subject
        FROM soft
        START WITH num=3
        CONNECT BY PRIOR num = parent;  
     -------------------------------------------------------------------------------     
     - SYS_CONNECT_BY_PATH : 최상위 행(루트)에서 자신까지 연결  
        SELECT num, subject, LEVEL, parent, SYS_CONNECT_BY_PATH(subject,'>')
        FROM soft
        START WITH num=1
        CONNECT BY PRIOR num = parent;
     
     
     ** 서울 사람 연결    
         SELECT ROWNUM rnum, name FROM emp WHERE city = '서울';
         
         SELECT SYS_CONNECT_BY_PATH(name, ',') name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '서울'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;
        
         SELECT MAX(SYS_CONNECT_BY_PATH(name, ',')) name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '서울'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;  
          
         SELECT SUBSTR(MAX(SYS_CONNECT_BY_PATH(name, ',')),2) name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '서울'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;  


2) PIVOT
-- 열을 행으로 바꾸는 것 (ROW 형태의 데이터를 COLUMN 형태로)
 - 형식 
     SELECT * FROM ( 
        SELECT <select_list> FROM 테이블명 
    ) PIVOT ( 
        집계함수 FOR 컬럼명 IN (컬럼에 들어있는 요소 전부)
    );
  
 ** 예제 
 - 다음 쿼리를 행렬을 바꾸어 출력 
    ------------------------------------------------------ 
    WITH temp_table AS (
         SELECT 1 cnt, 1000 price FROM DUAL UNION ALL
         SELECT 2 cnt, 1050 price FROM DUAL UNION ALL
         SELECT 3 cnt, 2100 price FROM DUAL UNION ALL
         SELECT 1 cnt, 5500 price FROM DUAL UNION ALL
         SELECT 2 cnt, 7000 price FROM DUAL UNION ALL
         SELECT 3 cnt, 7000 price FROM DUAL
     )
     SELECT cnt, SUM(price) price
     FROM temp_table
     GROUP BY cnt;
   ------------------------------------------------------     
      WITH temp_table AS (
         SELECT 1 cnt, 1000 price FROM DUAL UNION ALL
         SELECT 2 cnt, 1050 price FROM DUAL UNION ALL
         SELECT 3 cnt, 2100 price FROM DUAL UNION ALL
         SELECT 1 cnt, 5500 price FROM DUAL UNION ALL
         SELECT 2 cnt, 7000 price FROM DUAL UNION ALL
         SELECT 3 cnt, 7000 price FROM DUAL
     )
    SELECT * FROM ( 
        SELECT cnt, price FROM temp_table
    ) PIVOT ( 
        SUM(price) FOR cnt IN (1,2,3)
    );
      
 - 부서를 컬럼으로 보내기 
   ----------------------------------
    SELECT dept, city, COUNT(*)
    FROM emp
    GROUP BY dept, city
    ORDER BY dept;
   ----------------------------------
     SELECT * FROM ( 
       SELECT city, dept 
       FROM emp ORDER BY dept
    ) PIVOT (
      COUNT(dept) FOR dept IN (
        '개발부' AS "개발부" , '기획부' AS "기획부"
       ,'영업부' AS "영업부" , '인사부' AS "인사부"
       ,'자재부' AS "자재부" , '총무부' AS "총무부"
       ,'홍보부' AS "홍보부"
      )
   );

 - 월별 입사 인원 수 
       SELECT * FROM (
         SELECT TO_CHAR(hireDate,'MM') 월별    
         FROM emp   
      ) PIVOT (
         COUNT(월별) FOR 월별 IN (
         '01','02','03','04','05','06','07','08','09','10','11','12')
      );
  
 - 부서별 직위급여합 
   pos 개발부 ... 홍보부 
   직원 x x xx ..  
      SELECT * FROM (
        SELECT dept, pos, sal FROM emp
        GROUP BY dept, pos, sal
      ) PIVOT (
         SUM(sal) FOR dept IN (
            '개발부' AS 개발부 , '기획부' AS 기획부
           ,'영업부' AS 영업부 , '인사부' AS 인사부
           ,'자재부' AS 자재부 , '총무부' AS 총무부
           ,'홍보부' AS 홍보부
         )
       ) ORDER BY pos;
  
 - 년도 월별 판매현황(bPrice*qty 합)
    년도 1월 ... 12월 
      SELECT 년도, NVL("1월",0) "1월", NVL("2월",0) "2월", NVL("3월",0) "3월", NVL("4월",0) "4월",
                   NVL("5월",0) "5월", NVL("6월",0) "6월", NVL("7월",0) "7월", NVL("8월",0) "8월",
                   NVL("9월",0) "9월", NVL("10월",0) "10월", NVL("11월",0) "11월", NVL("12월",0) "12월"
     FROM ( 
        SELECT TO_CHAR(sDate,'YYYY') 년도, TO_CHAR(sDate,'MM') 월별, bPrice*qty 합
        FROM book b 
        JOIN dsale d ON b.bCode = d.bCode 
        JOIN sale s ON d.sNum = s.sNum    
      ) PIVOT ( 
         SUM(합) FOR 월별 IN ( 
            '01' AS "1월", '02' AS "2월", '03' AS "3월", '04' AS "4월", '05' AS "5월", '06' AS "6월",
            '07' AS "7월", '08' AS "8월", '09' AS "9월", '10' AS "10월", '11' AS "11월", '12' AS "12월"
          )
        ) ORDER BY 년도;
  
  - 요일별 입사인원   
      SELECT * FROM (
        SELECT TO_CHAR(hiredate,'DAY') 요일
        FROM emp 
      ) PIVOT (
         COUNT(요일) FOR 요일 IN (
            '월요일' 월, '화요일' 화, '수요일' 수, '목요일' 목, '금요일' 금, '토요일' 토, '일요일' 일
            )
         );
  
  
3) UNPIVOT
-- 행을 열로 바꾸는 것 (COLUMN 형태의 데이터를 ROW 형태로)
-- 기능적으로 PIVOT과 반대되는 개념이지만, PIVOT의 결과를 되돌리는 기능은 아니다. 

     SELECT * FROM t_city
     UNPIVOT
     (
        인원수 
        FOR buseo IN(개발부, 기획부, 영업부, 인사부, 자재부, 총무부, 홍보부)
     );
     
     
4) 정규식 (Regular Expression) 
-- 문자열 데이터의 간단한 패턴 및 복잡한 패턴을 검색 할 수 있는 도구
 - 정규식 패턴 
         . | NULL 을 제외한 임의의 문자와 일치     
         + | 한 번 이상 일치    
         ? | 0 or 1번 일치    
         * | 0번 이상 일치 
       {m} | m번 일치     
     {m,n} | 최소 m번, 최대 n번 일치 
     [...] | 괄호 안 문자와 일치 
         ^ | 문자열 시작 부분과 일치 ([ ] 안에 있으면 NOT 의 의미)
         $ | 문자열 끝 부분과 일치
        \d | 숫자  
 [:class:] | 괄호 안 문자 클래스의 요소와 일치 
            [:alpha:] | 알파벳 문자 
            [:digit:] | 숫자 
            [:lower:] | 소문자 
            [:upper:] | 대문자 
            [:alnum:] | 알파벳 + 숫자 
            [:space:] | 공백 
            [:punct:] | 특수 문자 
            [:cntrl:] | 컨트롤 문자
            [:print:] | 출력 가능한 문자 
        
 - REGEXP_LIKE : 패턴이 포함된 문자열 반환 (LIKE와 유사) 
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[한백]');       -- ^ : 뒤의 문자로 시작
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '강산$');         -- $ : 앞의 문자로 끝
   
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'com$','i');    -- i : 대소문자 구분 안 함 
    
    -- kim을 포함하는 레코드
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim*');        
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim');
    
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim3?3'); 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[0-3]{2}');  -- 0~3 사이의 문자가 2번이상 반복되는 레코드 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[2-3]{3,4}'); -- 2~3 사이의 문자가 최소 3번, 최대 4번 반복되는 레코드
    
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[^1]');      -- kim 다음에 1로 시작하지 않는 레코드 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[^1]$');        -- 1로 끝나지 않는 레코드
    
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[가-R]{1,10}$');   -- 이름이 1~10자 사이이고 한글인 레코드
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[가-R]{2,}$');     
    
    -- 이메일에 숫자가 포함된 레코드 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[0-9]');   
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[[:digit:]]');
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '.*[[:digit:]].*');
    
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '[[:lower:]]');  -- 이름에 소문자만 있는 레코드 
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '[a-z|A-Z]');    -- 소문자 or 대문자 있는 레코드

 - REGEXP_REPLACE : 대체 문자열로 변경
    SELECT REGEXP_REPLACE('kim gil dong','(.*) (.*) (.*)','\3 \2 \1') FROM dual;
    
    SELECT email FROM reg;
    SELECT email, REGEXP_REPLACE(email, '(.*)@(.*)', '\1'),            -- @ 앞부분만 출력
                  REGEXP_REPLACE(email, '(.*)@(.*)', '\2') FROM reg;   -- @ 뒷부분만 출력 
    
    SELECT email, REGEXP_REPLACE(email,'arirang','아리랑') FROM reg;              
 
    SELECT REGEXP_REPLACE('24jj$%^*^$$#@@$24', '[[:digit:]|[:punct:]]', '') FROM dual;  -- 숫자, 특수문자 없앰 
    
    SELECT name, rrn, REGEXP_REPLACE(rrn,'[0-9|\-]', '*', 9) FROM emp;   -- 9번째부터 *로 변경
    
 - REGEXP_INSTR : 패턴 비교를 통해 위치 값을 확인
    SELECT email, REGEXP_INSTR(email, '[0-9]') FROM reg;  -- 숫자가 있는 곳의 위치 
 
 - REGEXP_SUBSTR : 패턴을 검색하여 부분 문자열 추출 
 
 - REGEXP_COUNT : 패턴을 검색하여 발견 된 횟수 계산
    SELECT email, REGEXP_COUNT(email, 'a') FROM reg;
     
        
        
        
*********************************** 문제 

SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation
ORDER BY checkIn ASC;

-- 20200724 ~ 20200729 예약 된 룸. 0729에 checkOut 되면 0729에 checkIn 가능

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200724) AND TO_DATE(checkin) <= TO_DATE(20200729) OR 
       TO_DATE(checkout) > TO_DATE(20200724) AND TO_DATE(checkout) < TO_DATE(20200729); 
 
-- 20200727 ~ 20200728 예약 된 룸.

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200727) AND TO_DATE(checkin) <= TO_DATE(20200728) OR 
       TO_DATE(checkout) > TO_DATE(20200727) AND TO_DATE(checkout) < TO_DATE(20200728); 


-- 20200730 ~ 20200801 예약 된 룸.

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200730) AND TO_DATE(checkin) <= TO_DATE(20200801) OR 
       TO_DATE(checkout) > TO_DATE(20200730) AND TO_DATE(checkout) < TO_DATE(20200801); 
   
