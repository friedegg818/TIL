package test0203;

public class SwitchEx2 {
	public static void main(String[] args) {
		int a=13;
		
		// a%3 > 0,1,2  
		
		switch(a%3) { // 수식
		case 0: System.out.println(a+" : 3의배수"); break;
		case 1: System.out.println(a+" : 3의배수아님"); break;
		case 2: System.out.println(a+" : 3의배수아님"); break; 
		/*
		case 1: case 2: System.out.println(a+" : 3의배수아님"); break;
		case 1과 2의 문장이 동일 할 때에는 위와 같이 작성하여도 실행 OK 
		*/
		}
		
		}
	}
