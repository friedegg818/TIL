package test0204;

public class WhileEx4 {

	public static void main(String[] args) {
		int n;
		int s,cnt;

		n=s=cnt=0;
				
		while (n<100) {
			n++;
			if(n%3==0 || n%5==0) {
				s+=n; // ��
			    cnt++; // ����
			}
		  }
		System.out.println("��:"+s);
		System.out.println("���:"+(s/cnt));
	}
}
