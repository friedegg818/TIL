package test0204;

public class Fortest10 {
	public static void main(String[] args) {
		
		int count=0;
		
/*
 	float a=2000000000, b=2000000050; 
 	System.out.println(a==b); // true 
 				float���� ���е��� ���� a�� b�� ���� ���ڷ� ������
 				-> �ݺ�Ƚ���� ���� �ʴ´�.  
 				& �Ǽ��� ���������� ���� �ʴ´�. 
 				  ��Ȯ�� ����� ������ ���� �� �ֱ� ������ 
 */		
		for(float f=2000000000; f<2000000000+50; f++) {
			count++;
		}
		System.out.println(count); // 0
	}
}
