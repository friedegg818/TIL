package test0204;

public class WhileEx1 {
	
	public static void main(String[] args) {
/*
		int n=0;
		
		do {
			n++;
			System.out.println("��:"+n);
		} while(n<10);
		System.out.println("��:"+n);
*/
/*	
		int n, s;
		n=s=0;
		
		do {
			n++;
			s+=n;
		} while(n<10);
		System.out.println("���:"+s);
*/
		int n=10;
		while(n<10) { // ó�� ������ �������� ������ �ѹ��� ���� X (ù ������ �߿�)
			n++;
			System.out.println("while ��:"+n);
		}
		System.out.println("while ��:"+n);
		
		n=10;
		do { // ��� �ѹ��� ���� 
			n++;
			System.out.println("do~while ��:"+n);
		} while(n<10);
		System.out.println("do~while ��:"+n);
	
	}
}
