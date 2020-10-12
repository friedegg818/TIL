package test0204;

public class ForEx3 {
	public static void main(String[] args) {
		
		// for에서 변수 선언 가능 → for문을 벗어나면 쥬금 
		for(int n=1; n<=5; n++) {
			System.out.println("안:"+n);
		}
		// System.out.println("밖:"+n); // 컴파일 오류. 
			// for에서 선언한 변수는 밖에서 사용 불가 
	}
}
