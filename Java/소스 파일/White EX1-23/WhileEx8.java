package test0203;

public class WhileEx8 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<100) { // 1~100���� �� 
			n++;
			s+=n;
		}
		System.out.println("���:"+s);
		
	}
}
