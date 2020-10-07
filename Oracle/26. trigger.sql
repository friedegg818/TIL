[TRIGGER]
 - �̸� ���� ���� Ư�� ������ �����ϰų�, � ������ �ϸ� �ڵ����� ����ǵ��� ������ �� 
 - Ʈ���� ���� ������ �� �� �ִ� �� 
    1. DML - DELETE, INSERT, UPDATE
    2. DDL - CREATE, ALTER, DROP
    3. DB �۾� - SERVERERROR, LOGON, LOGOFF, STARTUP, SHUTDOWN
 - ���� (DML Ʈ����, INSTEAD OF Ʈ����, �ý��� Ʈ����)
 - Ʈ���� ���� ���� �ο� 
   GRANT CREATE TRIGGER TO �����;    


 1) ���� Ʈ���� - DML ���� ���� Ƚ���� ��� ���� Ʈ���Ŵ� 1���� ���� 
 
    CREATE TABLE ex (
        num NUMBER PRIMARY KEY
        , name VARCHAR2(30) NOT NULL
    );
    
    CREATE TABLE ex_time(
        memo VARCHAR2(100)
        , created DATE DEFAULT SYSDATE
    );

    -- ���� Ʈ���� ����
    CREATE OR REPLACE TRIGGER tri_Ex 
    AFTER INSERT OR UPDATE OR DELETE ON ex 
    BEGIN
        IF INSERTING THEN 
            INSERT INTO ex_time(memo) VALUES('�߰�');
        ELSIF UPDATING THEN 
            INSERT INTO ex_time(memo) VALUES('����');
        ELSIF DELETING THEN 
            INSERT INTO ex_time(memo) VALUES('����');
        END IF; 
          -- Ʈ���� �ȿ��� INSERT, DELETE, UPDATE�� �ڵ� COMMIT �ǹǷ� COMMIT ���� ������� �ʴ´�.
    END;
    / 
    
    -- Ʈ���� ���� Ȯ��    
    SELECT * FROM user_triggers; -- ��� Ȯ��
    SELECT * FROM user_source;   -- �ҽ� Ȯ��
    
    -- DML�� ���� 
    INSERT INTO ex VALUES(1,'a');
    INSERT INTO ex VALUES(2,'b');
    COMMIT;
    
    UPDATE ex SET name = 'aa' WHERE num=1;
    COMMIT;

    DELETE FROM ex;  -- 2�� ���� 
    COMMIT;
    
    SELECT * FROM ex_time;  -- ������ 2�� ���� �Ǿ Ʈ���Ŵ� 1���� ����� 
    
    -- �����ð��� ������ �۾��� ���� ���ϵ���
    CREATE OR REPLACE TRIGGER tri_Ex2
    AFTER INSERT OR UPDATE OR DELETE ON ex
    BEGIN
        IF TO_CHAR(SYSDATE,'D') IN (1, 7) OR
           ( TO_CHAR(SYSDATE, 'HH24') >= 15 AND TO_CHAR(SYSDATE,'HH24') <= 16) THEN 
         RAISE_APPLICATION_ERROR(-20001, '������ ���� ����...'); 
        END IF;
   END;
   /
   
   INSERT INTO ex VALUES(1,'a');
   COMMIT;
   SELECT * FROM ex;
    
    
 2) �� Ʈ���� - DML ���� ���� Ƚ��(��)��ŭ Ʈ���� ���� 
               ex) 10���� ���� �����Ǹ� Ʈ���ŵ� 10�� ���� 

    CREATE TABLE score1 (
        hak VARCHAR2(20) PRIMARY KEY 
        , name VARCHAR2(30) NOT NULL
        , kor NUMBER(3) NOT NULL
        , eng NUMBER(3) NOT NULL
        , mat NUMBER(3) NOT NULL 
    );
    
    CREATE TABLE score2 (
        hak VARCHAR2(20) PRIMARY KEY 
        , kor NUMBER(2,1) NOT NULL
        , eng NUMBER(2,1) NOT NULL
        , mat NUMBER(2,1) NOT NULL 
        , FOREIGN KEY(hak) REFERENCES score1(hak)
    );

    CREATE OR REPLACE FUNCTION fnGrade ( 
        pScore NUMBER 
    )
    RETURN NUMBER 
    IS 
        n NUMBER(2,1);
    BEGIN 
        IF pScore>=95 THEN n:=4.5;
        ELSIF pScore>=90 THEN n:=4.0;
        ELSIF pScore>=85 THEN n:=3.5;
        ELSIF pScore>=80 THEN n:=3.0;
        ELSIF pScore>=75 THEN n:=2.5;
        ELSIF pScore>=70 THEN n:=2.0;
        ELSIF pScore>=65 THEN n:=1.5;
        ELSIF pScore>=60 THEN n:=1.0;
        ELSE n:=0.0;
        END IF;
        
        RETURN n; 
    END;
    /
    
    SELECT fnGrade(90) FROM dual;
    
    -- �� Ʈ���� ����(INSERT)
    CREATE OR REPLACE TRIGGER tri_scoreInsert 
    AFTER INSERT ON score1 
    FOR EACH ROW           -- �� Ʈ���� 
    DECLARE 
    BEGIN
      -- :NEW -> insert�� �� ���� (��Ʈ���Ÿ� ��� ����) 
      INSERT INTO score2(hak, kor, eng, mat) VALUES (
            :NEW.hak, fnGrade(:NEW.kor), fnGrade(:NEW.eng), fnGrade(:NEW.mat)
            );
    END;
    /
    
    -- DML�� ����
    INSERT INTO score1 VALUES('1', 'aaa', 90, 85, 70);
    INSERT INTO score1 VALUES('2', 'bbb', 85, 60, 77);
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;
    
    -- �� Ʈ���� ���� (UPDATE)
    CREATE OR REPLACE TRIGGER tri_scoreUpdate
    AFTER UPDATE ON score1 
    FOR EACH ROW         
    DECLARE 
    BEGIN
      -- :OLD -> update �ϱ� �� �� ���� (��Ʈ���Ÿ� ��� ����)
      -- :NEW -> ���� update �� �� ���� (��Ʈ���Ÿ� ��� ����)
      UPDATE score2 SET kor = fnGrade(:NEW.kor), eng = fnGrade(:NEW.eng), mat = fnGrade(:NEW.mat)
            WHERE hak = :OLD.hak;
    END;
    /
    
    UPDATE score1 SET kor = 100 WHERE hak ='2';
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;
    
    -- �� Ʈ���� ���� (DELETE) 
    CREATE OR REPLACE TRIGGER tri_scoreDelete
    BEFORE DELETE ON score1      -- score2�� �����Ͱ� ������ score1�� ���� �� �� �����Ƿ� 
    FOR EACH ROW         
    DECLARE 
    BEGIN
      -- :OLD -> delete �� �� ���� (��Ʈ���Ÿ� ��� ����)
      DELETE FROM score2 WHERE hak = :OLD.hak; 
    END;
    /
    
    DELETE FROM score1; 
    COMMIT;
    
    SELECT * FROM score1;
    SELECT * FROM score2;
    
 3) Ʈ���� ���� 
    
    ALTER TRIGGER Ʈ���� �̸� ENABLE | DISABLE; 
    
    ALTER TABLE ���̺�� ENABLE | DISABLE ALL TRIGGERS;
    
    SELECT ���̺�� FROM user_triggers; 
    
 
 * Ʈ���� �ǽ� 
  1. ���̺� �ۼ� 
   
 -- ��ǰ ���̺�
     CREATE TABLE ��ǰ (
       ��ǰ�ڵ�    VARCHAR2(6) NOT NULL PRIMARY KEY
      ,��ǰ��      VARCHAR2(30)  NOT NULL
      ,������      VARCHAR2(30)  NOT NULL
      ,�Һ��ڰ���  NUMBER
      ,������    NUMBER DEFAULT 0
    );

 -- �԰� ���̺�
    CREATE TABLE �԰� (
       �԰��ȣ   NUMBER PRIMARY KEY
      ,��ǰ�ڵ�   VARCHAR2(6) NOT NULL
                      CONSTRAINT fk_ibgo_no REFERENCES ��ǰ(��ǰ�ڵ�)
      ,�԰�����   DATE
      ,�԰����   NUMBER
      ,�԰�ܰ�   NUMBER
    );

 -- �Ǹ� ���̺�
    CREATE TABLE �Ǹ� (
       �ǸŹ�ȣ   NUMBER  PRIMARY KEY
      ,��ǰ�ڵ�   VARCHAR2(6) NOT NULL
            CONSTRAINT fk_pan_no REFERENCES ��ǰ(��ǰ�ڵ�)
      ,�Ǹ�����   DATE
      ,�Ǹż���   NUMBER
      ,�ǸŴܰ�   NUMBER
    );

 -- ��ǰ ���̺� �ڷ� �߰�
    INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
            ('AAAAAA', '��ī', '���', 100000);
    INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
            ('BBBBBB', '��ǻ��', '����', 1500000);
    INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
            ('CCCCCC', '�����', '���', 600000);
    INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
            ('DDDDDD', '�ڵ���', '�ٿ�', 500000);
    INSERT INTO ��ǰ(��ǰ�ڵ�, ��ǰ��, ������, �Һ��ڰ���) VALUES
             ('EEEEEE', '������', '���', 200000);
    COMMIT;
    
   2. Ʈ���� �ۼ� 
    
    <�԰� ���̺�>     
  -- INSERT Ʈ���� (�԰� ���̺� �ڷᰡ �߰� �Ǵ� ���, ��ǰ ���̺��� �������� ���� �ǵ���)
      CREATE OR REPLACE TRIGGER insTrg_lpgo
      AFTER INSERT ON �԰� 
      FOR EACH ROW 
      BEGIN
         UPDATE ��ǰ SET ������ = ������ + :NEW.�԰���� WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
      END;
      /

 -- �԰� ���̺� ������ �Է�
        INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
                      VALUES (1, 'AAAAAA', '2004-10-10', 5,   50000);
        INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
                      VALUES (2, 'BBBBBB', '2004-10-10', 15, 700000);
        INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
                      VALUES (3, 'AAAAAA', '2004-10-11', 15, 52000);
        INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
                      VALUES (4, 'CCCCCC', '2004-10-14', 15,  250000);
        INSERT INTO �԰� (�԰��ȣ, ��ǰ�ڵ�, �԰�����, �԰����, �԰�ܰ�)
                      VALUES (5, 'BBBBBB', '2004-10-16', 25, 700000);
        COMMIT;  
      
      SELECT * FROM ��ǰ;
      SELECT * FROM �԰�;

 -- UPDATE Ʈ���� (�԰� ���̺��� �ڷᰡ ���� �Ǵ� ���, ��ǰ ���̺��� �������� ����)
        CREATE OR REPLACE TRIGGER uptTrg_lpgo
        AFTER UPDATE ON �԰� 
        FOR EACH ROW 
        BEGIN 
            UPDATE ��ǰ SET ������ = ������ - :OLD.�԰���� + :NEW.�԰���� WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        END;
        /
        
        UPDATE �԰� SET �԰���� = 30 WHERE �԰��ȣ = 5;
        COMMIT;
        
        SELECT * FROM ��ǰ;
        SELECT * FROM �԰�;

 -- DELETE Ʈ���� (�԰� ���̺��� �ڷᰡ �����Ǵ� ���, ��ǰ ���̺��� �������� ����)
    CREATE OR REPLACE TRIGGER delTrg_lpgo
    AFTER DELETE ON �԰� 
    FOR EACH ROW 
    BEGIN
        UPDATE ��ǰ SET ������ = ������ - :OLD.�԰���� WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END;
    /
    
    DELETE FROM �԰� WHERE �԰��ȣ = 5;
    COMMIT;
    SELECT * FROM ��ǰ;
    SELECT * FROM �԰�;

   <�Ǹ� ���̺�>
 -- INSERT Ʈ���� (�Ǹ� ���̺� �ڷᰡ �߰��Ǵ� ��� ��ǰ ���̺��� �������� ����)
    CREATE OR REPLACE TRIGGER insTrg_Pan
    BEFORE INSERT ON �Ǹ� 
    FOR EACH ROW 
    
    DECLARE 
        j_qty NUMBER;
    BEGIN 
        SELECT ������ INTO j_qty FROM ��ǰ WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�; 
        IF :NEW.�Ǹż��� > j_qty THEN 
            RAISE_APPLICATION_ERROR(-20007, '�Ǹ� ����');
        ELSE
            UPDATE ��ǰ SET ������ = ������ - :NEW.�Ǹż��� WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        END IF;
    END;
    /

    INSERT INTO �Ǹ� (�ǸŹ�ȣ, ��ǰ�ڵ�, �Ǹ�����, �Ǹż���, �ǸŴܰ�) VALUES
             (1, 'AAAAAA', '2004-11-10', 5, 1000000);
    COMMIT;
    SELECT * FROM ��ǰ;
    SELECT * FROM �Ǹ�;
    
    INSERT INTO �Ǹ� (�ǸŹ�ȣ, ��ǰ�ڵ�, �Ǹ�����, �Ǹż���, �ǸŴܰ�) VALUES
             (1, 'AAAAAA', '2004-11-10', 50, 1000000);

 -- UPDATE Ʈ���� (�Ǹ� ���̺��� �ڷᰡ ����Ǵ� ��� ��ǰ ���̺��� �������� ����ǵ���)
    CREATE OR REPLACE TRIGGER uptTrg_Pan
    BEFORE UPDATE ON �Ǹ�
    FOR EACH ROW
    
    DECLARE 
        j_qty NUMBER;
    BEGIN
        SELECT ������ INTO j_qty FROM ��ǰ WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�; 
        IF :NEW.�Ǹż��� > (j_qty + :OLD.�Ǹż���) THEN 
            RAISE_APPLICATION_ERROR(-20007, '�Ǹŷ��� ��� ���� �����ϴ�.');
        ELSE
            UPDATE ��ǰ SET ������ = ������ + :OLD.�Ǹż��� - :NEW.�Ǹż��� WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
        END IF;
    END;
    /

    UPDATE �Ǹ� SET �Ǹż��� = 200 WHERE �ǸŹ�ȣ = 1;
    UPDATE �Ǹ� SET �Ǹż��� = 10 WHERE �ǸŹ�ȣ = 1;
    COMMIT;
    SELECT * FROM ��ǰ;
    SELECT * FROM �Ǹ�;


 -- DELETE Ʈ���� (�Ǹ� ���̺� �ڷᰡ �����Ǵ� ��� ��ǰ ���̺��� �������� ����)
    CREATE OR REPLACE TRIGGER delTrg_Pan
    AFTER DELETE ON �Ǹ� 
    FOR EACH ROW 
    
    BEGIN
       UPDATE ��ǰ SET ������ = ������ + :OLD.�Ǹż��� WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;   
    END;
    /
    -- DELETE �׽�Ʈ
    DELETE �Ǹ� WHERE �ǸŹ�ȣ = 1;
    COMMIT;
    
    SELECT * FROM ��ǰ;
    SELECT * FROM �Ǹ�;

