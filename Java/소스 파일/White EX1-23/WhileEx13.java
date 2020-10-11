package test0203;

public class WhileEx13 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<100) {    
			n++;
			if(n%2==1)
			s+=n;        // 반복 횟수가 100번 > 안 좋은 방법 
		}
			
		System.out.println("홀수합:"+s); // 
	}
}
