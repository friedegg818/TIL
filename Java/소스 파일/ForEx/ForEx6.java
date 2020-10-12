package test0204;

public class ForEx6 {  // for문 이해가 어려울 때 참고 할 것 
	public static void main(String[] args) {
		int n, s;
		s=0;
		for(n=1; n<=10; n++) {
			s+=n;
			System.out.println("안:"+n+","+s);
		}
		System.out.println("밖:"+n+","+s);
	}
}
