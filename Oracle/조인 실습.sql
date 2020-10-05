[JOIN]
 - �� �̻��� ���̺�, ���� ���� �����ϴ� ���� 
 - query �� FROM ���� ���� ���̺��� ��Ÿ�� ������ ���� 
 - ����� �÷��� �̸��� �����ϴ� ���, ��ȣ���� ���ϱ� ���� ���̺� �̸����� �Լ� 
 
------- INNER JOIN 
[EQUI JOIN] 
-- ���� ���̺��� �����տ� �ش�Ǵ� ������ ������
    1)
    SELECT empNo, name, com, excel, word 
    FROM emp, emp_score 
    WHERE emp.empNO = emp_score.empNo;  -- ���� : ������ �÷����� �� ���̺� �����ϸ�, ��ȣ���� �߻� (ORA-00918
    
    SELECT e.empNo, name, com, excel, word 
    FROM emp e, emp_score s     -- ���̺�� ���� �ο��Ͽ� �����ϰ� �ۼ��ϱ� 
    WHERE e.empNO = s.empNo; 
    
    2)
    SELECT e.empNo, name, com, excel, word 
    FROM emp e 
    JOIN emp_score s ON e.empNo = s.empNo;

**�ǽ� - �Ǹ���Ȳ ���̺� �ۼ�
- ������ �÷��� ��� ���̺� �ִ��� Ȯ�� 
book : bCode, bName, bPRICE, pNum
pub : pNum, pName
sale : sNum, sDate, cNum
dsale : sNum, bCode, qty     *sale-dsale ������ ���� sNum�� �ʿ� 
cus : cNum, cName 

    1) SELECT <select_list> FROM ���̺�1, ���̺�2 WHERE ���̺�1.�÷� = ���̺�2.�÷�; 
    -- ���̺� ������ �ο��Ͽ� ������ �ۼ� 
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b, pub p, sale s, dsale d, cus c 
    WHERE b.pNum = p.pNum AND b.bCode = d.bCode AND d.sNum = s.sNum AND s.cNum = c.cNum;
    
    2) SELECT <select_list> FROM ���̺�1 [INNER] JOIN ���̺�2 ON ���̺�1.�÷� = ���̺�2.�÷�
     -- �߰����� ������ �Է��ϱ⿡ �� ������
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum;
    
    -- ���� �Ǹ� ��Ȳ 
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum
    WHERE TO_CHAR(SYSDATE,'YYYY') = TO_CHAR(sDate, 'YYYY');
    
    -- �۳� �Ǹ� ��Ȳ
    SELECT b.bCode, bName, bPrice, b.pNum, pName, sDate, s.cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub p ON b.pNum = p.pNum
    JOIN dsale d ON b.bCode = d.bCode
    JOIN sale s ON d.sNum = s.sNum
    JOIN cus c  ON s.cNum = c.cNum
    WHERE TO_CHAR(SYSDATE,'YYYY')-1 = TO_CHAR(sDate, 'YYYY');
    -- WHERE TO_CHAR(SYSDATE - (INTERVAL '1' YEAR),'YYYY') = TO_CHAR(sDate, 'YYYY');
    
    3) SELECT <select_list> FROM ���̺�1 [INNER] JOIN ���̺�2 USING (�÷�) 
    -- �÷����� ���� ��쿡�� ��� ���� 
    -- ������ ������� ���� 
    SELECT bCode, bName, bPrice, pNum, pName, sDate, cNum, cName, qty, bPrice*qty amt 
    FROM book b
    JOIN pub USING (pNum)
    JOIN dsale USING (bCode)
    JOIN sale USING (sNum)
    JOIN cus USING (cNum);

**���� 1
- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName), �ǸűǼ�����(qty ��) / å�ڵ� �������� 
book : bCode, bName
dsale : qty , bCode 

    SELECT b.bCode, bName, SUM(qty) ���ǸűǼ� 
    FROM book b 
    JOIN dSale d ON b.bCode = d.bCode
    GROUP BY b.bCode, bName
    ORDER BY bCode;

- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName), �ǸűǼ�����(qty ��), �Ǹűݾ���(qty*bPrice ��) / å�ڵ� ��������
book : bCode, bName, bPrice 
dsale : qty , bCode 

    SELECT DISTINCT b.bCode, bName, SUM(qty) ���ǸűǼ�, SUM(qty*bPrice) ���Ǹűݾ�
    FROM book b 
    JOIN dSale d ON b.bCODE = d.bCode
    GROUP BY b.bCode, bName
    ORDER BY bCode;

        --**SUM()OVER()�Ἥ �غ���**
        SELECT DISTINCT b.bCode, bName, SUM(qty)OVER(PARTITION BY b.bCode) ���ǸűǼ� 
        FROM book b 
        JOIN dSale d ON b.bCode = d.bCode
        ORDER BY bCode;
        
        SELECT DISTINCT b.bCode, bName, SUM(qty)OVER(PARTITION BY b.bCode) ���ǸűǼ� 
                                      , SUM(qty*bPrice)OVER(PARTITION BY b.bCode) ���Ǹűݾ�
        FROM book b 
        JOIN dSale d ON b.bCode = d.bCode
        ORDER BY bCode;

- �Ǹŵ� å�ڵ�(bCode), å�̸�(bName) : �ߺ� ���� 
book : bCode, bName
dsale : bCode 

    SELECT DISTINCT b.bCode, bName
    FROM book b 
    JOIN dSale d ON b.bCode = d.bCode;

- �Ǹŵ� å �� �ǸűǼ����� ���� ū å�ڵ�(bCode), å�̸�(bName)
book : bCode, bName
dsale : bCode , qty 

    -- 1. ������ �̿��Ͽ� ���ϱ� 
    SELECT bCode, bName FROM ( 
        SELECT b.bCode, bName, SUM(qty), RANK() OVER(ORDER BY SUM(qty) DESC) ����
        FROM book b 
        JOIN dSale d ON b.bCode = d.bCode
        GROUP BY b.bCode, bName
    ) WHERE ���� = 1;
    
    -- 2. HAVING���� �̿��Ͽ� ���ϱ� 
    SELECT b.bCode, bName 
    FROM book b 
    JOIN dsale d ON b.bCode = d.bCode
    GROUP BY b.bCode, bName
    HAVING SUM(qty) = ( 
        SELECT MAX(SUM(qty)) 
        FROM book b1
        JOIN dsale d1 ON b1.bCode = d1.bCode   -- �̹� ������ �������� b,c�� ��������Ƿ� 
        GROUP BY b1.bCode, bName
        );

**���� 2 
- �⵵�� �Ǹűݾ��� �� : �⵵, �Ǹ���(�⵵�� �Ǹ���) / �⵵ �������� 
sale : sDate   sNum 
dsale : qty    bCode  sNum
book : bPrice  bCode

    SELECT TO_CHAR(sDate, 'YYYY') �⵵ , SUM(qty*bPrice) �Ǹ���
    FROM dsale d
    JOIN book b ON d.bCode = b.bCode 
    JOIN sale s ON d.sNum = s.sNum 
    GROUP BY TO_CHAR(sDate, 'YYYY')
    ORDER BY �⵵;

- ����ȣ(cNum), ����(cName), �⵵, �Ǹűݾ��� / ����ȣ ��������, �⵵ �������� 
cus : cNum, cName   cNum
sale : sDate    sNum   cNum
dsale : qty     bCode  sNum
book : bPrice   bCode

    SELECT c.cNum ����ȣ, cName ����, TO_CHAR(sDate,'YYYY') �⵵, SUM(qty*bPrice) �Ǹűݾ��� 
    FROM cus c
    JOIN sale s ON c.cNum = s.cNum
    JOIN dsale d ON s.sNum = d.sNum
    JOIN book b ON d.bCode = b.bCode
    GROUP BY c.cNum, cName, TO_CHAR(sDate,'YYYY')
    ORDER BY ����ȣ, �⵵;

- ����ȣ(cNum), ����(cName) / �۳� ���� �Ǹűݾ��� ���� ���� �� ���
cus : cNum, cName cNum
sale : sDate    sNum cNum
dsale : qty     bCode sNum
book : bPrice   bCode

    SELECT ����ȣ, ���� FROM (
        SELECT c.cNum ����ȣ, cName ����, SUM(qty*bPrice) �۳�ݾ�, RANK() OVER(ORDER BY SUM(qty*bPrice) DESC) ����
        FROM cus c 
        JOIN sale s ON c.cNum = s.cNum
        JOIN dsale d ON s.sNum = d.sNum 
        JOIN book b ON d.bCode = b.bCode
        WHERE TO_CHAR(sDate,'YYYY') = TO_CHAR(SYSDATE,'YYYY')-1
        GROUP BY c.cNum, cName
     ) WHERE ���� = 1;            
 

