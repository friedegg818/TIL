[JOIN]
 - 둘 이상의 테이블, 뷰의 행을 결합하는 쿼리 
 - query 의 FROM 절에 여러 테이블이 나타날 때마다 수행 
 - 공통된 컬럼의 이름이 존재하는 경우, 모호성을 피하기 위해 테이블 이름으로 규성 
 
------- INNER JOIN 
[EQUI JOIN] 
-- 여러 테이블의 교집합에 해당되는 정보만 가져옴
    1)
    SELECT empNo, name, com, excel, word 
    FROM emp, emp_score 
    WHERE emp.empNO = emp_score.empNo;  -- 에러 : 동일한 컬럼명이 두 테이블에 존재하며, 모호성이 발생 (ORA-00918
    
    SELECT e.empNo, name, com, excel, word 
    FROM emp e, emp_score s     -- 테이블명에 별명 부여하여 간단하게 작성하기 
    WHERE e.empNO = s.empNo; 
    
    2)
    SELECT e.empNo, name, com, excel, word 
    FROM emp e 
    JOIN emp_score s ON e.empNo = s.empNo;

**실습 - 판매현황 테이블 작성
- 각각의 컬럼이 어느 테이블에 있는지 확인 
book : bCode, bName, bPRICE, pNum
pub : pNum, pName
sale : sNum, sDate, cNum
dsale : sNum, bCode, qty     *sale-dsale 결합을 위해 sNum이 필요 
cus : cNum, cName 

    1) SELECT <select_list> FROM 테이블1, 테이블2 WHERE 테이블1.컬럼 = 테이블2.컬럼; 
    -- 테이블에 별명을 부여하여 간단히 작성 
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b, pub p, sale s, dsale d, cus c 
    WHERE b.pNum = p.pNum AND b.bCode = d.bCode AND d.sNum = s.sNum AND s.cNum = c.cNum;
    
    2) SELECT <select_list> FROM 테이블1 [INNER] JOIN 테이블2 ON 테이블1.컬럼 = 테이블2.컬럼
     -- 추가적인 조건을 입력하기에 더 용이함
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum;
    
    -- 올해 판매 현황 
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum
    WHERE TO_CHAR(SYSDATE,'YYYY') = TO_CHAR(sDate, 'YYYY');
    
    -- 작년 판매 현황
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum
    WHERE TO_CHAR(SYSDATE,'YYYY')-1 = TO_CHAR(sDate, 'YYYY');
    -- WHERE TO_CHAR(SYSDATE - (INTERVAL '1' YEAR),'YYYY') = TO_CHAR(sDate, 'YYYY');
    
    3) SELECT <select_list> FROM 테이블1 [INNER] JOIN 테이블2 USING (컬럼) 
    -- 컬럼명이 같은 경우에만 사용 가능 
    -- 별명을 사용하지 않음 
    SELECT bCode, bName, bPrice, pNum, pName, sDate, cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub USING (pNum)
    JOIN dsale USING (bCode)
    JOIN sale USING (sNum)
    JOIN cus USING (cNum);

**문제 1
- 판매된 책코드(bCode), 책이름(bName), 판매권수의합(qty 합) / 책코드 오름차순 
book : bCode, bName
dsale : qty , bCode 

    SELECT b.bCode, bName, SUM(qty) 총판매권수 
    FROM book b 
    JOIN dSale d ON b.bCode = d.bCode
    GROUP BY b.bCode, bName
    ORDER BY bCode;

