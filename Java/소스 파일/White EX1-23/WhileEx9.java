package test0203;

public class WhileEx9 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(++n<10) { //  
			s+=n;
		}
		System.out.println("���:"+s); // 1~9������ : 45 
		
	}
}
