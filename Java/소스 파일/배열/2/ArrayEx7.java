package test0207;

public class ArrayEx7 {
	
	public static void main(String[] args) {
		/* 1~10���� ������ �� �ٿ� 10���� ����ϰ� 
		     �������� �� ������ �߻� Ƚ���� ��� 
		  (int)(Math.random()*10)+1  */
		
		int []count=new int[10];
		int num;
		
		System.out.println("�߻��� ����...");
		for (int i=1; i<=100; i++) {
			num=(int)(Math.random()*10)+1;
			
			count[num-1]++;  // count[0]~count[9]���� �ְ� 
						     // count[0]=1; count[1]=2; .... 
			
			System.out.printf("%3d", num);
			if(i%10==0) System.out.println();
		}
		
		System.out.println("\n���ں� �߻�Ƚ�� : ");
		for(int i=0; i<count.length; i++) {
			System.out.println((i+1)+"\t"+count[i]);
		}
			
	}
}
