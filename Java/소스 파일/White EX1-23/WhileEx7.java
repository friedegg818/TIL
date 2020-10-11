package test0203;

public class WhileEx7 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<10) {
			n++;
			s+=n;
			System.out.println(n+","+s);
		}
		System.out.println("°á°ú:"+s);
		
	}
}