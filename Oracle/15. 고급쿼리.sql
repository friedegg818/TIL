[°í±Þ Äõ¸®]

1) °èÃþÇü Äõ¸®  
-- 2Â÷¿ø ±¸Á¶ÀÇ Å×ÀÌºí·Î ÀúÀåµÈ µ¥ÀÌÅÍ¸¦ °èÃþÇü ±¸Á¶ÀÇ °á°ú·Î ¹ÝÈ¯ÇÏ´Â Äõ¸® 
   ---------------------------------------------------------------------
     SELECT num, subject, LEVEL, parent FROM soft
     START WITH num=1
     CONNECT BY PRIOR num = parent;                -- »óÀ§¿¡¼­ ÇÏÀ§·Î Ãâ·Â 
   --------------------------------------------------------------------- 
   - CONNECT BY PRIOR : °¢ ÇàÀÌ ¾î¶»°Ô ¿¬°á µÉÁö¸¦ ¿À¶óÅ¬¿¡°Ô ¾Ë·ÁÁÖ´Â ¿ªÇÒ 
     - CONNECT BY : °èÃþÀû ÁúÀÇ¿¡¼­¸¸ »ç¿ë
     - PRIOR : ÀÌÀü Çà°ú ´Ù¸¥ ÇàÀ» ¿¬°áÇÏ´Â ¿¬»êÀÚ, PRIOR µÚ¿¡ ¿À´Â ÄÃ·³ÀÌ Áß¿ä
   - LEVEL : °Ë»ö µÈ °á°ú¿¡ ´ëÇÏ¿© °èÃþº°·Î ·¹º§ ¹øÈ£ Ãâ·Â  
     - ·çÆ® 1, ÇÏÀ§·Î °¥¼ö·Ï 1¾¿ Áõ°¡ 
     - CONNECT BY ¿¡¼­¸¸ »ç¿ë °¡´É 
   - START WITH num = 1 : Ãâ·Â ½ÃÀÛ À§Ä¡(ÃÖ»óÀ§ °èÃþ Çà) 
   - PRIOR num = parent : °èÃþÀû °ü°è ÁöÁ¤ 
     - ³ª(num)¸¦ ºÎ¸ð(parent)·Î »ç¿ëÇÏ´Â Çà (ºÎÇÏÁ÷¿ø °Ë»ö) 
     - parent ÄÃ·³ : »óÀ§ Á¤º¸¸¦ °¡Áø ÄÃ·³ 
   ------------------------------------------------------------------------------- 
    - Á¶Á÷µµ  
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=1
      CONNECT BY PRIOR num = parent;    
      
    - ÃÖ»óÀ§ ÇÏ³ª¸¸ Ãâ·Â 
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=1
      CONNECT BY PRIOR parent = num;
    
    - ÇÏÀ§¿¡¼­ »óÀ§·Î Ãâ·Â (ÀüÃ¼ X, ÇÑ ±×·ì¸¸) 
      SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
      START WITH num=15
      CONNECT BY PRIOR parent = num;    
      ( = CONNECT BY num = PRIOR parent;)     
    -------------------------------------------------------------------------------     
    - Á¤·Ä 
     - ORDER BY / GROUP BY : Àß¸øµÈ Á¤·Ä (°èÃþ ±¸Á¶°¡ ±úÁü)
         SELECT num, LPAD(' ',(LEVEL-1)*4)||subject subject, LEVEL, parent FROM soft
         START WITH num=1
         CONNECT BY PRIOR num = parent
         ORDER BY subject;
    
     - ORDER SIBLINGS BY : °°Àº ·¹º§¿¡ ÇÑÇØ Á¤·Ä 
         SELECT num, subject, LEVEL, parent FROM soft
         START WITH num=1
         CONNECT BY PRIOR num = parent
         ORDER SIBLINGS BY subject;
     ------------------------------------------------------------------------------- 
     - »óÀ§¿¡¼­ ÇÏÀ§·Î Ãâ·Â (ÀüÃ¼X, ÇÑ ±×·ì¸¸)
       SELECT num, subject, LEVEL, parent FROM soft
       START WITH num=3
       CONNECT BY PRIOR num = parent;
     
     - WHERE ÀýÀº ¸¶Áö¸·¿¡ Æò°¡µÇ¸ç numÀÌ 3ÀÎ °Í¸¸ Ãâ·ÂµÇÁö ¾ÊÀ½ 
       SELECT num, subject, LEVEL, parent FROM soft
       WHERE num != 3
       START WITH num=1
       CONNECT BY PRIOR num = parent;
     
     - DB¿Í DB ÇÏÀ§µµ Ãâ·ÂÇÏÁö ¾ÊÀ½ 
       SELECT num, subject, LEVEL, parent FROM soft
       WHERE num != 3
       START WITH num=1
       CONNECT BY PRIOR num = parent AND num != 3;
     ------------------------------------------------------------------------------- 
     - LEVEL ÀÀ¿ë 
         SELECT ROWNUM FROM dual WHERE ROWNUM <=20; -- 1¹ø Ãâ·Â
         SELECT LEVEL v FROM dual CONNECT BY LEVEL <= 20; -- 20¹ø Ãâ·Â     
         SELECT 1 FROM dual CONNECT BY LEVEL <=10; -- 10¹ø Ãâ·Â 
      
      ** ³¯Â¥¿¡¼­ ÀÌ¿ë 
         SELECT TO_DATE('2020-03-19')+LEVEL-1 FROM dual CONNECT BY LEVEL <= 7;
     -------------------------------------------------------------------------------    
     - CONNECT_BY_ROOT : ÃÖ»óÀ§ Çà Ãâ·Â   
        SELECT num, subject, LEVEL, parent, CONNECT_BY_ROOT subject
        FROM soft
        START WITH num=1
        CONNECT BY PRIOR num = parent;    
        
        SELECT num, subject, LEVEL, parent, CONNECT_BY_ROOT subject
        FROM soft
        START WITH num=3
        CONNECT BY PRIOR num = parent;  
     -------------------------------------------------------------------------------     
     - SYS_CONNECT_BY_PATH : ÃÖ»óÀ§ Çà(·çÆ®)¿¡¼­ ÀÚ½Å±îÁö ¿¬°á  
        SELECT num, subject, LEVEL, parent, SYS_CONNECT_BY_PATH(subject,'>')
        FROM soft
        START WITH num=1
        CONNECT BY PRIOR num = parent;
     
     ** ¼­¿ï »ç¶÷ ¿¬°á    
         SELECT ROWNUM rnum, name FROM emp WHERE city = '¼­¿ï';
         
         SELECT SYS_CONNECT_BY_PATH(name, ',') name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '¼­¿ï'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;
        
         SELECT MAX(SYS_CONNECT_BY_PATH(name, ',')) name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '¼­¿ï'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;  
          
         SELECT SUBSTR(MAX(SYS_CONNECT_BY_PATH(name, ',')),2) name FROM (
            SELECT ROWNUM rnum, name FROM emp WHERE city = '¼­¿ï'
          ) START WITH rnum=1
          CONNECT BY PRIOR rnum=rnum-1;  


