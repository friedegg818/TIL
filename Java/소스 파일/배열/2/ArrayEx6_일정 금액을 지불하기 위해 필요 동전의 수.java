package test0207;

public class ArrayEx6 {

	public static void main(String[] args) {
		// 4380원을 500원,100원,50원,10원짜리로 지불하기 위해서
		// 필요한 동전의 개수는?
		// 배열 이용 
		
		int m = 4380;
		int []unit = new int[] {500,100,50,10};
		
		int x;
		for(int n : unit) {
			x = m / n;
			System.out.println(n+":"+x);
			
			m%=n; 		
		}
		
	}
}
