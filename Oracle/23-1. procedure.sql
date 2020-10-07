<Member ���� ���ν��� �ۼ�> 

- �߰� ���ν���
CREATE OR REPLACE PROCEDURE insertMember
(
    pId member1.id%TYPE,
    pPwd member1.pwd%TYPE,
    pName member1.name%TYPE,
    pBirth member2.birth%TYPE,
    pEmail member2.email%TYPE,
    pTel member2.tel%TYPE
)
IS
BEGIN 
    INSERT INTO member1 (id, pwd, name) VALUES (pId, pPwd, pName); 
    INSERT INTO member2 (id, birth, email, tel) VALUES (pId, pBirth, pEmail, pTel);
    COMMIT;
END;
/

SELECT * FROM member1;
SELECT * FROM member2;

- ���� ���ν���
CREATE OR REPLACE PROCEDURE updateMember
(
    pId member1.id%TYPE,
    pPwd member1.pwd%TYPE,
    pName member1.name%TYPE,
    pBirth member2.birth%TYPE,
    pEmail member2.email%TYPE,
    pTel member2.tel%TYPE
    
)
IS
BEGIN 
    UPDATE member1 SET pwd = pPwd, name = pName WHERE id = pId; 
    UPDATE member2 SET birth = pBirth, email = pEmail, tel = pTel WHERE id = pId;
    COMMIT;
END;
/

- ���� ���ν��� 
CREATE OR REPLACE PROCEDURE deleteMember 
(
    pId member1.id%TYPE
)
IS
BEGIN
    DELETE FROM member2 WHERE id = pId;
    DELETE FROM member1 WHERE id = pId;
    IF SQL%NOTFOUND THEN 
        RAISE_APPLICATION_ERROR(-20100, '��ϵ� �ڷᰡ �ƴմϴ�.'); 
    END IF;
    COMMIT;
END;
/




- ���̵� �˻� ���ν���

CREATE OR REPLACE PROCEDURE findByIdMember
(
    pResult OUT SYS_REFCURSOR,
    pId IN VARCHAR2
)
IS
BEGIN
    OPEN pResult FOR
        SELECT m1.id, name, birth, email, tel 
        FROM member1 m1
        JOIN member2 m2 ON m1.id = m2.id
        WHERE m1.id = pId;
END;
/


- ��ü ��� ���ν���

CREATE OR REPLACE PROCEDURE listMember
(
    pResult OUT SYS_REFCURSOR
)
IS
BEGIN
    OPEN pResult FOR
        SELECT m1.id, name, birth, email, tel 
        FROM member1 m1
        JOIN member2 m2 ON m1.id = m2.id;
END;
/

- �̸� �˻� ���ν��� 
CREATE OR REPLACE PROCEDURE findByNameMember
(
    pResult OUT SYS_REFCURSOR,
    pName IN VARCHAR2
)
IS
BEGIN
    OPEN pResult FOR
        SELECT m1.id, name, birth, email, tel 
        FROM member1 m1
        JOIN member2 m2 ON m1.id = m2.id
        WHERE INSTR(m1.name, pName) > = 1;
END;
/