2) PIVOT
-- ¿­À» ÇàÀ¸·Î ¹Ù²Ù´Â °Í (ROW ÇüÅÂÀÇ µ¥ÀÌÅÍ¸¦ COLUMN ÇüÅÂ·Î)
 - Çü½Ä 
     SELECT * FROM ( 
        SELECT <select_list> FROM Å×ÀÌºí¸í 
    ) PIVOT ( 
        Áý°èÇÔ¼ö FOR ÄÃ·³¸í IN (ÄÃ·³¿¡ µé¾îÀÖ´Â ¿ä¼Ò ÀüºÎ)
    );
  
 ** ¿¹Á¦ 
 - ´ÙÀ½ Äõ¸®¸¦ Çà·ÄÀ» ¹Ù²Ù¾î Ãâ·Â 
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
      
 - ºÎ¼­¸¦ ÄÃ·³À¸·Î º¸³»±â 
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
        '°³¹ßºÎ' AS "°³¹ßºÎ" , '±âÈ¹ºÎ' AS "±âÈ¹ºÎ"
       ,'¿µ¾÷ºÎ' AS "¿µ¾÷ºÎ" , 'ÀÎ»çºÎ' AS "ÀÎ»çºÎ"
       ,'ÀÚÀçºÎ' AS "ÀÚÀçºÎ" , 'ÃÑ¹«ºÎ' AS "ÃÑ¹«ºÎ"
       ,'È«º¸ºÎ' AS "È«º¸ºÎ"
      )
   );

 - ¿ùº° ÀÔ»ç ÀÎ¿ø ¼ö 
       SELECT * FROM (
         SELECT TO_CHAR(hireDate,'MM') ¿ùº°    
         FROM emp   
      ) PIVOT (
         COUNT(¿ùº°) FOR ¿ùº° IN (
         '01','02','03','04','05','06','07','08','09','10','11','12')
      );
  
 - ºÎ¼­º° Á÷À§±Þ¿©ÇÕ 
   pos °³¹ßºÎ ... È«º¸ºÎ 
   Á÷¿ø x x xx ..  
      SELECT * FROM (
        SELECT dept, pos, sal FROM emp
        GROUP BY dept, pos, sal
      ) PIVOT (
         SUM(sal) FOR dept IN (
            '°³¹ßºÎ' AS °³¹ßºÎ , '±âÈ¹ºÎ' AS ±âÈ¹ºÎ
           ,'¿µ¾÷ºÎ' AS ¿µ¾÷ºÎ , 'ÀÎ»çºÎ' AS ÀÎ»çºÎ
           ,'ÀÚÀçºÎ' AS ÀÚÀçºÎ , 'ÃÑ¹«ºÎ' AS ÃÑ¹«ºÎ
           ,'È«º¸ºÎ' AS È«º¸ºÎ
         )
       ) ORDER BY pos;
  
 - ³âµµ ¿ùº° ÆÇ¸ÅÇöÈ²(bPrice*qty ÇÕ)
    ³âµµ 1¿ù ... 12¿ù 
      SELECT ³âµµ, NVL("1¿ù",0) "1¿ù", NVL("2¿ù",0) "2¿ù", NVL("3¿ù",0) "3¿ù", NVL("4¿ù",0) "4¿ù",
                   NVL("5¿ù",0) "5¿ù", NVL("6¿ù",0) "6¿ù", NVL("7¿ù",0) "7¿ù", NVL("8¿ù",0) "8¿ù",
                   NVL("9¿ù",0) "9¿ù", NVL("10¿ù",0) "10¿ù", NVL("11¿ù",0) "11¿ù", NVL("12¿ù",0) "12¿ù"
     FROM ( 
        SELECT TO_CHAR(sDate,'YYYY') ³âµµ, TO_CHAR(sDate,'MM') ¿ùº°, bPrice*qty ÇÕ
        FROM book b 
        JOIN dsale d ON b.bCode = d.bCode 
        JOIN sale s ON d.sNum = s.sNum    
      ) PIVOT ( 
         SUM(ÇÕ) FOR ¿ùº° IN ( 
            '01' AS "1¿ù", '02' AS "2¿ù", '03' AS "3¿ù", '04' AS "4¿ù", '05' AS "5¿ù", '06' AS "6¿ù",
            '07' AS "7¿ù", '08' AS "8¿ù", '09' AS "9¿ù", '10' AS "10¿ù", '11' AS "11¿ù", '12' AS "12¿ù"
          )
        ) ORDER BY ³âµµ;
  
  - ¿äÀÏº° ÀÔ»çÀÎ¿ø   
      SELECT * FROM (
        SELECT TO_CHAR(hiredate,'DAY') ¿äÀÏ
        FROM emp 
      ) PIVOT (
         COUNT(¿äÀÏ) FOR ¿äÀÏ IN (
            '¿ù¿äÀÏ' ¿ù, 'È­¿äÀÏ' È­, '¼ö¿äÀÏ' ¼ö, '¸ñ¿äÀÏ' ¸ñ, '±Ý¿äÀÏ' ±Ý, 'Åä¿äÀÏ' Åä, 'ÀÏ¿äÀÏ' ÀÏ
            )
         );
  
  
