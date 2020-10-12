package test0205;

public class RandomEx {

	public static void main(String[] args) {
		int n;
		// 0 <= Math.random() < 1 사이의 난수 
		//			ex) 0.1, 0.07, 0.000005 ... 
		for(int i=1; i<=100; i++) {
			n = (int)(Math.random()*100)+1; // *100하면 아무리 커도 99 
											// > n은 1~100사이의 난수
			System.out.printf("%5d", n);
			if(i%10==0)
				System.out.println();
		}
	}
}
