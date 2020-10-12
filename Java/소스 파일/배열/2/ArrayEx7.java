package test0207;

public class ArrayEx7 {
	
	public static void main(String[] args) {
		/* 1~10까지 난수를 한 줄에 10개씩 출력하고 
		     마지막에 각 숫자의 발생 횟수를 출력 
		  (int)(Math.random()*10)+1  */
		
		int []count=new int[10];
		int num;
		
		System.out.println("발생된 난수...");
		for (int i=1; i<=100; i++) {
			num=(int)(Math.random()*10)+1;
			
			count[num-1]++;  // count[0]~count[9]까지 있고 
						     // count[0]=1; count[1]=2; .... 
			
			System.out.printf("%3d", num);
			if(i%10==0) System.out.println();
		}
		
		System.out.println("\n숫자별 발생횟수 : ");
		for(int i=0; i<count.length; i++) {
			System.out.println((i+1)+"\t"+count[i]);
		}
			
	}
}
