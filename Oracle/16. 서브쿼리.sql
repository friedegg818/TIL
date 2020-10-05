
[SUBQUERY]
- WHERE/SELECT/SELECT FROM/HAVING/INSERT INTO/UPDATE~SET~/DELETE~FROM 이나 다른 하위 쿼리 내부에 중첩된 쿼리 
- 단독 실행이 가능하다.

1) UPDATE JOIN VIEW
-- 서브쿼리보다 훨씬 빠른 업데이트 
-- 테이블을 JOIN하여 업데이트 함 
-- 대용량의 데이터를 한 번에 수정 할 때 
-- 조인 조건의 컬럼이 UNIQUE 속성이어야 가능 (1:1 관계) →  만족하지 않으면 오류(ORA-01779)

** 예제 
   tb_a 테이블의 내용(new_addr1, new_addr2)을 tb_b에 존재하는 내용(n_addr1, n_addr2)으로 수정
   
    SELECT * FROM tb_a;
    SELECT * FROM tb_b;   
   
    UPDATE (  -- UPDATE 뒤에 나와야 하는 테이블명에 서브쿼리를 사용 
        SELECT a.new_addr1, a.new_addr2, b.n_addr1, b.n_addr2 
        FROM tb_a a, tb_b b 
        WHERE a.num = b.num 
    ) SET new_addr1 = n_addr1, new_addr2 = n_addr2; 
    COMMIT;

2) WITH 
-- 연산이 있을시 반드시 별명 사용 
    WITH tmp AS (
        SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
        FROM book b
        JOIN pub p ON b.pNum = p.pNum
        JOIN dsale d ON b.bCode = d.bCode
        JOIN sale s ON d.sNum = s.sNum
        JOIN cus c  ON s.cNum = c.cNum
     )  
     SELECT cNum, cName, SUM(amt) 
     FROM tmp
     GROUP BY cNum, cName;
     
3) 단일 행 서브쿼리 
-- 서브 쿼리의 수행 결과가 하나

  SELECT empNo, name, sal FROM emp
  WHERE sal < (SELECT sal FROM emp WHERE city = '서울');  -- 에러 : 서울에 해당하는 emp가 1개가 아님. 여러 행은 불가 

  SELECT empNo, name, sal FROM emp 
  WHERE sal < (SELECT AVG(sal) FROM emp); 

  SELECT empNo, name, sal FROM emp 
  WHERE sal < (SELECT AVG(sal), SUM(sal) FROM emp);  -- 에러 : 여러 컬럼 불가. 값이 하나가 아님. 

4) 다중 행 서브쿼리 
-- 서브 쿼리의 수행 결과가 두개 이상 
    - IN 
       SELECT bCode, bName FROM book 
       WHERE bCode IN (SELECT DISTINCT bCode FROM dSale);
    
    - ANY(SOME)
     -- OR 개념과 유사 
       SELECT bCode, bName FROM book 
       WHERE bCode = ANY (SELECT DISTINCT bCode FROM dSale);
       
       SELECT empNo, name, sal FROM emp 
       WHERE sal > ANY (2000000, 2500000, 3000000); 
    
    - ALL 
     -- AND와 유사한 개념 
       SELECT empNo, name, sal FROM emp 
       WHERE sal > ALL (2000000, 2500000, 3000000); 
       
       SELECT empNo, name, sal FROM emp
       WHERE sal > (SELECT MAX(sal) FROM emp WHERE city='인천');   
       SELECT empNo, name, sal FROM emp
       WHERE sal > ALL (SELECT sal FROM emp WHERE city='인천'); 
    
     - EXISTS
      -- 하나라도 있으면 참, 하나도 없으면 거짓 
      SELECT bName FROM book
      WHERE EXISTS (SELECT * FROM dsale WHERE qty>=10); -- qty>=10 조건을 만족하는 것이 있으면 모두 출력 
      
      SELECT bName FROM book
      WHERE EXISTS (SELECT * FROM dsale WHERE qty>=1000); -- 만족하는 데이터가 없으므로 출력 X  
 
5) 상호 연관 서브쿼리
 -- 안과 밖의 쿼리가 서로 연관되어 있다. 
 -- 서브쿼리 단독으로 실행 불가 
 -- 부하가 크기 때문에 사용을 권장하지 않음 
  SELECT name, sal, 
     (SELECT COUNT(e2.sal) + 1 FROM emp e2 
         WHERE e2.sal > e1.sal) 순위 
  FROM emp e1;
 
 ** 예제 
    SELECT * FROM stb;
    SELECT * FROM gtb;
     
  - hak, stb.score, grade 
     SELECT hak, score, 
           (SELECT MAX(score) FROM gtb WHERE score <= stb.score) gscore
     FROM stb;
     
     SELECT hak, s1.score, grade FROM ( 
           SELECT hak, score, (SELECT MAX(score) FROM gtb 
           WHERE score <= stb.score) gscore FROM stb
     ) s1 
     JOIN gtb s2 ON s1.gscore=s2.score; 
     
    
