package test0203;

public class whileEx22 {
	public static void main(String[] args) {
		// 1+(1+2)+(1+2+3)+...+(1+2+...+10) 결과 
		int n, s, ss;
		
		n=0;
		s=0;
		ss=0;
		
		while (n<10) {
			n++;
			s+=n;
			ss+=s; 
			
		} System.out.print("결과:"+ss);
					
	}
}
