package test0204;

public class ForEx4 {
	public static void main(String[] args) {
		/* 1~100���� �� ���ϱ� 
		int s=0; 
		
		for(int n=1; n<=100; n++) {
			s+=n;
		}
		System.out.println("���:"+s); */
		
		/* 1~100���� Ȧ�� �� ���ϱ� 
		 int s=0; 		
		 
		for(int n=1; n<=100; n+=2) {
			s+=n;
		}
		System.out.println("Ȧ����:"+s); */
		
		/* 1~100���� Ȧ�� �� ���ϱ� 
		int s, n;
		for(n=2, s=0; n<=100; n+=2) { // �ʱⰪ���� , ��� �ʱⰪ ���� (�����ĵ� ����)
			s+=n;
		}
		System.out.println("¦����:"+s); */
		
		int s, n;
		for(n=1, s=0; n<=100; s+=n, n++) // ������ �ʴ� ��� 
			;
		System.out.println("��:"+s);
		
	}	
}
