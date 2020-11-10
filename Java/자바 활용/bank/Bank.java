package bank3;

public interface Bank {
	public void create(); // 계좌 생성 
	public void deposit(); // 예금
	public void withdraw(); // 출금 
	public void delete(); // 계좌 삭제 
	public void check(); // 계좌 목록 조회
}
