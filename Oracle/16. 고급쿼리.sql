[��� ����]

1) ������ ����  
-- 2���� ������ ���̺�� ����� �����͸� ������ ������ ����� ��ȯ�ϴ� ���� 
   ---------------------------------------------------------------------
     SELECT num, subject, LEVEL, parent FROM soft
     START WITH num=1
     CONNECT BY PRIOR num = parent;                -- �������� ������ ��� 
   --------------------------------------------------------------------- 
   - CONNECT BY PRIOR : �� ���� ��� ���� ������ ����Ŭ���� �˷��ִ� ���� 
     - CONNECT BY : ������ ���ǿ����� ���
     - PRIOR : ���� ��� �ٸ� ���� �����ϴ� ������, PRIOR �ڿ� ���� �÷��� �߿�
   - LEVEL : �˻� �� ����� ���Ͽ� �������� ���� ��ȣ ���  
     - ��Ʈ 1, ������ ������ 1�� ���� 
     - CONNECT BY ������ ��� ���� 
   - START WITH num = 1 : ��� ���� ��ġ(�ֻ��� ���� ��) 
   - PRIOR num = parent : ������ ���� ���� 
     - ��(num)�� �θ�(parent)�� ����ϴ� �� (�������� �˻�) 
     - parent �÷� : ���� ������ ���� �÷� 
   ------------------------------------------------------------------------------- 
    - ������  
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=1
      CONNECT BY PRIOR num = parent;    
      
    - �ֻ��� �ϳ��� ��� 
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=1
      CONNECT BY PRIOR parent = num;
    
    - �������� ������ ��� (��ü X, �� �׷츸) 
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=15
      CONNECT BY PRIOR parent = num;    
      ( = CONNECT BY num = PRIOR parent;)     
    -------------------------------------------------------------------------------     
    - ���� 
     - ORDER BY / GROUP BY : �߸��� ���� (���� ������ ����)
         SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
         START WITH num=1
         CONNECT BY PRIOR num = parent
         ORDER BY subject;
    
     - ORDER SIBLINGS BY : ���� ������ ���� ���� 
         SELECT num, subject, LEVEL, parent FROM soft
         START WITH num=1
         CONNECT BY PRIOR num = parent
         ORDER SIBLINGS BY subject;
     ------------------------------------------------------------------------------- 
     - �������� ������ ��� (��üX, �� �׷츸)
       SELECT num, subject, LEVEL, parent FROM soft
       START WITH num=3
       CONNECT BY PRIOR num = parent;
     
     - WHERE ���� �������� �򰡵Ǹ� num�� 3�� �͸� ��µ��� ���� 
       SELECT num, subject, LEVEL, parent FROM soft
       WHERE num != 3
       START WITH num=1
       CONNECT BY PRIOR num = parent;
     
     - DB�� DB ������ ������� ���� 
       SELECT num, subject, LEVEL, parent FROM soft
       WHERE num != 3
       START WITH num=1
       CONNECT BY PRIOR num = parent AND num != 3;
     ------------------------------------------------------------------------------- 
     - LEVEL ���� 
         SELECT ROWNUM FROM dual WHERE ROWNUM <=20; -- 1�� ���
         SELECT LEVEL v FROM dual CONNECT BY LEVEL <= 20; -- 20�� ���     
         SELECT 1 FROM dual CONNECT BY LEVEL <=10; -- 10�� ��� 
      
      ** ��¥���� �̿� 
         SELECT TO_DATE('2020-03-19')+LEVEL-1 FROM dual CONNECT BY LEVEL <= 7;
     -------------------------------------------------------------------------------    
     - CONNECT_BY_ROOT : �ֻ��� �� ���   
        SELECT num, subject, LEVEL, parent, CONNECT_BY_ROOT subject
        FROM soft
        START WITH num=1
        CONNECT BY PRIOR num = parent;    
        
        SELECT num, subject, LEVEL, parent, CONNECT_BY_ROOT subject
        FROM soft
        START WITH num=3
        CONNECT BY PRIOR num = parent;  
     -------------------------------------------------------------------------------     
     - SYS_CONNECT_BY_PATH : �ֻ��� ��(��Ʈ)���� �ڽű��� ����  
        SELECT num, subject, LEVEL, parent, SYS_CONNECT_BY_PATH(subject,'>')
        FROM soft
        START WITH num=1
        CONNECT BY PRIOR num = parent;
     
     ** ���� ��� ����    
         SELECT ROWNUM rnum, name FROM emp WHERE city = '����';
         
         SELECT SYS_CONNECT_BY_PATH(name, ',') name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '����'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;
        
         SELECT MAX(SYS_CONNECT_BY_PATH(name, ',')) name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '����'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;  
          
         SELECT SUBSTR(MAX(SYS_CONNECT_BY_PATH(name, ',')),2) name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '����'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;  