- ����ȣ(cNum), ����(cName), ȸ�����̵�(userID) / ȸ�� �� ���� ���� �Ǹűݾ��� ���� ���� �� ���
cus : cNum, cName 
member : userId  cNum 
sale : sDate  sNum cNum
dsale : qty   sNum bCode
book : bPrice  bCode

    SELECT ����ȣ, ����, ȸ�����̵� FROM (
        SELECT c.cNum ����ȣ, cName ����, userId ȸ�����̵�, SUM(qty*bPrice), RANK() OVER(ORDER BY SUM(qty*bPrice) DESC) ����
        FROM cus c 
        JOIN member m ON c.cNum = m.cNum
        JOIN sale s ON c.cNum = s.cNum
        JOIN dsale d ON s.sNum = d.sNum
        JOIN book b ON d.bCode = b.bCode 
        WHERE TO_CHAR(sDATE,'YYYY') = TO_CHAR(SYSDATE,'YYYY')
        GROUP BY c.cNum, cName, userId
    ) WHERE ���� = 1; 

- å�ڵ�(bCode), å�̸�(bName), �ǸűǼ��� / �ǸűǼ� ���� 80�� �̻��� å�� ��� 
book : bCode, bName 
dsale : qty , bCode 
 
    SELECT b.bCode å�ڵ�, bName å�̸�, SUM(qty) �ǸűǼ�
    FROM book b
    JOIN dsale d ON b.bCode = d.bCode
    GROUP BY b.bCode, bName 
    HAVING SUM(qty) >= 80;
    
---------------------------------------------------------------------------------------
[NATURAL JOIN]
-- ��Ī ��� �Ұ�, �÷� �̸��� �ٸ��� ��� �Ұ�, �ӵ��� �ſ� ������ 

 SELECT �÷���, �÷��� ... FROM ���̺�1 NATURAL JOIN ���̺�2 

     SELECT bCode, bName, bPrice, pNum, pName, sDate, cNum, cName, qty, bPrice*qty amt 
     FROM book b
     NATURAL JOIN pub
     NATURAL JOIN dsale
     NATURAL JOIN sale
     NATURAL JOIN cus;
 
[CROSS JOIN]
-- ���̺��� ī��� �� ��ȯ. �м��� �뵵  

    SELECT p.pNum, pName, bCode, bName 
    FROM pub p 
    CROSS JOIN book b;

[SELF JOIN]
-- �ڱⰡ �ڱ� �ڽ��� JOIN
-- ��з�/�ߺз�/..

    SELECT b1.bcCode, b1.bcSubject, b1.pcCode, 
           b2.bcCode, b2.bcSubject, b2.pcCode
    FROM bclass b1
    JOIN bclass b2 ON b1.bcCode = b2.pcCode;       -- pcCode > null�̸� �ֻ��� �׷� 
    
[NON-EQUI JOIN] 
-- JOIN�� '=' �̿��� ������ ���   

SELECT a1.bCode, a1.aName, a2.aName 
FROM author a1
JOIN author a2 ON a1.bCode = a2.bCode
ORDER BY a1.bCode;
    
    -- ���ڰ� 2�� �̻��� �͸� ��� 
    SELECT a1.bCode, a1.aName, a2.aName 
    FROM author a1
    JOIN author a2 ON a1.bCode = a2.bCode AND a1.aName > a2.aName  
    ORDER BY a1.bCode;
    
    -- ���ڰ� 2�� �̻��� å�ڵ�� å�̸� ���
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
-- �º��� ���̺��� ����� ��� �������� �캯�� ������ �����ϴ� �����͸� �����´�.

book : bCode, bName / dsale : bCode, sNum, qty 
-- EQUI JOIN 
    SELECT b.bCode, bName, sNum, qty 
    FROM book b, dsale d 
    WHERE b.bCode = d.bCode;

-- LEFT OUTER JOIN
    1) ������
    SELECT b.bCode, bName, sNum, qty 
    FROM book b, dsale d 
    WHERE b.bCode = d.bCode(+);  -- �Ǹŵ��� ���� å�� ��� 
    
    2) ����� 
    SELECT b.bCode, bName, sNum, qty 
    FROM book b
    LEFT OUTER JOIN dsale d ON b.bCode = d.bCode;


**���� 
- bCode, bName, sNum, sDate, qty ��� (��, bCode�� bName�� �ѱǵ� �ǸŰ� ���� ���� å�� ���) 

    SELECT b.bCode, bName, d.sNum, sDate, qty 
    FROM book b 
    LEFT OUTER JOIN dsale d ON b.bCode = d.bCode
    LEFT OUTER JOIN sale s ON d.sNum = s.sNum;