** �ϳ��� Ʈ���ŷ� �ۼ�
CREATE OR REPLACE TRIGGER Trg_IN
AFTER INSERT OR UPDATE OR DELETE ON �԰� 
FOR EACH ROW

BEGIN 
    IF INSERTING THEN 
        UPDATE ��ǰ SET ������ = ������ + :NEW.�԰���� WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;        
    ELSIF UPDATING THEN
        UPDATE ��ǰ SET ������ = ������ - :OLD.�԰���� + :NEW.�԰���� WHERE ��ǰ�ڵ� = :NEW.��ǰ�ڵ�;
    ELSIF DELETING THEN 
        UPDATE ��ǰ SET ������ = ������ - :OLD.�԰���� WHERE ��ǰ�ڵ� = :OLD.��ǰ�ڵ�;
    END IF;
END;


[Package]
 - ����Ŭ�� ����� ���� ���� �ִ� PL/SQL ���ν���, �Լ�, Ÿ�� ���� �������� ���� ���� ���� 
 - ����� + ����(������) 
 - ��Ű�� �������� ���ν����� �Լ��� �����ε��� ���� 
 - ��Ű�� ��� Ȯ�� 
   SELECT * FROM user_objects WHERE object_type = 'PACKAGE'; 
   SELECT * FROM user_objects WHERE object_type = 'PACKAGE_BODY'; 
   SELECT * FROM user_procedures WHERE object_type = 'PACKAGE';  -- ��Ű�� ���� ���ν���, �Լ� ���
   
 1) ��Ű�� ���� 
  - ����� | ��Ű���� ���Ե� PL/SQL ���ν���, �Լ�, Ŀ��, ����, ������ ���� (��Ű�� ��ü�� �����)
   * ���� 
    CREATE OR REPLACE PACKAGE ��Ű���� IS
        [���� ������] 
        [Ŀ�� ������]
        [���� ������]
        [�Լ� ������]       FUNCTION �Լ���(�μ�) RETURN ����Ÿ��;
        [���ν��� ������]    PROCEDURE ���ν�����(�μ�); 
    END ��Ű����; 
    
  - ������ | ��Ű������ ����� ���ν����� �Լ��� ��ü ���� 
   * ����
    CREATE OR REPLACE PACKAGE BODY ��Ű���� IS
        [�Լ� ����]
           FUNCTION �Լ���(�μ�) 
           RETURN ����Ÿ��
           IS ���� ���� 
           BEGIN �Լ� ��ü ����
           RETURN ���ϰ�; 
           END;
        [���ν��� ����]
           PROCEDURE ���ν�����(�μ�)
           IS ��������
           BEGIN ���ν��� ��ü ����
           END;
    END ��Ű����;
   
 2) ��Ű�� �� ���ν��� OR �Լ� ���� 
    EXEC ��Ű����.���ν�����(�μ�); 
    
 3) ��Ű�� ���� 
    DROP PACKAGE ��Ű����;  -- ����ο� ��ü ����
    DROP PACKAGE BODY ��Ű����; -- ��ü ����
    
   -----------------------------------------------------------------------------------------------------
    - ��Ű�� ����
    CREATE OR REPLACE PACKAGE pEmp IS 
        FUNCTION fnTax(p IN NUMBER) RETURN NUMBER;
        PROCEDURE empList(pName VARCHAR2);
        PROCEDURE empList;                 -- ���ν��� �ߺ����� 
    END pEmp;
    /
    
    - ��ü ����
    CREATE OR REPLACE PACKAGE BODY pEmp IS 
        FUNCTION fnTax(p IN NUMBER) 
        RETURN NUMBER
        IS 
            t NUMBER := 0;
        BEGIN
            IF p >= 3000000 THEN t := TRUNC(p * 0.03, -1); 
            ELSIF p >= 2000000 THEN t := TRUNC(p * 0.02, -1);
            ELSE t := 0;
            END IF;
            
            RETURN t;
        END;
        
        PROCEDURE empList(pName VARCHAR2)
        IS 
            vName VARCHAR2(30);
            vSal NUMBER;
            CURSOR cur_emp IS 
                SELECT name, sal FROM emp WHERE INSTR(name, pName)=1; 
        BEGIN
            OPEN cur_emp;
            LOOP 
                FETCH cur_emp INTO vName, vSal; 
                EXIT WHEN cur_emp%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(vName||' '||vSal); 
            END LOOP;
            CLOSE cur_emp;
        END;
        
        PROCEDURE empList
        IS 
        BEGIN 
            FOR rec IN (SELECT name, sal+bonus pay, fnTax(sal+bonus) tax FROM emp) LOOP
                DBMS_OUTPUT.PUT_LINE(rec.name||' '||rec.pay||' '||rec.tax); 
            END LOOP;
        END;
    END pEmp;
    /
    
    - ��Ű�� ���� 
    EXEC pEmp.empList('��');
    EXEC pEmp.empList();
    
    - ��Ű�� ��� Ȯ�� 
    SELECT * FROM user_objects;
    SELECT * FROM user_procedures;
    
    - ��Ű�� ���� 
    DROP PACKAGE pEmp;
         