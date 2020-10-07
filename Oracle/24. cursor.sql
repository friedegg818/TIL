[Cursor] (Ŀ��)
 - ���� ���ڵ�� ������ �۾� �������� SQL���� �����ϰ�, �� ������ ���� ������ �����ϱ� ���� �׸� 
 - ����Ŭ ������ ���� ����Ǵ� ��� SQL���� ������ ������ Ŀ���� �����ϰ� �ִ�.
 
 1) �Ͻ��� Ŀ�� : ����Ŭ�̳� PL/SQL ���� ��Ŀ���� ���� SQL ������ ó�� �Ǵ� ���� ���� �͸��� �ּ� 
                 SQL���� ����Ǵ� ���� �ڵ� OPEN - CLOSE 
                 (SQL%ROWCOUNT / SQL%FOUND / SQL%NOTFOUND / SQL%ISOPEN)
                
            -- SQL%ROWCOUNT : �ش� SQL ���� ������ �޴� ���� �� 
                DECLARE 
                    vempNo emp.empNo%TYPE;
                    vcount NUMBER;
                BEGIN
                    vempNo := '8001';
                    DELETE FROM emp WHERE empNo = vempNo; 
                    vCount := SQL%ROWCOUNT;
                    COMMIT;
                    
                    DBMS_OUTPUT.PUT_LINE(vCount || '���ڵ� ����'); 
                    
                END;
                /
                
              -- SQL%NOTFOUND �� �ش� SQL���� ������ �޴� ���� ���� ���� ��� TRUE 
                DECLARE 
                    vempNo emp.empNo%TYPE;
                    vcount NUMBER;
                BEGIN
                    vempNo := '8001';
                    DELETE FROM emp WHERE empNo = vempNo; 
                    vCount := SQL%ROWCOUNT;
                    
                    IF SQL%NOTFOUND THEN 
                        RAISE_APPLICATION_ERROR(-20001, '����');
                    END IF;
                    
                    COMMIT;
                    
                    DBMS_OUTPUT.PUT_LINE(vCount || '���ڵ� ����'); 
                    
                END;
                /
               
           
 2) ����� Ŀ�� : ���α׷��ӿ� ���� ����Ǵ� �̸��� �ִ� Ŀ�� 
                * ���� | Ŀ�� ����(���� �����) > Ŀ�� OPEN (����) > FETCH (������ ��������) > Ŀ�� CLOSE 
                         
               -- ������ �߻��ϴ� ��Ȳ 
                DECLARE
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                BEGIN
                    SELECT name, sal INTO vname, vsal FROM emp    -- ���� : �������� ���� �ʹ� ���� 
                    DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal);
                END;
                /
                
               -- ����� Ŀ�� �̿� 
                DECLARE
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                - 1.Ŀ�� ����
                   CURSOR cur_emp IS SELECT name, sal FROM emp;   -- cursor ���� INTO ���� ����.
                BEGIN
                - 2.Ŀ�� OPEN
                   OPEN cur_emp; 
                   
                   LOOP 
                     - 3.FETCH 
                        FETCH cur_emp INTO vname, vsal;
                        EXIT WHEN cur_emp%NOTFOUND;
                        DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal); 
                   END LOOP; 
                   
                - 4.Ŀ�� CLOSE
                   CLOSE cur_emp;   
                END;
                /
                
               -- �Ķ���Ͱ� �ִ� Ŀ�� (�̸����� ���ڸ� �Է��Ͽ� ���)
                CREATE OR REPLACE PROCEDURE pEmpSelect 
                (
                    pName VARCHAR2 
                )
                IS
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                    
                    CURSOR cur_emp(cname emp.name%TYPE) IS 
                        SELECT name, sal FROM emp 
                        WHERE INSTR(name, cname) > 0;    
                BEGIN
                    OPEN cur_emp(pName); 
                    LOOP 
                       FETCH cur_emp INTO vname, vsal;
                       EXIT WHEN cur_emp%NOTFOUND;
                       DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal); 
                    END LOOP; 
                                   
                   CLOSE cur_emp;   
                END;
                /
                
                EXEC pEmpSelect('��');

              -- �Ķ���� ������� �ʰ� ���� �˻� (�̸����� ���� �Է��Ͽ� ���) 
                CREATE OR REPLACE PROCEDURE pEmpSelect 
                (
                    pName VARCHAR2 
                )
                IS
                    vname emp.name%TYPE;
                    vsal emp.sal%TYPE;
                    
                    CURSOR cur_emp IS 
                        SELECT name, sal FROM emp 
                        WHERE INSTR(name, pname) = 1;    
                BEGIN
                    OPEN cur_emp; 
                    LOOP 
                       FETCH cur_emp INTO vname, vsal;
                       EXIT WHEN cur_emp%NOTFOUND;
                       DBMS_OUTPUT.PUT_LINE(vname || ':' || vsal); 
                    END LOOP; 
                                   
                   CLOSE cur_emp;   
                END;
                /
                
                EXEC pEmpSelect('��');
                
              -- Ŀ�� FOR LOOP : �ڵ� OPEN - CLOSE / ���� ���ָ� �� 
                CREATE OR REPLACE PROCEDURE pEmpSelect
                IS
                    CURSOR cur_emp IS 
                        SELECT name, sal FROM emp;
                BEGIN
                    FOR rec IN cur_emp LOOP
                        DBMS_OUTPUT.PUT_LINE(rec.name || ':' || rec.sal);
                    END LOOP;
                END;
                /
                
           -- WHERE CURRENT OF : FETCH���� ���� ���� �ֱٿ� ó���� ���� ����
              CREATE TABLE  emp1  AS  SELECT * FROM  emp;
        
              CREATE OR REPLACE  PROCEDURE pEmpUpdateSeoul
              IS
                 vCnt   NUMBER;
                 vName  emp1.name%TYPE;
                 vSal   emp1.sal%TYPE;
                 CURSOR  cur_emp  IS
                     SELECT  name, sal  FROM  emp1  WHERE city='����'  FOR  UPDATE; 
                            -- FOR  UPDATE : Ŀ���� �̿��Ͽ� UPDATE�� ��� �ݵ�� �ʿ�
              BEGIN
                  vCnt := 0;
            
                  OPEN  cur_emp;
                  LOOP
                      FETCH  cur_emp INTO  vname, vsal;
                      UPDATE emp1 SET sal = TRUNC(sal * 1.1) 
                      WHERE CURRENT OF cur_emp;    -- Ŀ���� ���� ��ġ�� �� 
                      EXIT WHEN  cur_emp%NOTFOUND; -- ������ �����͸� ó���Ҷ� ���ܰ� �߻���
                      vCnt := vCnt + 1;
                      DBMS_OUTPUT.PUT_LINE(vCnt || ':' || vname || ':' || vsal);
                  END LOOP;
                  -- ���ܰ� �߻��Ͽ� ���� ���ϰ� EXCEPTION �� ����
                  COMMIT;
                  CLOSE cur_emp;
            
                  EXCEPTION  WHEN  OTHERS THEN   -- ��Ÿ ���ܰ� �߻��ص� Ŀ�� (try~catch�� ����)
                      COMMIT;
                      DBMS_OUTPUT.PUT_LINE('���� �Ϸ� !!!');
              END;
              /
              
              EXEC pEmpUpdateSeoul;
              
