package test0204;

public class Fortest9 {
	public static void main(String[] args) {
		
		
/*		int s, n;
		s=n=0;
		while(n<10) {
			n++;
			s+=n;
		}
		System.out.println(s); 


		int s=0;
		for(int n=1; n<=10; n++) {
			s+=n;
		}
		System.out.println(s);

	// break : switch~case, while, do~while, for�� Ż��
		int s=0, n=0;
		while(true) { // ���ѷ���(infinite loop)
			n++;
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);

		int s=0, n=0; 
		for( ;  ; ) { // ���ѷ���(infinite loop)
			n++;
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);	
*/
		
		int s,n;
		for(s=0,n=1;  ; n++) { // ���ѷ���(infinite loop)
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);	
	}
}