2) PIVOT
-- ���� ������ �ٲٴ� �� (ROW ������ �����͸� COLUMN ���·�)
 - ���� 
     SELECT * FROM ( 
        SELECT <select_list> FROM ���̺�� 
    ) PIVOT ( 
        �����Լ� FOR �÷��� IN (�÷��� ����ִ� ��� ����)
    );
  
 ** ���� 
 - ���� ������ ����� �ٲپ� ��� 
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
      
 - �μ��� �÷����� ������ 
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
        '���ߺ�' AS "���ߺ�" , '��ȹ��' AS "��ȹ��"
       ,'������' AS "������" , '�λ��' AS "�λ��"
       ,'�����' AS "�����" , '�ѹ���' AS "�ѹ���"
       ,'ȫ����' AS "ȫ����"
      )
   );

 - ���� �Ի� �ο� �� 
       SELECT * FROM (
         SELECT TO_CHAR(hireDate,'MM') ����    
         FROM emp   
      ) PIVOT (
         COUNT(����) FOR ���� IN (
         '01','02','03','04','05','06','07','08','09','10','11','12')
      );
  
 - �μ��� �����޿��� 
   pos ���ߺ� ... ȫ���� 
   ���� x x xx ..  
      SELECT * FROM (
        SELECT dept, pos, sal FROM emp
        GROUP BY dept, pos, sal
      ) PIVOT (
         SUM(sal) FOR dept IN (
            '���ߺ�' AS ���ߺ� , '��ȹ��' AS ��ȹ��
           ,'������' AS ������ , '�λ��' AS �λ��
           ,'�����' AS ����� , '�ѹ���' AS �ѹ���
           ,'ȫ����' AS ȫ����
         )
       ) ORDER BY pos;
  
 - �⵵ ���� �Ǹ���Ȳ(bPrice*qty ��)
    �⵵ 1�� ... 12�� 
      SELECT �⵵, NVL("1��",0) "1��", NVL("2��",0) "2��", NVL("3��",0) "3��", NVL("4��",0) "4��",
                   NVL("5��",0) "5��", NVL("6��",0) "6��", NVL("7��",0) "7��", NVL("8��",0) "8��",
                   NVL("9��",0) "9��", NVL("10��",0) "10��", NVL("11��",0) "11��", NVL("12��",0) "12��"
     FROM ( 
        SELECT TO_CHAR(sDate,'YYYY') �⵵, TO_CHAR(sDate,'MM') ����, bPrice*qty ��
        FROM book b 
        JOIN dsale d ON b.bCode = d.bCode 
        JOIN sale s ON d.sNum = s.sNum    
      ) PIVOT ( 
         SUM(��) FOR ���� IN ( 
            '01' AS "1��", '02' AS "2��", '03' AS "3��", '04' AS "4��", '05' AS "5��", '06' AS "6��",
            '07' AS "7��", '08' AS "8��", '09' AS "9��", '10' AS "10��", '11' AS "11��", '12' AS "12��"
          )
        ) ORDER BY �⵵;
  
  - ���Ϻ� �Ի��ο�   
      SELECT * FROM (
        SELECT TO_CHAR(hiredate,'DAY') ����
        FROM emp 
      ) PIVOT (
         COUNT(����) FOR ���� IN (
            '������' ��, 'ȭ����' ȭ, '������' ��, '�����' ��, '�ݿ���' ��, '�����' ��, '�Ͽ���' ��
            )
         );
  
  
3) UNPIVOT
-- ���� ���� �ٲٴ� �� (COLUMN ������ �����͸� ROW ���·�)
-- ��������� PIVOT�� �ݴ�Ǵ� ����������, PIVOT�� ����� �ǵ����� ����� �ƴϴ�. 

     SELECT * FROM t_city
     UNPIVOT
     (
        �ο��� 
        FOR buseo IN(���ߺ�, ��ȹ��, ������, �λ��, �����, �ѹ���, ȫ����)
     );
     
     