3) Ŀ�� ����
 - ����� ����� ���� �� �� �ִ� �� 
 - REF CURSOR Ŀ�� Ÿ�� 
    > ���� Ŀ�� Ÿ��(�� �ٸ� ���� ����) 
       TYPE refcur_emp IS REF CURSOR RETURN emp%ROWTYPE;     
    > ���� Ŀ�� Ÿ�� (�������� ��� ����, �����̵��� ���� �� ����, ������ ���� ����)
       TYPE refcur IS REF CURSOR;       
 - SYS_REFCURSOR : ��ǥ���� ���� Ŀ�� Ÿ��. ���µ� �ڷ����� ���� �� ���� (2�� �̻� ���� ����) 
 
  -- SYS_REFCURSOR ����Ͽ� ���ν��� ���� 
         CREATE OR REPLACE PROCEDURE pEmpSelectList
         (
            pName IN VARCHAR2, 
            pResult OUT SYS_REFCURSOR    -- ����� pResult�� ���Ƿ� OUT ��� 
         )
         IS 
         BEGIN
            OPEN pResult FOR
                SELECT name, sal FROM emp 
                WHERE INSTR(name, pName) > 0; 
         END;
         /
 
  -- ����� �۵� �ϴ��� Ȯ�� 
         CREATE OR REPLACE PROCEDURE pEmpSelectResult
         (
            pName IN VARCHAR2
         )
         IS
            vname   emp.name%TYPE;
            vsal    emp.sal%TYPE;
            vResult SYS_REFCURSOR;
         BEGIN
            pEmpSelectList(pName, vResult); 
            
            LOOP 
                FETCH vResult INTO vname, vsal; 
                EXIT WHEN vResult%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(vName || ':' || vsal);
            END LOOP;
         END;
         /
 
         EXEC pEmpSelectResult('��');
         

[���� ����] Dynamic SQL
 - ���ν��� ��� �ؽ�Ʈ ������ �Է� �޾� �������� ������ ���� 
 - EXECUTE IMMEDIATE 
    - ���̺� �ۼ� �� ������ �ۼ� ���� �ο� 
      -- ������ ���� 
      GRANT CREATE TABLE TO sky;
      GRANT CREATE SEQUENCE TO sky;
      -- sky ���� (������ �ý��� ���� Ȯ��)
      SELECT * FROM user_sys_privs;

    CREATE OR REPLACE PROCEDURE pBoardCreate
    (
        pName VARCHAR2 
    )
    IS 
        s VARCHAR2(1000);
    BEGIN
        s := 'CREATE TABLE ' || pName;
        s := s || '(num NUMBER PRIMARY KEY';
        s := s || ', name VARCHAR2(30) NOT NULL';
        s := s || ', subject VARCHAR2(200) NOT NULL';
        s := s || ', content VARCHAR2(4000) NOT NULL';
        s := s || ', hitCount NUMBER DEFAULT 0';
        s := s || ', created DATE DEFAULT SYSDATE)';   
        
        FOR t IN (SELECT tname FROM tab WHERE tname = UPPER(pName)) LOOP 
            EXECUTE IMMEDIATE 'DROP TABLE ' || pName || ' PURGE'; 
            DBMS_OUTPUT.PUT_LINE(pName || ' ���̺� ����...'); 
            EXIT;
        END LOOP;
        
        EXECUTE IMMEDIATE s;     -- ���� ���� ����. ���̺� ����. 
        
        FOR i IN (SELECT sequence_name FROM seq WHERE sequence_name=UPPER(pName||'_seq')) LOOP 
            EXECUTE IMMEDIATE 'DROP SEQUENCE ' || pName || '_seq';
            DBMS_OUTPUT.PUT_LINE(pName || '_seq ������ ����...'); 
            EXIT;
        END LOOP; 
        
        EXECUTE IMMEDIATE 'CREATE SEQUENCE ' || pName || '_seq';    -- ������ ����.
        
        DBMS_OUTPUT.PUT_LINE('���̺� �� ������ �ۼ� ����...');    
    END;
    /
    
    SELECT * FROM tab;
    SELECT * FROM seq;
    
    EXEC pBoardCreate('board');
        