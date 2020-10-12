package test0206;

public class ContinueEx3 {

	public static void main(String[] args) {
		// continue labelName;
		
 		for(int i=1; i<=3; i++) {
			for(int j=1; j<=3; j++) { 
				if(i+j==4) {
					continue; // 두번째 for로 올라감 
				}
				System.out.println(i+","+j); 
			}	
		}

/*		
 		AAA:
		for(int i=1; i<=3; i++) {
			for(int j=1; j<=3; j++) { 
				if(i+j==4) {
					continue AAA; 
				}	
				System.out.println(i+","+j);  // 1,1  1,2  2,1
			}	
		}
*/	
	
	}
}


