package test0206;

public class ArrayEx2 {

	public static void main(String[] args) {
		// �迭 ����� ���ÿ� �޸� �Ҵ� 
		int []a=new int[3]; // ������ ���� �� �� �ִ� ���� 3�� ���� ���� 
		
		a[0]=10; a[1]=20; a[2]=30; 
		
		System.out.println("�迭�� ��� �� : " + a.length);
		
		for(int i=0; i<a.length; i++) { // a[0]���� �����ϹǷ� i=0
			System.out.println(a[i]);
		}
		
	}
}
