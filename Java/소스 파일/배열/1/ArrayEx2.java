package test0206;

public class ArrayEx2 {

	public static void main(String[] args) {
		// 배열 선언과 동시에 메모리 할당 
		int []a=new int[3]; // 정수를 저장 할 수 있는 변수 3개 선언 개념 
		
		a[0]=10; a[1]=20; a[2]=30; 
		
		System.out.println("배열의 요소 수 : " + a.length);
		
		for(int i=0; i<a.length; i++) { // a[0]부터 시작하므로 i=0
			System.out.println(a[i]);
		}
		
	}
}
