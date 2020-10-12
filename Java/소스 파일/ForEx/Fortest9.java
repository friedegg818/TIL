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

	// break : switch~case, while, do~while, for문 탈출
		int s=0, n=0;
		while(true) { // 무한루프(infinite loop)
			n++;
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);

		int s=0, n=0; 
		for( ;  ; ) { // 무한루프(infinite loop)
			n++;
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);	
*/
		
		int s,n;
		for(s=0,n=1;  ; n++) { // 무한루프(infinite loop)
			s+=n;
			if(n>=10) break;
		}
		System.out.println(s);	
	}
}