3) UNPIVOT
-- ÇàÀ» ¿­·Î ¹Ù²Ù´Â °Í (COLUMN ÇüÅÂÀÇ µ¥ÀÌÅÍ¸¦ ROW ÇüÅÂ·Î)
-- ±â´ÉÀûÀ¸·Î PIVOT°ú ¹Ý´ëµÇ´Â °³³äÀÌÁö¸¸, PIVOTÀÇ °á°ú¸¦ µÇµ¹¸®´Â ±â´ÉÀº ¾Æ´Ï´Ù. 

     SELECT * FROM t_city
     UNPIVOT
     (
        ÀÎ¿ø¼ö 
        FOR buseo IN(°³¹ßºÎ, ±âÈ¹ºÎ, ¿µ¾÷ºÎ, ÀÎ»çºÎ, ÀÚÀçºÎ, ÃÑ¹«ºÎ, È«º¸ºÎ)
     );
     
     
4) Á¤±Ô½Ä (Regular Expression) 
-- ¹®ÀÚ¿­ µ¥ÀÌÅÍÀÇ °£´ÜÇÑ ÆÐÅÏ ¹× º¹ÀâÇÑ ÆÐÅÏÀ» °Ë»ö ÇÒ ¼ö ÀÖ´Â µµ±¸
 - Á¤±Ô½Ä ÆÐÅÏ 
         . | NULL À» Á¦¿ÜÇÑ ÀÓÀÇÀÇ ¹®ÀÚ¿Í ÀÏÄ¡     
         + | ÇÑ ¹ø ÀÌ»ó ÀÏÄ¡    
         ? | 0 or 1¹ø ÀÏÄ¡    
         * | 0¹ø ÀÌ»ó ÀÏÄ¡ 
       {m} | m¹ø ÀÏÄ¡     
     {m,n} | ÃÖ¼Ò m¹ø, ÃÖ´ë n¹ø ÀÏÄ¡ 
     [...] | °ýÈ£ ¾È ¹®ÀÚ¿Í ÀÏÄ¡ 
         ^ | ¹®ÀÚ¿­ ½ÃÀÛ ºÎºÐ°ú ÀÏÄ¡ ([ ] ¾È¿¡ ÀÖÀ¸¸é NOT ÀÇ ÀÇ¹Ì)
         $ | ¹®ÀÚ¿­ ³¡ ºÎºÐ°ú ÀÏÄ¡
        \d | ¼ýÀÚ  
 [:class:] | °ýÈ£ ¾È ¹®ÀÚ Å¬·¡½ºÀÇ ¿ä¼Ò¿Í ÀÏÄ¡ 
            [:alpha:] | ¾ËÆÄºª ¹®ÀÚ 
            [:digit:] | ¼ýÀÚ 
            [:lower:] | ¼Ò¹®ÀÚ 
            [:upper:] | ´ë¹®ÀÚ 
            [:alnum:] | ¾ËÆÄºª + ¼ýÀÚ 
            [:space:] | °ø¹é 
            [:punct:] | Æ¯¼ö ¹®ÀÚ 
            [:cntrl:] | ÄÁÆ®·Ñ ¹®ÀÚ
            [:print:] | Ãâ·Â °¡´ÉÇÑ ¹®ÀÚ 
        
 - REGEXP_LIKE : ÆÐÅÏÀÌ Æ÷ÇÔµÈ ¹®ÀÚ¿­ ¹ÝÈ¯ (LIKE¿Í À¯»ç) 
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[ÇÑ¹é]');       -- ^ : µÚÀÇ ¹®ÀÚ·Î ½ÃÀÛ
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '°­»ê$');         -- $ : ¾ÕÀÇ ¹®ÀÚ·Î ³¡
   
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'com$','i');    -- i : ´ë¼Ò¹®ÀÚ ±¸ºÐ ¾È ÇÔ 
    
    -- kimÀ» Æ÷ÇÔÇÏ´Â ·¹ÄÚµå
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim*');        
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim');
    
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim3?3'); 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[0-3]{2}');  -- 0~3 »çÀÌÀÇ ¹®ÀÚ°¡ 2¹øÀÌ»ó ¹Ýº¹µÇ´Â ·¹ÄÚµå 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[2-3]{3,4}'); -- 2~3 »çÀÌÀÇ ¹®ÀÚ°¡ ÃÖ¼Ò 3¹ø, ÃÖ´ë 4¹ø ¹Ýº¹µÇ´Â ·¹ÄÚµå
    
    SELECT * FROM reg WHERE REGEXP_LIKE(email, 'kim[^1]');      -- kim ´ÙÀ½¿¡ 1·Î ½ÃÀÛÇÏÁö ¾Ê´Â ·¹ÄÚµå 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[^1]$');        -- 1·Î ³¡³ªÁö ¾Ê´Â ·¹ÄÚµå
    
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[°¡-ÆR]{1,10}$');   -- ÀÌ¸§ÀÌ 1~10ÀÚ »çÀÌÀÌ°í ÇÑ±ÛÀÎ ·¹ÄÚµå
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '^[°¡-ÆR]{2,}$');     
    
    -- ÀÌ¸ÞÀÏ¿¡ ¼ýÀÚ°¡ Æ÷ÇÔµÈ ·¹ÄÚµå 
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[0-9]');   
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '[[:digit:]]');
    SELECT * FROM reg WHERE REGEXP_LIKE(email, '.*[[:digit:]].*');
    
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '[[:lower:]]');  -- ÀÌ¸§¿¡ ¼Ò¹®ÀÚ¸¸ ÀÖ´Â ·¹ÄÚµå 
    SELECT * FROM reg WHERE REGEXP_LIKE(name, '[a-z|A-Z]');    -- ¼Ò¹®ÀÚ or ´ë¹®ÀÚ ÀÖ´Â ·¹ÄÚµå

 - REGEXP_REPLACE : ´ëÃ¼ ¹®ÀÚ¿­·Î º¯°æ
    SELECT REGEXP_REPLACE('kim gil dong','(.*) (.*) (.*)','\3 \2 \1') FROM dual;
    
    SELECT email FROM reg;
    SELECT email, REGEXP_REPLACE(email, '(.*)@(.*)', '\1'),            -- @ ¾ÕºÎºÐ¸¸ Ãâ·Â
                  REGEXP_REPLACE(email, '(.*)@(.*)', '\2') FROM reg;   -- @ µÞºÎºÐ¸¸ Ãâ·Â 
    
    SELECT email, REGEXP_REPLACE(email,'arirang','¾Æ¸®¶û') FROM reg;              
 
    SELECT REGEXP_REPLACE('24jj$%^*^$$#@@$24', '[[:digit:]|[:punct:]]', '') FROM dual;  -- ¼ýÀÚ, Æ¯¼ö¹®ÀÚ ¾ø¾Ú 
    
    SELECT name, rrn, REGEXP_REPLACE(rrn,'[0-9|\-]', '*', 9) FROM emp;   -- 9¹øÂ°ºÎÅÍ *·Î º¯°æ
    
 - REGEXP_INSTR : ÆÐÅÏ ºñ±³¸¦ ÅëÇØ À§Ä¡ °ªÀ» È®ÀÎ
    SELECT email, REGEXP_INSTR(email, '[0-9]') FROM reg;  -- ¼ýÀÚ°¡ ÀÖ´Â °÷ÀÇ À§Ä¡ 
 
 - REGEXP_SUBSTR : ÆÐÅÏÀ» °Ë»öÇÏ¿© ºÎºÐ ¹®ÀÚ¿­ ÃßÃâ 
 
 - REGEXP_COUNT : ÆÐÅÏÀ» °Ë»öÇÏ¿© ¹ß°ß µÈ È½¼ö °è»ê
    SELECT email, REGEXP_COUNT(email, 'a') FROM reg;
     
        
        
        
*********************************** ¹®Á¦ 

SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation
ORDER BY checkIn ASC;

-- 20200724 ~ 20200729 ¿¹¾à µÈ ·ë. 0729¿¡ checkOut µÇ¸é 0729¿¡ checkIn °¡´É

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200724) AND TO_DATE(checkin) <= TO_DATE(20200729) OR 
       TO_DATE(checkout) > TO_DATE(20200724) AND TO_DATE(checkout) < TO_DATE(20200729); 
 
-- 20200727 ~ 20200728 ¿¹¾à µÈ ·ë.

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200727) AND TO_DATE(checkin) <= TO_DATE(20200728) OR 
       TO_DATE(checkout) > TO_DATE(20200727) AND TO_DATE(checkout) < TO_DATE(20200728); 


-- 20200730 ~ 20200801 ¿¹¾à µÈ ·ë.

 SELECT reservationNum, roomNum, checkIn, checkOut FROM roomReservation 
 WHERE TO_DATE(checkin)>=TO_DATE(20200730) AND TO_DATE(checkin) <= TO_DATE(20200801) OR 
       TO_DATE(checkout) > TO_DATE(20200730) AND TO_DATE(checkout) < TO_DATE(20200801); 
   