- �Ǹ� �� / �Ǹ� �� �� å�ڵ�, å�̸��� ���     
 
     1) IN ��� 
     SELECT b.bCode, bName
     FROM book b 
     WHERE bCode IN (SELECT DISTINCT bCode FROM dSale);
     
     2) JOIN ��� 
     SELECT b.bCode, bName
     FROM book b 
     LEFT OUTER JOIN dSale d ON b.bCode = d.bCode
     WHERE d.bCode IS NOT NULL;                     -- �Ǹ� �� ����Ʈ 
     
     SELECT b.bCode, bName
     FROM book b 
     LEFT OUTER JOIN dSale d ON b.bCode = d.bCode
     WHERE d.bCode IS NOT NULL;                     -- �Ǹ� ���� ���� ����Ʈ
     
- �� �� �Ǹŵ� å�ڵ�, å�̸�    

    SELECT bCode, bName
	FROM book
	WHERE bCode IN (
       SELECT DISTINCT bCode
	   FROM dsale d
	   JOIN sale s ON d.sNum = s.sNum AND TO_CHAR(sDate, 'YYYY') = TO_CHAR(SYSDATE, 'YYYY')
		);

[RIGHT OUTER JOIN] 
-- �캯�� ���̺��� ����� ��� �������� �º��� ������ �����ϴ� �����͸� �����´�.
book : bCode, bName / dsale : bCode, sNum, qty 
-- EQUI JOIN 
    SELECT b.bCode, bName, sNum, qty 
    FROM book b, dsale d 
    WHERE b.bCode = d.bCode;

-- RIGHT OUTER JOIN
    1) ������
    SELECT b.bCode, bName, sNum, qty 
    FROM dsale d, book b 
    WHERE d.bCode(+) = b.bCode;  -- �Ǹŵ��� ���� å�� ��� 
    
    2) ����� 
    SELECT b.bCode, bName, sNum, qty 
    FROM dsale d 
    RIGHT OUTER JOIN book b ON d.bCode = b.bCode;

[FULL OUTER JOIN] 
-- �º��� �캯�� ����� ��� �����´�. (������) 

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
    FULL OUTER JOIN cus c ON c.cNum = s.cNum; -- cNum, cName    // sDate sNum cNum userId + cNum cName (cName null ���) 
    
    SELECT sNum, sDate, s.cNum, m.cNum, cName, userId
	FROM cus c    -- cNum, cName 
	FULL OUTER JOIN member m ON c.cNum = m.cNum -- userId, cNum  // cNum cName + userId cNum 
	FULL OUTER JOIN sale s ON c.cNum = s.cNum; -- sDate, sNum   // cNum cName userId cNum  + sDate sNum 


**���� 
- ��ȸ�� �Ǹ� ��Ȳ : cNum, cName, bCode, bName, sDate, bPrice, qty 
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
    
    ------ RIGHT �� �غ��� *** ���Ѱ� 
      SELECT s.cNum, cName, b.bCode, bName, sDate, bPrice, qty
      FROM  book b
      JOIN  dsale d  ON  b.bCode = d.bCode
      JOIN  sale s   ON  d.sNum = s.sNum
      JOIN  member m  ON  m.cNum = s.cNum
      RIGHT OUTER JOIN cus c ON  c.cNum = m.cNum
      WHERE userId IS NULL
      ORDER BY cNum;

- ���� ���� �Ǹ� �ݾ� : cNum, cName, bPrice*qty �� (��, ���� å�� �ѱǵ� �������� ���� ���� ���) 
cus(cNum, cName) 
sale(cNum, sNum)
dsale(qty, bCode, sNum) 
book(bPrice, bCode)

    SELECT c.cNum, cName, NVL(SUM(bPrice*qty),0) �� 
    FROM cus c
    LEFT OUTER JOIN sale s ON c.cNum = s.cNum
    LEFT OUTER JOIN dsale d ON s.sNum = d.sNum
    LEFT OUTER JOIN book b ON d.bCode = b.bCode
    GROUP BY c.cNum, cName
    ORDER BY c.cNum, cName;

