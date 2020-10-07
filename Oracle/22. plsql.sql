[PL/SQL]
 - ���α׷��־���� Ư���� ������ SQL�� Ȯ�� 
 - ������ ���۰� ���� ������ PL/SQL�� ������ �ڵ� �ȿ� ���� �ȴ�.
 - �ַ� �ڷ� ���ο��� SQL ��ɹ������� ó���ϱ⿡ ������ �ڷ��� �����̳� ���ν���, Ʈ���� ���� �ۼ��ϴµ� ���� 
 
 1) PL/SQL ���α׷��� ���� 
   - PL/SQL �͸� ���, �Լ�, ���ν���, ��Ű��, Ʈ���� 
 
 2) DBMS_OUTPUT ��Ű�� 
   - SQL Plus �Ǵ� SQL*DBA ���� ��� 
   - DBMS_OUTPUT.PUT_LINE : ���� �������� �����ϴ� ���� ������ ���� 
   - DBMS_OUTPUT.PUT : ���ڿ��� ��ġ, NEW_LINE ���ν����� �־�� ����� �����ϴ�.
   - DBMS_OUTPUT.NEW_LINE : ���� �������� �߰� 
   - DBMS_OUTPUT.GET_LINE : �ؽ�Ʈ�� ������ �����´�. �����ϸ� 1, �׷��� ������ 0 
   
 3) PL/SQL �ڷ��� 
   - �ֿ� �ڷ��� (VARCHAR2, CHAR, LONG, LOB / NUMBER, PLS_INTEGER, BINARY_DOUBLE / DATE / BOOLEAN )
   - RECORD ���� : �پ��� ������ ������ ���� ���� �� �� �ִ� ���� ����
     > ���̺� ���� ������ �Ǵ� Ư�� �÷��� �����ϴµ� ���� 
   
 4) ��� ���� 
    - �� ������ ���� �� ������ ; ��� 
    - END �ڿ� ; ����Ͽ� ��� ���� 
    - �࿡ / �� ������ ����� 
   ---------------------------------------------------------
    DECLARE            [�����| ������, ���� ����]
    BEGIN              [�����| �ʼ���, ���� ����]
      [EXCEPTION]      [����ó����| ������] 
    END;
    / 
   ---------------------------------------------------------

   - sqlplus : DBMS_OUTPUT ��� Ȯ��
	 SET SERVEROUTPUT ON
	 
   - %TYPE : ���̺��� ���� �÷��� ������ ���� ����
   
	 DECLARE
	    vname  emp.name%TYPE;
		vpay   NUMBER;
	 BEGIN
        SELECT name, sal+bonus INTO vname, vpay     -- PL/SQL�� SELECT ������ INTO ���� �ʿ� 
                                                    -- INTO �� + ��ȸ�� �����͸� ������ ���� (1:1 ��ġ�ؾ� ��)
        FROM emp  WHERE  empNo = '1001';
		
		DBMS_OUTPUT.PUT_LINE('�̸� : ' || vname);
		DBMS_OUTPUT.PUT_LINE('�޿� : ' || vpay);
	 END;
     /	 

    - %ROWTYPE : ���̺��� ���� �����ϴ� ���ڵ� ����
	 DECLARE
	    vrec  emp%ROWTYPE;
	 BEGIN
        -- SELECT name, sal INTO vrec.name, vrec.sal
          -- FROM emp  WHERE  empNo = '1001';	
		SELECT * INTO vrec FROM  emp  WHERE  empNo = '1001';
		
		DBMS_OUTPUT.PUT_LINE('�̸� : ' || vrec.name);
		DBMS_OUTPUT.PUT_LINE('�޿� : ' || vrec.sal);
	 END;
     /
	 
	 -- ����� ���� ���ڵ�
	 DECLARE
	    TYPE  mytype IS RECORD
		(
		    name  emp.name%TYPE
			,sal  emp.sal%TYPE
		);
	    vrec  MYTYPE;
	 BEGIN
        SELECT name, sal INTO vrec.name, vrec.sal
        FROM emp  WHERE  empNo = '1001';
	
		DBMS_OUTPUT.PUT_LINE('�̸� : ' || vrec.name);
		DBMS_OUTPUT.PUT_LINE('�޿� : ' || vrec.sal);
	 END;
     /


 5) ���� ����
  <���� ����> 
   - IF
   
	 DECLARE
	    a NUMBER  := 10;
	 BEGIN
	    IF MOD(a, 6) = 0 THEN
		    DBMS_OUTPUT.PUT_LINE(a || '2 �Ǵ� 3�� ���');
		ELSIF MOD(a, 3) = 0 THEN
		    DBMS_OUTPUT.PUT_LINE(a || '3�� ���');
		ELSIF MOD(a, 2) = 0 THEN
		    DBMS_OUTPUT.PUT_LINE(a || '2�� ���');
        ELSE
		    DBMS_OUTPUT.PUT_LINE(a || '2 �Ǵ� 3�� ����� �ƴ�');
        END IF;
	 END;
	 /
	 
	 -- emp ���̺� : empNo�� 1001�� ���ڵ�
	   -- �̸�(name), �޿�(sal+bonus), ���� ���
	   -- ������  sal+bonus�� 300�� �̻� 3%, 200�� �̻� 2%, ������ 0
	   -- �Ҽ��� ù°�ڸ� �ݿø�
	 DECLARE
	    vname VARCHAR2(30);
		vpay  NUMBER;
		vtax  NUMBER;
	 BEGIN
        SELECT name, sal+bonus INTO vname, vpay
        FROM emp  WHERE  empNo = '1001';
		
		IF vpay >= 3000000 THEN
		   vtax := ROUND(vpay * 0.03);
		ELSIF vpay >= 2000000 THEN
		   vtax := ROUND(vpay * 0.02);
		ELSE
           vtax := 0;		
	    END IF;
		
		DBMS_OUTPUT.PUT_LINE('�̸�: ' || vname);
		DBMS_OUTPUT.PUT_LINE('�޿�: ' || vpay || ', ����: ' || vtax);      -- ���ڿ��� ��µ� 
	 END;
     /
	 
	 
	 
     -------------------------------------------------------
   - CASE


     -------------------------------------------------------
   <�ݺ� ����> 
   - basic LOOP
    - ���� �ݺ��Ǵ� LOOP ����
    - EXIT �� ������ ���� ���� 
    - CONTINUE �� ������ ���� �ݺ��� �Ϸ�ǰ�, ���� �ݺ����� ���޵� 
     
    DECLARE 
        n NUMBER := 0;
        s NUMBER := 0;
    BEGIN 
        LOOP 
            n := n + 1;
            s := s + n;
            EXIT WHEN n = 100;  -- ���������� ���� 
        END LOOP;               -- ���ѷ��� 
        
        DBMS_OUTPUT.PUT_LINE('���:'||s);
    END;
    /

     -------------------------------------------------------
   - WHILE-LOOP
    
    DECLARE 
        n NUMBER := 0;
        s NUMBER := 0;
    BEGIN 
       WHILE n < 100 LOOP
            n := n + 1;
            s := s + n;           
        END LOOP;        
        
        DBMS_OUTPUT.PUT_LINE('���:'||s);
    END;
    /
    
    --- Ȧ�� ��  
    DECLARE 
        n NUMBER := 1;
        s NUMBER := 0;
    BEGIN 
       WHILE n < 100 LOOP
            s := s + n;
            n := n + 2;                      
        END LOOP;        
        
        DBMS_OUTPUT.PUT_LINE('���:'||s);
    END;
    /
    
    DECLARE 
        a NUMBER;
        b NUMBER;
    BEGIN
        a := 1;
        WHILE a<9 LOOP
            a := a+1;
            DBMS_OUTPUT.PUT_LINE('**'||a||' �� **');
            b := b+1;
                DBMS_OUTPUT.PUT_LINE(a||'*'||b||'='||(a*b));
            END LOOP;
        END LOOP;
    END;
    /
     -------------------------------------------------------
     -- FOR-LOOP  ������ 1���� ����/���� / SELECT ���� ����ϸ� ���� / 
     -- FOR �ݺ� ������ �������� �ʴ´�. �ڵ� ����� 
    DECLARE 
        s NUMBER := 0;
    BEGIN 
        FOR n IN 1 .. 100 LOOP 
            s := s + n;
        END LOOP;
        DBMS_OUTPUT.PUT_LINE('���:'||s);
    END;
    /
    
    DECLARE 
        s NUMBER := 0;
    BEGIN 
        FOR n IN REVERSE 65 .. 90 LOOP     -- REVERSE : �Ųٷ� ���� (���� ���ڴ� ������� ��� ��) 
            DBMS_OUTPUT.PUT_LINE(CHR(n));  -- ��� �� ���� �ȳѱ� 
                                           -- PUT_LINE(), NEW_LINE() �� ������ ���
        END LOOP;
        DBMS_OUTPUT.NEW_LINE(); -- ���� �ѱ�
    END;
    /    


     -------------------------------------------------------
     -- SQL Cursor FOR LOOP
     
     DECLARE
	    vrec  emp%ROWTYPE;
	 BEGIN       
		SELECT * INTO vrec FROM  emp; -- ���� : �������̹Ƿ� 
		DBMS_OUTPUT.PUT_LINE('�̸� : ' || vrec.name);
		DBMS_OUTPUT.PUT_LINE('�޿� : ' || vrec.sal);
	 END;
     /
     
     DECLARE 
     BEGIN
        FOR rec IN (SELECT empNo, name, sal FROM emp) LOOP
            DBMS_OUTPUT.PUT_LINE(rec.name || '    ' || rec.sal);
        END LOOP; 
     END;
     /