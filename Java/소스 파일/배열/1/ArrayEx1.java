package test0206;

public class ArrayEx1 {
	
	public static void main(String[] args) {
		int []a; // 배열 선언  (정수를 저장 할 수 있는 방을 만들거얍!) 
		a = new int[5]; // 메모리 할당. (5개의 정수를 넣을 방을 만든것 )
						// 정수값을 5개 저장 할 수 있는 정수형 배열 
						// 메모리를 할당하면서 5개의 정수 배열 요소는 0으로 초기화 됨
						// 정수형 변수 5개를 선언한 경우와 유사 (메모리가 다르기 때문에 완전 같지는 않음)
		
		// int n;
		// System.out.println(n); // 에러. 초기화가 되지 않음 
				
		// 배열은 메모리를 할당하면 값을 초기화 하지 않아도 사용 가능
		System.out.println(a[0]); // 0
						// 배열에서 0번째 위치의 값을 출력 
						// 배열의 첨자(방의 위치)는 0부터 길이-1까지 사용 가능
		
		// 배열요소 사용
		a[0]=10; a[1]=20; a[2]=30; a[3]=40; a[4]=50; 
	//	a[5]=60; // 런타임 오류. 배열의 사용범위를 벗어남 => 프로그램 종료
				 // ArrayIndexOutOfBoundsException 
				 // new int[5]; => a[0]~a[4]까지 사용 가능 
	
		System.out.println(a[0]);  
		
		
	}
}
