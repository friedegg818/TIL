package test0205;

public class ForEx8 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=5-i; j++) { // 앞 공백 (손대지x) 
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) {
				System.out.print("*");
			}
			System.out.println();
		}

System.out.println(); // for문을 2번만 사용하기 
		
		int s=9;
		for(int i=s/2+1; i<=s; i++) {
			for(int j=0; j<i; j++) {  // 조건식에 숫자 외에 바깥에 있는 변수도 가져다 쓸 수 있다 
				                      // 반복횟수가 달라짐 
				System.out.print((s-i)<=j?"*":" ");
			}
			System.out.println();
		}
				
	}
}