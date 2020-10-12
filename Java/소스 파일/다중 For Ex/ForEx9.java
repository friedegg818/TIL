package test0205;

public class ForEx9 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=5-i; j++) {  
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) {
				System.out.print("*");
			}
			System.out.println();
		}
		
		for(int i=4; i>=1; i--) {   // 이것만 뒤집어 주면 됨 
			for(int j=1; j<=5-i; j++) {  // 공백 1,2,3,4 
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) { // * 7,5,3,1 
				System.out.print("*");
			}
			System.out.println();
		}
		System.out.println();
		
		int s=5; // 홀수만 가능 
		int n;		
		n=s/2;
		for(int i=0; i<s; i++) {
			for(int j=0; j<s-n; j++) { // n으로 증감을 조정 
				System.out.print(j>=n?"*":" ");
			}
			n=i<(s/2)?n-1:n+1;
			System.out.println();
			}				
		
		}
}
