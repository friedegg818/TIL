
[ 오라클 SID 및 방화벽 ]
  - 오라클의 SID
    오라클이 C:\app\사용자명\product에 설치된 경우

     C:\app\SIST\product\18.0.0\dbhomeXE\network\admin\tnsnames.ora 파일 내용 중

      ORCL =
        (DESCRIPTION =
          (ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 1521))
          (CONNECT_DATA =
            (SERVER = DEDICATED)
            (SERVICE_NAME = ORCL)
          )
        )

     에서 SERVICE_NAME = ORCL 에 있는 ORCL이 SID 이다.

 참고 : Express 버전을 설치한 SERVICE_NAME(SID 명) 이 기본적으로 XE로 설정되어 있음


  - 윈도우즈에서 방화벽이 활성화 된경우
      -- 제어판 : 시스템 및 보안 - Windows 방화벽 - 고급설정
      -- 인바운드 규칙(허용 규칙을 만듬) - 새 규칙
      -- 포트 - [다음]
      -- 규칙 : TCP
      -- 특정 로컬 포트 : 1521  - [다음]
      -- 연결허용 - [다음] - 프로필 모두 선택 - [다음]
      -- 이름 : 오라클 - [마침]

      인바운드 : 허용규칙을 만드는것
      아웃바운드 : 외부로 나가는 규칙 생성
    
      안되는 경우 아웃바운드 규칙도 인바운드와 동일하게 작성

