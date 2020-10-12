package test0207;

import java.util.Scanner;

public class ArrayEx8 {

	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		int[] month={31,0,31,30,31,30,31,31,30,31,30,31};
					// month[0] ~ month[11] 
		String[] week={"일", "월", "화", "수", "목", "금", "토"};
		int y, m, d; 
		
		do {
			System.out.print("년도?");
			y=sc.nextInt();
		} while(y<0); 
		
		do {
			System.out.print("월?");
			m=sc.nextInt();
		} while(m<1||m>12); 
		
		// 2월 날수 계산 
		if(y%4==0&&y%100!=0||y%400==0)
			month[1]=29;
		else 
			month[1]=28;
		
		do {
			System.out.print("일?");
			d=sc.nextInt();
		} while(d<1||d>month[m-1]); 
				
		// 1년 1월 1일은 월요일 
		// 전체 날수 계산하기 
		
		int tot;
		tot = (y-1)*365 + ((y-1)/4 - (y-1)/100 + (y-1)/400); 
		for(int i=0; i<m-1; i++) {
			tot+=month[i];     // m-1월까지의 날수를 구해야하므로 
							   // m-1월의 값은 month[m-2]가 가지고 있음 
		}
		tot+=d; 
		
		System.out.printf("%d년 %d월 %d일은 %s요일\n", y,m,d,week[tot%7]);
		
		/* 2020년 4월 20일? 
		 1.1.1 ~ 2019.12.31
		  전체날수 = 2019 * 365 + (2019/4 - 2019/100 + 2019/400); 
		  전체날수 += 1월, 2월, 3월 
		  전체날수 += 20 
		 */		
		
		sc.close();	
		}
}
