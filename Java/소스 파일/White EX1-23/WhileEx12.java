package test0203;

public class WhileEx12 {
	public static void main(String[] args) {
		int n,s;
		
		// 1+3+...+97+99 
		n=0;
		s=0;
		while(++n<100) { 
			s+=n;
			n+=1;
		}
		/*
		 n=1;
		 s=0;
		 while(n<100) {
		 	s+=n;
		 	n+=2;              ������ ���α׷� 
		 */
		
		System.out.println("Ȧ����:"+s); // 2500
	}
}
