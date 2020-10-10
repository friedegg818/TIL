[사용자 추가 및 권한설정]
-----------------------------------------------------
-- sys 계정 connect 및 사용자 목록 확인
   cmd>sqlplus  sys/"패스워드"  as  sysdba
   OR
   cmd>sqlplus  /  as  sysdba

sql> 

-- 사용자 목록 확인(sys 계정)
   SELECT * FROM all_users;


-------------------------------------------------------
-- 12C 이상의 버전에서 11g와 같은 방식으로 사용자 추가 및 삭제
    ALTER SESSION SET "_ORACLE_SCRIPT" = true;

    ** ORACLE 12c 이상부터는 사용자 생성 시 사용자명 앞에 c##(『c##사용자명』) 붙여야 함. 아니면 사용자가 등록되지 않음 (ORA-65096: 공통 사용자 또는 롤 이름이 부적합 합니다.)
    ** ORACLE 12c 이상부터는 사용자 삭제시 sky 처럼 사용자명이 『c##사용자명』 형식이 아니면 삭제 불가 (ORA-28014: 관리 사용자를 삭제할 수 없습니다.)
       → 『ALTER SESSION SET "_ORACLE_SCRIPT" = true;』 을 먼저 실행하면 기본 방식처럼 가능


-- sky 사용자 및 sky 사용자의 테이블등 모든 객체 삭제(sys 계정에서)
   SELECT username FROM dba_users;
   DROP USER sky CASCADE;


-- -----------------------------------------------------
-- sky 사용자 추가, 아이덴티파이드는 "java$!" 로 설정(sys 계정에서)
   CREATE USER sky IDENTIFIED BY "java$!";

-- 사용자 권한 부여(sys 계정에서)
   GRANT CONNECT, RESOURCE TO sky;

-- DEFAULT 테이블스페이스를 USERS로 변경(sys 계정)
   ALTER USER sky DEFAULT TABLESPACE USERS;

-- TEMPORARY 테이블스페이스(정렬등에서 사용)를 TEMP 변경(sys 계정)
   ALTER USER sky TEMPORARY TABLESPACE TEMP;


   ** [주의]
      사용자를 추가하고 DEFAULT 테이블스페이스를 지정하지 않으면 기본으로 SYSTEM 테이블스페이스(데이터 운영에 필요한 정보등을 저장)를 사용
      SYSTEM 테이블스페이스에는 휴지통이 없다.


-------------------------------------------------------
-- ORACLE 12C 이상의 버전
   -- USERS 테이블스페이스 권한 부여(SYS 계정) - 권한을 부여하지 않으면 INSERT 시 오류
      ALTER USER sky DEFAULT TABLESPACE USERS QUOTA UNLIMITED ON USERS;


-- -----------------------------------------------------
-- sky 계정으로 CONNECT
   CONN sky/"java$!"


-- -----------------------------------------------------
-- 사용자 아이덴티파이드를 변경 할 경우(자기자신 또는 SYS 계정)
   ALTER  USER  사용자명  IDENTIFIED  BY  "패스워드";

-- LOCK이 설정된 경우 LOCK 해제(SYS 계정)
   ALTER  USER  사용자명  ACCOUNT  UNLOCK;

-- 제약 조건이 있어도 테이블 삭제할 경우
   DROP  TABLE  테이블명  CASCADE  CONSTRAINTS  PURGE;
   

-- -----------------------------------------------------
-- 사용자 제거(CASCADE 옵션으로 모든 객체도 삭제) : SYS 계정
   DROP USER 사용자명 CASCADE; 

-- 18c -> "ORA-28014: 관리 사용자를 삭제할 수 없습니다." 오류 발생시 아래 쿼리를 실행 후 DROP USER
   ALTER SESSION SET "_ORACLE_SCRIPT" = true;
