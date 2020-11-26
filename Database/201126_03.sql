[PL/SQL]
- SQLP�� �������� ����� ����� �߰��Ͽ� Ȯ�� �� �� (ex.IF-THEN, WHILE ����)
- ��� ������ ��� 
  - �⺻ ���� : ���, ���ν���, �Լ� 
  - ���� �������� �ټ��� �����ϵ��� ���� �� �� ���� 
  
- ���� 
  - SQL�δ� ���� �� ���� PL/SQL�� ������ ���α׷��� ��� 
  - ���ȭ�� ���α׷� ����
  - Ŀ���� ���� ���� ó�� 
  - �ڵ��� ���뼺�� ���� 
  - ��Ʈ��ũ ��ŷ��� �������ν� ���� ��� (���� SQL���� �ϳ��� ������� ���, �� ���� ȣ��� ��� ��ü�� ������ �����Ƿ�) 

- �⺻ ���� 
    -- ������ : ������ ��ü���� ����
       [DECLARE 
          <���> 
          <����>
          <Ŀ��>
          <����� ���� ���ܻ���>] 
 
    -- ������ : ������ ó��(�ʼ�) 
    -- �������� SQL������ ������ ���Ǿ�(CREATE,ALTER,DROP)�� ������ �����(GRANT, REVOKE) �� ��� �Ұ� 
         BEGIN 
           <SQL�� or PL/SQL��>
    -- ���� ���� ó���� : ���� �� �߻��� ���ܳ� ���� ó�� 
            [ <EXCEPTION>
                <���� ���� ó��>] 
         END;
         
- ���� ���� ���� 
  - ���ǹ� ���� 
     if <����> then <PL/SQL��> else <PL/SQL��> end if;
    
  - for �ݺ��� ���� 
     for <�ε��� ����> in <����> loop <PL/SQL��> end loop; 
    
  - while �ݺ��� ���� 
     while <����> loop 
       <PL/SQL��>
     end loop; 
     
- PL/SQL���� ���� ����� �ټ��� ���� ��ȯ �� ���, ��� �� ù��° �ุ �����Ѵ�. 

- Ŀ��(Cursor)
  - ���ǰ� �ټ��� ����� ����� ��ȯ �� �� �����Ͽ� ������ ����� �� ���� ó���ϰ� ���� � ���� ó���ϰ� �ִ��� ���� �ϴ� �� 
  - ������ ����� ��ȯ�Ǵ� ��(Ȱ�� ����)���� �� ���� ����Ű�� ������ 
  
- Ŀ�� ��� �ܰ�
  1. ����� ���������� Ŀ�� ���� 
     CURSOR Ŀ��_�̸� IS SELECT��;

  2. Ŀ�� ��� ��, ���������� Ŀ�� ���� 
     OPEN Ŀ��_�̸�; 
 
  3. FETCH���� ����Ͽ� Ȱ�� ���տ� �ִ� ���� �ϳ��� ���ʴ�� �˻� 
     FETCH Ŀ��_�̸� INTO ����_����Ʈ; 

  4. Ŀ���� �ݱ� 
     CLOSE Ŀ��_�̸�;
     
- ����
  -- 3�� �μ��� ������� ��� �޿��� 2800000�� �̻��̸� 3�� �μ��� ���� ������� �̸��� ��å�� �޿��� �˻��ϰ�, 
  -- �׷��� ������ "3�� �μ��� ��� �޿��� 2800000 �̸��Դϴ�." ��� �޼����� �μ� �ϴ� �ڵ�
  
  -- PL/SQL�� �⺻������ ������� �������� �ʱ� ������, ����� ���� ���� ��� SERVEROUTPUT�� ON���� ���� 
  set serveroutput on;  
  
  DECLARE 
    avg_salary NUMBER;
    l_empname VARCHAR2(10);
    l_title VARCHAR2(10);
    l_salary NUMBER;
    
    -- Ŀ���� �̿��Ͽ� employee ���� �������� 
    CURSOR get_employee_rec IS 
    SELECT empname, title, salary 
    FROM employee 
    WHERE dno = 3;
    
  BEGIN
    SELECT AVG(salary)
    INTO avg_salary
    FROM employee
    WHERE dno = 3;
    
    IF avg_salary >= 2800000 THEN 
       FOR emp_rec IN get_employee_rec 
       
       LOOP
         l_empname := emp_rec.empname;
         l_title   := emp_rec.title;
         l_salary  := emp_rec.salary;
       END LOOP;
       
     ELSE 
       dbms_output.put_line('3�� �μ��� ��� �޿��� 2800000 �̸��Դϴ�.');
     END IF;
  END;
  /
  