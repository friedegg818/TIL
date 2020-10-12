package test0205;

public class ForEx1 {
	public static void main(String[] args) {
		for(int i=1; i<=3; i++) {     // 3번 실행 
			System.out.println("i:"+i);
			for(int j=1; j<=2; j++) {  // 3*2 6번 실행 
				System.out.println("i:"+i+", j:"+j);
			}
			System.out.println("---------------"); // 3번 실행 
		}
	}
}
