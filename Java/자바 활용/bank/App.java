package bank3;

import java.util.Scanner;

public class App {
	public static void main(String[] args) {
		
		Bank vo = new BankImpl(); 
		Scanner sc = new Scanner(System.in);
		int ch;
		
		System.out.println("Live Banking Service");
		
		try {			
			while(true) {
				do { 
					System.out.println("1.계좌 생성 2.입금 3.출금 4.계좌 삭제 5.계좌 목록 확인 6.종료 =?");
					ch = sc.nextInt();					
				} while (ch < 1 || ch > 6);
				
				if(ch==6) break; 
				
				switch(ch) {
				case 1: vo.create(); break;
				case 2: vo.deposit(); break;
				case 3: vo.withdraw(); break;
				case 4: vo.delete(); break;
				case 5: vo.check(); break;
				}
			}			
			
		} finally {
			sc.close();
		}
	}
}