4) ���Խ� (Regular Expression) 
-- ���ڿ� �������� ������ ���� �� ������ ������ �˻� �� �� �ִ� ����
 - ���Խ� ���� 
         . | NULL �� ������ ������ ���ڿ� ��ġ     
         + | �� �� �̻� ��ġ    
         ? | 0 or 1�� ��ġ    
         * | 0�� �̻� ��ġ 
       {m} | m�� ��ġ     
     {m,n} | �ּ� m��, �ִ� n�� ��ġ 
     [...] | ��ȣ �� ���ڿ� ��ġ 
         ^ | ���ڿ� ���� �κа� ��ġ ([ ] �ȿ� ������ NOT �� �ǹ�)
         $ | ���ڿ� �� �κа� ��ġ
        \d | ����  
 [:class:] | ��ȣ �� ���� Ŭ������ ��ҿ� ��ġ 
            [:alpha:] | ���ĺ� ���� 
            [:digit:] | ���� 
            [:lower:] | �ҹ��� 
            [:upper:] | �빮�� 
            [:alnum:] | ���ĺ� + ���� 
            [:space:] | ���� 
            [:punct:] | Ư�� ���� 
            [:cntrl:] | ��Ʈ�� ����
            [:print:] | ��� ������ ���� 
        
 - REGEXP_LIKE : ������ ���Ե� ���ڿ� ��ȯ (LIKE�� ����) 
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[�ѹ�]');       -- ^ : ���� ���ڷ� ����
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '����$');         -- $ : ���� ���ڷ� ��
   
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'com$','i');    -- i : ��ҹ��� ���� �� �� 
    
    -- kim�� �����ϴ� ���ڵ�
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim*');        
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim');
    
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim3?3'); 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[0-3]{2}');  -- 0~3 ������ ���ڰ� 2���̻� �ݺ��Ǵ� ���ڵ� 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[2-3]{3,4}'); -- 2~3 ������ ���ڰ� �ּ� 3��, �ִ� 4�� �ݺ��Ǵ� ���ڵ�
    
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[^1]');      -- kim ������ 1�� �������� �ʴ� ���ڵ� 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[^1]$');        -- 1�� ������ �ʴ� ���ڵ�
    
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[��-�R]{1,10}$');   -- �̸��� 1~10�� �����̰� �ѱ��� ���ڵ�
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[��-�R]{2,}$');     
    
    -- �̸��Ͽ� ���ڰ� ���Ե� ���ڵ� 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[0-9]');   
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[[:digit:]]');
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '.*[[:digit:]].*');
    
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '[[:lower:]]');  -- �̸��� �ҹ��ڸ� �ִ� ���ڵ� 
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '[a-z|A-Z]');    -- �ҹ��� or �빮�� �ִ� ���ڵ�

 - REGEXP_REPLACE : ��ü ���ڿ��� ����
    SELECT REGEXP_REPLACE('kim gil dong','(.*) (.*) (.*)','\3 \2 \1') FROM dual;
    
    SELECT email FROM reg;
    SELECT email, REGEXP_REPLACE(email, '(.*)@(.*)', '\1'),            -- @ �պκи� ���
                  REGEXP_REPLACE(email, '(.*)@(.*)', '\2') FROM reg;   -- @ �޺κи� ��� 
    
    SELECT email, REGEXP_REPLACE(email,'arirang','�Ƹ���') FROM reg;              
 
    SELECT REGEXP_REPLACE('24jj$%^*^$$#@@$24', '[[:digit:]|[:punct:]]', '') FROM dual;  -- ����, Ư������ ���� 
    
    SELECT name, rrn, REGEXP_REPLACE(rrn,'[0-9|\-]', '*', 9) FROM emp;   -- 9��°���� *�� ����
    
 - REGEXP_INSTR : ���� �񱳸� ���� ��ġ ���� Ȯ��
    SELECT email, REGEXP_INSTR(email, '[0-9]') FROM reg;  -- ���ڰ� �ִ� ���� ��ġ 
 
 - REGEXP_SUBSTR : ������ �˻��Ͽ� �κ� ���ڿ� ���� 
 
 - REGEXP_COUNT : ������ �˻��Ͽ� �߰� �� Ƚ�� ���
    SELECT email, REGEXP_COUNT(email, 'a') FROM reg;
     
        
        
        
*********************************** ���� 

SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation
ORDER BY checkIn ASC;

-- 20200724 ~ 20200729 ���� �� ��. 0729�� checkOut �Ǹ� 0729�� checkIn ����

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200724) AND TO_DATE(checkin) <= TO_DATE(20200729) OR 
       TO_DATE(checkout) > TO_DATE(20200724) AND TO_DATE(checkout) < TO_DATE(20200729); 
 
-- 20200727 ~ 20200728 ���� �� ��.

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200727) AND TO_DATE(checkin) <= TO_DATE(20200728) OR 
       TO_DATE(checkout) > TO_DATE(20200727) AND TO_DATE(checkout) < TO_DATE(20200728); 


-- 20200730 ~ 20200801 ���� �� ��.

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200730) AND TO_DATE(checkin) <= TO_DATE(20200801) OR 
       TO_DATE(checkout) > TO_DATE(20200730) AND TO_DATE(checkout) < TO_DATE(20200801); 
   