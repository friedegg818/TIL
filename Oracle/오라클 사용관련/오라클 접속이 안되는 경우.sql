
-- 오라클 서버 연결 확인
   사용법 : tnsping <address> <count> 
   cmd>tnsping 127.0.0.1 5


-- 윈도우즈 서비스 확인
   컴퓨터 - [마우스우측] - 관리 - 서비스 및 응용 프로그램 - 서비스

   OracleServiceORCL
   OracleORCLTNSListener

   위 두개의 서비스가 "시작됨"으로 표시되어 있어야함

   -- 참고 : Express 버전을 설치한 경우 서비스 이름
            - OracleServiceXE
            - OracleXETNSListener


 -- SYS 계정으로 CONNECT 했을 때 다음과 같은 메시지가 출력 된 경우는 일반적으로 데이터베이스가 CLOSE 된 상태. <휴지인스턴스에 접속했습니다.>

    이런경우 다음과 같이 STARTUP을 실행
    cmd>sqlplus / as sysdba
    sql>STARTUP


-----------------------------------------------------------------------
<오라클 설치 후 컴퓨터 이름을 변경한 경우>

 -- listener.ora 파일 내용중
             :
    LISTENER =
      (DESCRIPTION_LIST =
        (DESCRIPTION =
          (ADDRESS = (PROTOCOL = IPC)(KEY = EXTPROC1))
          (ADDRESS = (PROTOCOL = TCP)(HOST = 컴퓨터명)(PORT = 1521))
        )
      )

 -- tnsnames.ora 파일내용중
     ORCL =
      (DESCRIPTION =
        (ADDRESS = (PROTOCOL = TCP)(HOST = 컴퓨터명)(PORT = 1521))
        (CONNECT_DATA =
          (SERVER = DEDICATED)
          (SERVICE_NAME = orcl)
        )
      )

  
    위 두파일의 컴퓨터명을 변경한 컴퓨터명이나 아이피로 변경하고 컴퓨터를 재부팅 해야 함 

     -- 참고 : Express 버전을 설치한 SERVICE_NAME(SID 명) 이 기본적으로 XE로 설정되어 있음

        
