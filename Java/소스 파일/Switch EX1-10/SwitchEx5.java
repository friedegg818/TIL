package test0203;

public class SwitchEx5 {
	public static void main(String[] args) {
		int a=12;
		
		switch(a%2) {   // case ���� �ȿ� switch ������ ��� �� �� �ִ�.
		case 0: System.out.println("2�ǹ��"); // break;�� ���� ���� switch ��ü�� ���� �� �� �����Ƿ� ����
				switch(a%3) {
				case 0: System.out.println("3�ǹ��"); break; // �ι�° switch�� ����
				case 1: case 2: System.out.println("3�ǹ���ƴ�"); break;
		        } break;
		case 1: System.out.println("2�ǹ���ƴ�");
				switch(a%3) {
				case 0: System.out.println("3�ǹ��"); break;
				case 1: case 2: System.out.println("3�ǹ���ƴ�"); break;
				} break;
		}
	}
}
