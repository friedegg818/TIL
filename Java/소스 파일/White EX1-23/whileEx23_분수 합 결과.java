package test0203;

public class whileEx23 {
	public static void main(String[] args) {
		// 1/2 + 2/3 + ... + 9/10 ��� 
		
		int n;
		double s;
		
		n=0;
		s=0;
		
		while (n<9) {
			n++; 
			s += (double)n/(n+1);			
		}
		// System.out.println("���:"+s); 
		System.out.printf("���: %.2f\n",s);
	}
}
