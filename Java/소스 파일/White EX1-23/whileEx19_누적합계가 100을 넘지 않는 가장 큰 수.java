package test0203;

public class whileEx19 {
	public static void main(String[] args) {
		// 1부터 몇까지 더하면 누적합계가 100을 넘지 않는 제일 큰 수가 되는가 
		int s=0;
		int n=0;
		
		while ((s+=++n) <= 100) {
			// s → n의 값을 1씩 증가시켜서 합한 값 
			// 이러한 s가 100을 넘지 않으면 ↓ 같은 형식으로 출력 			
			System.out.printf("%d - %d%n", n, s);
			}
	}
}