- 판매된 책코드(bCode), 책이름(bName), 판매권수의합(qty 합), 판매금액합(qty*bPrice 합) / 책코드 오름차순
book : bCode, bName, bPrice 
dsale : qty , bCode 

    SELECT DISTINCT b.bCode, bName, SUM(qty) 총판매권수, SUM(qty*bPrice) 총판매금액
    FROM book b 
    JOIN dSale d ON b.bCODE = d.bCode
    GROUP BY b.bCode, bName
    ORDER BY bCode;

        --**SUM()OVER()써서 해본것**
        SELECT DISTINCT b.bCode, bName, SUM(qty)OVER(PARTITION BY b.bCode) 총판매권수 
        FROM book b 
        JOIN dSale d ON b.bCode = d.bCode
        ORDER BY bCode;
        
        SELECT DISTINCT b.bCode, bName, SUM(qty)OVER(PARTITION BY b.bCode) 총판매권수 
                                      , SUM(qty*bPrice)OVER(PARTITION BY b.bCode) 총판매금액
        FROM book b 
        JOIN dSale d ON b.bCode = d.bCode
        ORDER BY bCode;

- 판매된 책코드(bCode), 책이름(bName) : 중복 배제 
book : bCode, bName
dsale : bCode 

    SELECT DISTINCT b.bCode, bName
    FROM book b 
    JOIN dSale d ON b.bCode = d.bCode;

- 판매된 책 중 판매권수합이 가장 큰 책코드(bCode), 책이름(bName)
book : bCode, bName
dsale : bCode , qty 

    -- 1. 순위를 이용하여 구하기 
    SELECT bCode, bName FROM ( 
        SELECT b.bCode, bName, SUM(qty), RANK() OVER(ORDER BY SUM(qty) DESC) 순위
        FROM book b 
        JOIN dSale d ON b.bCode = d.bCode
        GROUP BY b.bCode, bName
    ) WHERE 순위 = 1;
    
    -- 2. HAVING절을 이용하여 구하기 
    SELECT b.bCode, bName 
    FROM book b 
    JOIN dsale d ON b.bCode = d.bCode
    GROUP BY b.bCode, bName
    HAVING SUM(qty) = ( 
        SELECT MAX(SUM(qty)) 
        FROM book b1
        JOIN dsale d1 ON b1.bCode = d1.bCode   -- 이미 위에서 별명으로 b,c를 사용했으므로 
        GROUP BY b1.bCode, bName
        );

**문제 2 
- 년도별 판매금액의 합 : 년도, 판매합(년도별 판매합) / 년도 오름차순 
sale : sDate   sNum 
dsale : qty    bCode  sNum
book : bPrice  bCode

    SELECT TO_CHAR(sDate, 'YYYY') 년도 , SUM(qty*bPrice) 판매합
    FROM dsale d
    JOIN book b ON d.bCode = b.bCode 
    JOIN sale s ON d.sNum = s.sNum 
    GROUP BY TO_CHAR(sDate, 'YYYY')
    ORDER BY 년도;

- 고객번호(cNum), 고객명(cName), 년도, 판매금액합 / 고객번호 오름차순, 년도 오름차순 
cus : cNum, cName   cNum
sale : sDate    sNum   cNum
dsale : qty     bCode  sNum
book : bPrice   bCode

    SELECT c.cNum 고객번호, cName 고객명, TO_CHAR(sDate,'YYYY') 년도, SUM(qty*bPrice) 판매금액합 
    FROM cus c
    JOIN sale s ON c.cNum = s.cNum
    JOIN dsale d ON s.sNum = d.sNum
    JOIN book b ON d.bCode = b.bCode
    GROUP BY c.cNum, cName, TO_CHAR(sDate,'YYYY')
    ORDER BY 고객번호, 년도;

