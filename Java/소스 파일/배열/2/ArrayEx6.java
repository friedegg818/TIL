package test0207;

public class ArrayEx6 {

	public static void main(String[] args) {
		// 4380���� 500��,100��,50��,10��¥���� �����ϱ� ���ؼ�
		// �ʿ��� ������ ������?
		// �迭 �̿� 
		
		int m = 4380;
		int []unit = new int[] {500,100,50,10};
		
		int x;
		for(int n : unit) {
			x = m / n;
			System.out.println(n+":"+x);
			
			m%=n; 		
		}
		
	}
}
