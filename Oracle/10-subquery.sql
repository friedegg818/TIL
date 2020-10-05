[SUBQUERY]
- WHERE/SELECT/SELECT FROM/HAVING/INSERT INTO/UPDATE~SET~/DELETE~FROM �̳� �ٸ� ���� ���� ���ο� ��ø�� ���� 
- �ܵ� ������ �����ϴ�.

1) UPDATE JOIN VIEW
-- ������������ �ξ� ���� ������Ʈ 
-- ���̺��� JOIN�Ͽ� ������Ʈ �� 
-- ��뷮�� �����͸� �� ���� ���� �� �� 
-- ���� ������ �÷��� UNIQUE �Ӽ��̾�� ���� (1:1 ����) ��  �������� ������ ����(ORA-01779)

** ���� 
   tb_a ���̺��� ����(new_addr1, new_addr2)�� tb_b�� �����ϴ� ����(n_addr1, n_addr2)���� ����
   
    SELECT * FROM tb_a;
    SELECT * FROM tb_b;   
   
    UPDATE (  -- UPDATE �ڿ� ���;� �ϴ� ���̺�� ���������� ��� 
        SELECT a.new_addr1, a.new_addr2, b.n_addr1, b.n_addr2 
        FROM tb_a a, tb_b b 
        WHERE a.num = b.num 
    ) SET new_addr1 = n_addr1, new_addr2 = n_addr2; 
    COMMIT;

2) WITH 
-- ������ ������ �ݵ�� ���� ��� 
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
     
3) ���� �� �������� 
-- ���� ������ ���� ����� �ϳ�

  SELECT empNo, name, sal FROM emp
  WHERE sal < (SELECT sal FROM emp WHERE city = '����');  -- ���� : ���￡ �ش��ϴ� emp�� 1���� �ƴ�. ���� ���� �Ұ� 

  SELECT empNo, name, sal FROM emp 
  WHERE sal < (SELECT AVG(sal) FROM emp); 

  SELECT empNo, name, sal FROM emp 
  WHERE sal < (SELECT AVG(sal), SUM(sal) FROM emp);  -- ���� : ���� �÷� �Ұ�. ���� �ϳ��� �ƴ�. 

4) ���� �� �������� 
-- ���� ������ ���� ����� �ΰ� �̻� 
    - IN 
       SELECT bCode, bName FROM book 
       WHERE bCode IN (SELECT DISTINCT bCode FROM dSale);
    
    - ANY(SOME)
     -- OR ����� ���� 
       SELECT bCode, bName FROM book 
       WHERE bCode = ANY (SELECT DISTINCT bCode FROM dSale);
       
       SELECT empNo, name, sal FROM emp 
       WHERE sal > ANY (2000000, 2500000, 3000000); 
    
    - ALL 
     -- AND�� ������ ���� 
       SELECT empNo, name, sal FROM emp 
       WHERE sal > ALL (2000000, 2500000, 3000000); 
       
       SELECT empNo, name, sal FROM emp
       WHERE sal > (SELECT MAX(sal) FROM emp WHERE city='��õ');   
       SELECT empNo, name, sal FROM emp
       WHERE sal > ALL (SELECT sal FROM emp WHERE city='��õ'); 
    
     - EXISTS
      -- �ϳ��� ������ ��, �ϳ��� ������ ���� 
      SELECT bName FROM book
      WHERE EXISTS (SELECT * FROM dsale WHERE qty>=10); -- qty>=10 ������ �����ϴ� ���� ������ ��� ��� 
      
      SELECT bName FROM book
      WHERE EXISTS (SELECT * FROM dsale WHERE qty>=1000); -- �����ϴ� �����Ͱ� �����Ƿ� ��� X  
 
5) ��ȣ ���� ��������
 -- �Ȱ� ���� ������ ���� �����Ǿ� �ִ�. 
 -- �������� �ܵ����� ���� �Ұ� 
 -- ���ϰ� ũ�� ������ ����� �������� ���� 
  SELECT name, sal, 
     (SELECT COUNT(e2.sal) + 1 FROM emp e2 
         WHERE e2.sal > e1.sal) ���� 
  FROM emp e1;
 
 ** ���� 
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
     
    