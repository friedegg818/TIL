package test0203;

public class SwitchEx5 {
	public static void main(String[] args) {
		int a=12;
		
		switch(a%2) {   // case 구문 안에 switch 구문을 사용 할 수 있다.
		case 0: System.out.println("2의배수"); // break;를 쓰면 밑의 switch 자체를 실행 할 수 없으므로 오류
				switch(a%3) {
				case 0: System.out.println("3의배수"); break; // 두번째 switch를 나감
				case 1: case 2: System.out.println("3의배수아님"); break;
		        } break;
		case 1: System.out.println("2의배수아님");
				switch(a%3) {
				case 0: System.out.println("3의배수"); break;
				case 1: case 2: System.out.println("3의배수아님"); break;
				} break;
		}
	}
}
