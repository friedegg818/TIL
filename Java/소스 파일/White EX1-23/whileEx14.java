package test0203;

public class whileEx14 {
	public static void main(String[] args) {
		int n,s;
		
		// 1*2*3*...*9*10		
        n=0;
        s=1;
        
        while (n<10) {
        	++n;    // n++;
        	s=s*n;  // s*=n;
        } 
         System.out.println("°á°ú : " + s);
         
	}
}
