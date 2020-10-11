package test0203;

import java.util.Scanner;
/*
 년도와 월을 입력 받아 월의 마지막 날짜 출력 
 */
public class SwitchEx10 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int y,m,d;
		
		System.out.print("년도?");
		y=sc.nextInt();
		System.out.print("월?");
		m=sc.nextInt();
		
		// 2월 : 년도가 4의 배수이고 100의 배수가 아니거나 400의 배수이면 29일,
		//      그렇지 않으면 28일 
		switch(m) {
		case 1: case 3: case 5: case 7: case 8: case 10: case 12:
			d = 31; break;
		case 4: case 6: case 9: case 11: 
			d = 30; break;
		case 2: 
			if(y%4==0 && y%100!=0 || y%400==0) {
				d=29; 
			} else { 
				d=28;
			}
			break;
		default: d=0; break; // 오류를 없애기 위해 d에 초기값 부여 
		}
		
		if(d!=0) {
			System.out.println(y+"년 "+m+"월 마지막 날짜는 "+d+"일 입니다.");
		} else {
			System.out.println("입력 오류...");
		
		sc.close();
}     }
	}