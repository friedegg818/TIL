package test0203;

public class whileEx19 {
	public static void main(String[] args) {
		// 1���� ����� ���ϸ� �����հ谡 100�� ���� �ʴ� ���� ū ���� �Ǵ°� 
		int s=0;
		int n=0;
		
		while ((s+=++n) <= 100) {
			// s �� n�� ���� 1�� �������Ѽ� ���� �� 
			// �̷��� s�� 100�� ���� ������ �� ���� �������� ��� 			
			System.out.printf("%d - %d%n", n, s);
			}
	}
}
