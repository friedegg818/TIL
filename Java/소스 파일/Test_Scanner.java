package test0131;

import java.util.Scanner;

public class Test_Scanner {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		
		System.out.print("���ڿ�?");
		String s=sc.next(); // sc.next() <- ���ڿ��� �Է¹޴� ���
		
		char ch;
		
		ch = s.charAt(0); // 0 -> ���� ó���� ��ġ���ִ� ����
            // charAt() : ���ڿ����� Ư�� ��ġ�� �ִ� �ϳ��� ������
		System.out.println(ch);
		
		ch = s.charAt(2); // 2 -> ����° ��ġ���ִ� ���� 
		System.out.println(ch);
		
		sc.close();
	}
}
