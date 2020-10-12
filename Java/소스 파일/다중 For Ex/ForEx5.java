package test0205;

public class ForEx5 {
	public static void main(String[] args) {
		
		/*for(int i=1; i<=10; i++) {
			for(int j=i; j<=i+9; j++) {
				System.out.printf("%3d", j);
			}
			System.out.println(); */
	
	
		int i,j;         // for를 while로 바꾸기 
		i=1; 					
		while(i<=10) {
			j=i;			
			while(j<=i+9) { 
				System.out.printf("%3d", j);
				j++;
			} 
			System.out.println();
			i++;
	     }
    }
}
		
		