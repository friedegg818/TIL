package test0203;

public class WhileEx13 {
	public static void main(String[] args) {
		int n,s;
		
		n=0;
		s=0;
		while(n<100) {    
			n++;
			if(n%2==1)
			s+=n;        // �ݺ� Ƚ���� 100�� > �� ���� ��� 
		}
			
		System.out.println("Ȧ����:"+s); // 
	}
}
