package test0204;

public class ForEx8 {
	public static void main(String[] args) {
		// 1~100���� �� �� 3 �Ǵ� 5�� ����� ���ٿ� 5���� ����ϰ� 
		// �������� �հ� ��� ��� 
		
		int cnt=0;
		int s=0;
		for(int n=1; n<=100; n++) {
			if(n%3==0 || n%5==0) {
				System.out.printf("%5d",n); // �ڸ��� ���߱� ���� printf ���
				s+=n;
				if(++cnt%5==0) {
				System.out.println();
				}
			}
		} 
		  System.out.println("\n��:"+s); // ���� �����ֱ� ���� \n
		  System.out.printf("���:%d%n", s/cnt);
	}
}
