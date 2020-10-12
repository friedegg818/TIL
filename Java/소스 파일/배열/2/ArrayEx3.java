package test0207;

public class ArrayEx3 {

	public static void main(String[] args) {
		
		int [] a=new int[3]; // 길이가 3인 정수 배열 
		a[0]=10; a[1]=20; a[2]=30;
		
		System.out.println("배열 내용...");
		for(int n : a) {
			System.out.print(n+"   "); // 10 20 30 
		}
		System.out.println();
		
		// 배열의 크기 변경 
		/* 배열의 크기를 변경하면 이전 배열은 위치를 참조 할 수 없어
		     가비지컬렉터(메모리 회수)의 대상이 되며 새로운 배열을 만든다.  */
		a= new int[5];
		a[3]=40; a[4]=50;
		
		System.out.println("배열 크기 변경 후...");
		for(int n : a) {
			System.out.print(n+"   "); // 0 0 0 40 50 
									   // 이전 값은 사라짐 
		}
		System.out.println();
		
		
		
	}
}