- ���� ���� �Ǹ� �ݾ� �� ���� : cNum, cName, bPrice*qty ��, ��ü �Ǹ� �ݾ׿� ���� ����
cus(cNum, cName) 
sale(cNum, sNum)
dsale(qty, bCode, sNum) 
book(bPrice, bCode)

    SELECT DISTINCT c.cNum, cName, 
                    SUM(bPrice*qty) OVER(PARTITION BY c.cNum, cName) ��, 
                    ROUND((SUM(bPrice*qty) OVER(PARTITION BY c.cNum, cName) / SUM(bPrice*qty) OVER())*100,1) || '%' ����
                    --ROUND(RATIO_TO_REPORT(SUM(bPrice*qty)) OVER() * 100, 1) 
    FROM cus c
    JOIN sale s ON c.cNum = s.cNum
    JOIN dsale d ON s.sNum = d.sNum
    JOIN book b ON d.bCode = b.bCode
    ORDER BY c.cNum;

- �⵵�� �� ���� �Ǹűݾ��� ���� ���� ������ : �Ǹų⵵, cNum, cName, bPrice*qty �� / �⵵�� �������� 
cus(cNum, cName) 
sale(sDate, cNum, sNum)
dsale(qty, bCode, sNum) 
book(bPrice, bCode)

    SELECT �Ǹų⵵, cNum, cName, �� FROM ( 
        SELECT TO_CHAR(sDate,'YYYY') �Ǹų⵵, c.cNum, cName, SUM(bPrice*qty) ��, 
               RANK() OVER(PARTITION BY TO_CHAR(sDate,'YYYY') ORDER BY SUM(bPrice*qty)) ����
        FROM cus c 
        JOIN sale s ON c.cNum = s.cNum
        JOIN dsale d ON s.sNum = d.sNum
        JOIN book b ON d.bCode = b.bCode 
        GROUP BY TO_CHAR(sDate,'YYYY'), c.cNum, cName  
    ) WHERE ���� = 1;

**���� 
- �⵵�� ���� ������ �Ǹ� ������ �� ���ϱ� / �⵵ ��������, å�ڵ� �������� 
  �⵵ å�ڵ� å�̸�  1�� 2�� 3�� ... 12�� 
  
  book (bCode, bName) 
  sale (sDate, sNum) 
  dsale (qty, bCode, sNum) 
  
             SELECT TO_CHAR(sDate,'YYYY') �⵵, b.bCode å�ڵ�, bName å�̸�, 
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),1,qty)),0) "1��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),2,qty,0)),0) "2��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),3,qty,0)),0) "3��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),4,qty,0)),0) "4��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),5,qty,0)),0) "5��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),6,qty,0)),0) "6��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),7,qty,0)),0) "7��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),8,qty,0)),0) "8��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),9,qty,0)),0) "9��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),10,qty,0)),0) "10��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),11,qty,0)),0) "11��",
                                NVL(SUM(DECODE(TO_CHAR(sDate,'MM'),12,qty,0)),0) "12��"                            
                 FROM book b
                 JOIN dsale d ON b.bCode = d.bCode 
                 JOIN sale s ON d.snum = s.snum            
                 GROUP BY TO_CHAR(sDate,'YYYY'),b.bCode, bName
                 ORDER BY TO_CHAR(sDate,'YYYY');
 
** PDF ���� 

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
       DECODE(gubun,1,'1�б��߰�',2,'1�б�⸻',3,'2�б��߰�','2�б�⸻') ����,
       name, com, excel, word,
       com+excel+word tot, ROUND((com+excel+word)/3,1) ave,
       RANK() OVER(PARTITION BY gubun,HAK,BAN ORDER BY ROUND((com+excel+word)/3,1) DESC) �б޼���,
       RANK() OVER(PARTITION BY gubun,HAK ORDER BY ROUND((com+excel+word)/3,1) DESC) �г⼮��
FROM score s
JOIN injeok i ON s.hakbeon = i.hakbeon
ORDER BY gubun, hak, ban;


2) 
SELECT hak, ban, 
       DECODE(gubun,1,'1�б��߰�',2,'1�б�⸻',3,'2�б��߰�','2�б�⸻') ����,
       name, com+excel+word tot, ROUND((com+excel+word)/3,1) ave,
       CASE 
        WHEN com >= 40 AND excel >=40 AND word >=40 AND ROUND((com+excel+word)/3,1)>=60 THEN '�հ�' 
        WHEN ROUND((com+excel+word)/3,1) < 60 THEN '���հ�'
        ELSE '����'
       END ���� 
FROM score s
JOIN injeok i ON s.hakbeon = i.hakbeon;
   
          