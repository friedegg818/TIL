package test0205;

public class ForEx8 {
	public static void main(String[] args) {
		
		for(int i=1; i<=5; i++) {
			for(int j=1; j<=5-i; j++) { // �� ���� (�մ���x) 
				System.out.print(" ");
			}
			for(int j=1; j<=i*2-1; j++) {
				System.out.print("*");
			}
			System.out.println();
		}

System.out.println(); // for���� 2���� ����ϱ� 
		
		int s=9;
		for(int i=s/2+1; i<=s; i++) {
			for(int j=0; j<i; j++) {  // ���ǽĿ� ���� �ܿ� �ٱ��� �ִ� ������ ������ �� �� �ִ� 
				                      // �ݺ�Ƚ���� �޶��� 
				System.out.print((s-i)<=j?"*":" ");
			}
			System.out.println();
		}
				
	}
}