- 고객번호(cNum), 고객명(cName) / 작년 누적 판매금액이 가장 많은 고객 출력
cus : cNum, cName cNum
sale : sDate    sNum cNum
dsale : qty     bCode sNum
book : bPrice   bCode

    SELECT 고객번호, 고객명 FROM (
        SELECT c.cNum 고객번호, cName 고객명, SUM(qty*bPrice) 작년금액, RANK() OVER(ORDER BY SUM(qty*bPrice) DESC) 순위
        FROM cus c 
        JOIN sale s ON c.cNum = s.cNum
        JOIN dsale d ON s.sNum = d.sNum 
        JOIN book b ON d.bCode = b.bCode
        WHERE TO_CHAR(sDate,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-1
        GROUP BY c.cNum, cName
     ) WHERE 순위 = 1;            
 

- 고객번호(cNum), 고객명(cName), 회원아이디(userID) / 회원 중 올해 누적 판매금액이 가장 많은 고객 출력
cus : cNum, cName 
member : userId  cNum 
sale : sDate  sNum cNum
dsale : qty   sNum bCode
book : bPrice  bCode

    SELECT 고객번호, 고객명, 회원아이디 FROM (
        SELECT c.cNum 고객번호, cName 고객명, userId 회원아이디, SUM(qty*bPrice), RANK() OVER(ORDER BY SUM(qty*bPrice) DESC) 순위
        FROM cus c 
        JOIN member m ON c.cNum = m.cNum
        JOIN sale s ON c.cNum = s.cNum
        JOIN dsale d ON s.sNum = d.sNum
        JOIN book b ON d.bCode = b.bCode 
        WHERE TO_CHAR(sDATE,'YYYY') = TO_CHAR(SYSDATE,'YYYY')
        GROUP BY c.cNum, cName, userId
    ) WHERE 순위 = 1; 

- 책코드(bCode), 책이름(bName), 판매권수합 / 판매권수 합이 80권 이상인 책만 출력 
book : bCode, bName 
dsale : qty , bCode 
 
    SELECT b.bCode 책코드, bName 책이름, SUM(qty) 판매권수
    FROM book b
    JOIN dsale d ON b.bCode = d.bCode
    GROUP BY b.bCode, bName 
    HAVING SUM(qty) >= 80;
    
---------------------------------------------------------------------------------------
[NATURAL JOIN]
-- 별칭 사용 불가, 컬럼 이름이 다르면 사용 불가, 속도가 매우 떨어짐 

 SELECT 컬럼명, 컬럼명 ... FROM 테이블1 NATURAL JOIN 테이블2 

     SELECT bCode, bName, bPrice, pNum, pName, sDate, cNum, cName, qty, bPrice*qty amt 
     FROM book b
     NATURAL JOIN pub
     NATURAL JOIN dsale
     NATURAL JOIN sale
     NATURAL JOIN cus;
 
[CROSS JOIN]
-- 테이블간의 카디션 곱 반환. 학술적 용도  

    SELECT p.pNum, pName, bCode, bName 
    FROM pub p 
    CROSS JOIN book b;

[SELF JOIN]
-- 자기가 자기 자신을 JOIN
-- 대분류/중분류/..

    SELECT b1.bcCode, b1.bcSubject, b1.pcCode, 
           b2.bcCode, b2.bcSubject, b2.pcCode
    FROM bclass b1
    JOIN bclass b2 ON b1.bcCode = b2.pcCode;       -- pcCode > null이면 최상위 그룹 
    
[NON-EQUI JOIN] 
-- JOIN시 '=' 이외의 연산자 사용   

SELECT a1.bCode, a1.aName, a2.aName 
FROM author a1
JOIN author a2 ON a1.bCode = a2.bCode
ORDER BY a1.bCode;
    
    -- 저자가 2명 이상인 것만 출력 
    SELECT a1.bCode, a1.aName, a2.aName 
    FROM author a1
    JOIN author a2 ON a1.bCode = a2.bCode AND a1.aName > a2.aName  
    ORDER BY a1.bCode;
    
    -- 저자가 2명 이상인 책코드와 책이름 출력
    SELECT bCode, bName 
    FROM book
    WHERE bCode IN (    
      SELECT a1.bCode
      FROM author a1
      JOIN author a2 ON a1.bCode = a2.bCode AND a1.aName > a2.aName    
    );
    
 - EQUI JOIN    
   SELECT s.sNum, bCode, cNum, sDate, qty
   FROM sale s
   JOIN dsale d ON s.sNum = d.sNum;

 - NON-EQUI JOIN
   SELECT s.sNum, bCode, cNum, sDate, qty
   FROM sale s
   JOIN dsale d ON s.sNum > 10;    

----------------------------------------------------------------------------------------
----------- OUTER JOIN 
[LEFT OUTER JOIN]
-- 좌변의 테이블의 결과를 모두 가져오고 우변은 조건을 만족하는 데이터만 가져온다.

book : bCode, bName / dsale : bCode, sNum, qty 
-- EQUI JOIN 
    SELECT b.bCode, bName, sNum, qty 
    FROM book b, dsale d 
    WHERE b.bCode = d.bCode;

-- LEFT OUTER JOIN
    1) 묵시적
    SELECT b.bCode, bName, sNum, qty 
    FROM book b, dsale d 
    WHERE b.bCode = d.bCode(+);  -- 판매되지 않은 책도 출력 
    
    2) 명시적 
    SELECT b.bCode, bName, sNum, qty 
    FROM book b
    LEFT OUTER JOIN dsale d ON b.bCode = d.bCode;


