package test0207;

import java.util.Scanner;

public class ArrayEx2 {

	public static void main(String[] args) {
	/* 
	 5���� �̸��� ������ �Է� �޾�
	 �̸� ���� ����(����-���)�� ����ϴ� ���α׷� �ۼ�
	 */
		
		Scanner sc=new Scanner(System.in);
		String [] name=new String[5];
		int []score=new int[5];
		int tot, ave;
		
		tot=0;
		for(int i=0; i<name.length; i++) {
			System.out.print((i+1)+"��° �̸� : ");
			name[i] = sc.next();
			System.out.print("  ���� : ");
			score[i] = sc.nextInt();
			
			tot+=score[i]; 		// �Է� ���� ������ �� ���ϱ�
		}
		// ��� ���
		ave = tot / name.length;
		// ��� 
		for(int i=0; i<name.length; i++) {
			System.out.println(name[i]+"\t"+score[i]+"\t"+(score[i]-ave));
		}
		
		sc.close();
		
	}
}