**문제 
- bCode, bName, sNum, sDate, qty 출력 (단, bCode와 bName은 한권도 판매가 되지 않은 책도 출력) 

    SELECT b.bCode, bName, d.sNum, sDate, qty 
    FROM book b 
    LEFT OUTER JOIN dsale d ON b.bCode = d.bCode
    LEFT OUTER JOIN sale s ON d.sNum = s.sNum;

- 판매 된 / 판매 안 된 책코드, 책이름만 출력     
 
     1) IN 사용 
     SELECT b.bCode, bName
     FROM book b 
     WHERE bCode IN (SELECT DISTINCT bCode FROM dSale);
     
     2) JOIN 사용 
     SELECT b.bCode, bName
     FROM book b 
     LEFT OUTER JOIN dSale d ON b.bCode = d.bCode
     WHERE d.bCode IS NOT NULL;                     -- 판매 된 리스트 
     
     SELECT b.bCode, bName
     FROM book b 
     LEFT OUTER JOIN dSale d ON b.bCode = d.bCode
     WHERE d.bCode IS NOT NULL;                     -- 판매 되지 않은 리스트
     
- 올 해 판매된 책코드, 책이름    

    SELECT bCode, bName
	FROM book
	WHERE bCode IN (
       SELECT DISTINCT bCode
	   FROM dsale d
	   JOIN sale s ON d.sNum = s.sNum AND TO_CHAR(sDate, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
		);

[RIGHT OUTER JOIN] 
-- 우변의 테이블의 결과를 모두 가져오고 좌변은 조건을 만족하는 데이터만 가져온다.
book : bCode, bName / dsale : bCode, sNum, qty 
-- EQUI JOIN 
    SELECT b.bCode, bName, sNum, qty 
    FROM book b, dsale d 
    WHERE b.bCode = d.bCode;

-- RIGHT OUTER JOIN
    1) 묵시적
    SELECT b.bCode, bName, sNum, qty 
    FROM dsale d, book b 
    WHERE d.bCode(+) = b.bCode;  -- 판매되지 않은 책도 출력 
    
    2) 명시적 
    SELECT b.bCode, bName, sNum, qty 
    FROM dsale d 
    RIGHT OUTER JOIN book b ON d.bCode = b.bCode;

[FULL OUTER JOIN] 
-- 좌변과 우변의 결과를 모두 가져온다. (합집합) 

    SELECT sNum, sDate, s.cNum, m.cNum, userId 
    FROM sale s
    LEFT OUTER JOIN member m ON s.cNum = m.cNum;
    
    SELECT sNum, sDate, s.cNum, m.cNum, userId 
    FROM sale s
    RIGHT OUTER JOIN member m ON s.cNum = m.cNum;
    
    SELECT sNum, sDate, s.cNum, m.cNum, userId 
    FROM sale s
    FULL OUTER JOIN member m ON s.cNum = m.cNum;
    
    --- 
    
    SELECT sNum, sDate, s.cNum, m.cNum, cName, userId 
    FROM sale s  -- sDate, sNum
    FULL OUTER JOIN member m ON s.cNum = m.cNum   -- userId, cNum     // sDate sNum + cNum userId 
    FULL OUTER JOIN cus c ON c.cNum = s.cNum; -- cNum, cName    // sDate sNum cNum userId + cNum cName (cName null 출력) 
    
    SELECT sNum, sDate, s.cNum, m.cNum, cName, userId
	FROM cus c    -- cNum, cName 
	FULL OUTER JOIN member m ON c.cNum = m.cNum -- userId, cNum  // cNum cName + userId cNum 
	FULL OUTER JOIN sale s ON c.cNum = s.cNum; -- sDate, sNum   // cNum cName userId cNum  + sDate sNum 


**문제 
- 비회원 판매 현황 : cNum, cName, bCode, bName, sDate, bPrice, qty 
cus (cNum, cName) 
member (cNum) 
book (bCode, bName, bPrice) 
dsale (qty, sNum, bCode) 
sale (sDate, sNum) 

    SELECT c.cNum, cName, b.bCode, bName, sDate, bPrice, qty 
    FROM cus c
    LEFT OUTER JOIN member m ON c.cNum = m.cNum 
    JOIN sale s ON c.cNum = s.cNum
    JOIN dsale d ON s.sNum = d.sNum
    JOIN book b ON d.bCode = b.bCode
    WHERE userId IS NULL
    ORDER BY cNum;     
    
    ------ RIGHT 로 해보기 *** 못한것 
      SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty
      FROM  book b
      JOIN  dsale d  ON  b.bCode = d.bCode
      JOIN  sale s   ON  d.sNum = s.sNum
      JOIN  member m  ON  m.cNum = s.cNum
      RIGHT OUTER JOIN cus c ON  c.cNum = m.cNum
      WHERE userId IS NULL
      ORDER BY cNum;

- 고객별 누적 판매 금액 : cNum, cName, bPrice*qty 합 (단, 고객중 책을 한권도 구매하지 않은 고객도 출력) 
cus(cNum, cName) 
sale(cNum, sNum)
dsale(qty, bCode, sNum) 
book(bPrice, bCode)

    SELECT c.cNum, cName, NVL(SUM(bPrice*qty),0) 합 
    FROM cus c
    LEFT OUTER JOIN sale s ON c.cNum = s.cNum
    LEFT OUTER JOIN dsale d ON s.sNum = d.sNum
    LEFT OUTER JOIN book b ON d.bCode = b.bCode
    GROUP BY c.cNum, cName
    ORDER BY c.cNum, cName;

- 고객별 누적 판매 금액 및 비율 : cNum, cName, bPrice*qty 합, 전체 판매 금액에 대한 비율
cus(cNum, cName) 
sale(cNum, sNum)
dsale(qty, bCode, sNum) 
book(bPrice, bCode)

    SELECT DISTINCT c.cNum, cName, 
                    SUM(bPrice*qty) OVER(PARTITION BY c.cNum, cName) 합, 
                    ROUND((SUM(bPrice*qty) OVER(PARTITION BY c.cNum, cName) / SUM(bPrice*qty) OVER())*100,1) || '%' 비율
                    --ROUND(RATIO_TO_REPORT(SUM(bPrice*qty)) OVER() * 100, 1) 
    FROM cus c
    JOIN sale s ON c.cNum = s.cNum
    JOIN dsale d ON s.sNum = d.sNum
    JOIN book b ON d.bCode = b.bCode
    ORDER BY c.cNum;

- 년도별 고객 누적 판매금액이 가장 많은 데이터 : 판매년도, cNum, cName, bPrice*qty 합 / 년도별 오름차순 
cus(cNum, cName) 
sale(sDate, cNum, sNum)
dsale(qty, bCode, sNum) 
book(bPrice, bCode)

    SELECT 판매년도, cNum, cName, 합 FROM ( 
        SELECT TO_CHAR(sDate,'YYYY') 판매년도, c.cNum, cName, SUM(bPrice*qty) 합, 
               RANK() OVER(PARTITION BY TO_CHAR(sDate,'YYYY') ORDER BY SUM(bPrice*qty)) 순위
        FROM cus c 
        JOIN sale s ON c.cNum = s.cNum
        JOIN dsale d ON s.sNum = d.sNum
        JOIN book b ON d.bCode = b.bCode 
        GROUP BY TO_CHAR(sDate,'YYYY'), c.cNum, cName  
    ) WHERE 순위 = 1;

**문제 
- 년도의 월별 서적의 판매 수량의 합 구하기 / 년도 오름차순, 책코드 오름차순 
  년도 책코드 책이름  1월 2월 3월 ... 12월 
  
  book (bCode, bName) 
  sale (sDate, sNum) 
  dsale (qty, bCode, sNum) 
  
             SELECT TO_CHAR(sDate,'YYYY') 년도, b.bCode 책코드, bName 책이름, 
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),1,qty)),0) "1월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),2,qty,0)),0) "2월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),3,qty,0)),0) "3월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),4,qty,0)),0) "4월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),5,qty,0)),0) "5월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),6,qty,0)),0) "6월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),7,qty,0)),0) "7월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),8,qty,0)),0) "8월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),9,qty,0)),0) "9월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),10,qty,0)),0) "10월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),11,qty,0)),0) "11월",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),12,qty,0)),0) "12월"                            
                 FROM book b
                 JOIN dsale d ON b.bCode = d.bCode 
                 JOIN sale s ON d.snum = s.snum            
                 GROUP BY TO_CHAR(sDate,'YYYY'),b.bCode, bName
                 ORDER BY TO_CHAR(sDate,'YYYY');
 
** PDF 문제 

CREATE TABLE injeok ( 
    hakbeon VARCHAR2(15) 
    , name VARCHAR2(20) NOT NULL
    , birth DATE NOT NULL
    , tel VARCHAR2(20)
    , email VARCHAR2(50)
    , created DATE DEFAULT SYSDATE
    , CONSTRAINT hak_P PRIMARY KEY(hakbeon)
    , CONSTRAINT hak_NN CHECK (hakbeon IS NOT NULL)
    );
    
CREATE TABLE score (
    hak NUMBER(1) NOT NULL
    , ban NUMBER(2) NOT NULL
    , gubun NUMBER(1) NOT NULL
    , hakbeon VARCHAR2(15) NOT NULL
    , com NUMBER(3) NOT NULL
    , excel NUMBER(3) NOT NULL
    , word NUMBER(3) NOT NULL
    , created DATE NOT NULL
    , CONSTRAINT score_P PRIMARY KEY (hak, ban, gubun, hakbeon)
    );
    
    ALTER TABLE score ADD CONSTRAINT gubun_LM CHECK (gubun IN (1,2,3,4));
    ALTER TABLE score ADD CONSTRAINT hak_FK FOREIGN KEY(hakbeon) REFERENCES injeok (hakbeon);
  
1)   
SELECT hak, ban, 
       DECODE(gubun,1,'1학기중간',2,'1학기기말',3,'2학기중간','2학기기말') 구분,
       name, com, excel, word,
       com+excel+word tot, ROUND((com+excel+word)/3,1) ave,
       RANK() OVER(PARTITION BY gubun,HAK,BAN ORDER BY ROUND((com+excel+word)/3,1) DESC) 학급석차,
       RANK() OVER(PARTITION BY gubun,HAK ORDER BY ROUND((com+excel+word)/3,1) DESC) 학년석차
FROM score s
JOIN injeok i ON s.hakbeon = i.hakbeon
ORDER BY gubun, hak, ban;


2) 
SELECT hak, ban, 
       DECODE(gubun,1,'1학기중간',2,'1학기기말',3,'2학기중간','2학기기말') 구분,
       name, com+excel+word tot, ROUND((com+excel+word)/3,1) ave,
       CASE 
        WHEN com >= 40 AND excel >=40 AND word >=40 AND ROUND((com+excel+word)/3,1)>=60 THEN '합격' 
        WHEN ROUND((com+excel+word)/3,1) < 60 THEN '불합격'
        ELSE '과락'
       END 판정 
FROM score s
JOIN injeok i ON s.hakbeon = i.hakbeon;
   
          
