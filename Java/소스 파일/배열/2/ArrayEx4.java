package test0207;

public class ArrayEx4 {

	public static void main(String[] args) {
		int []a = new int[3];	// new를 1번만 씀 > 방을 1번만 잡는다
		int []b = a;			// 배열은 참조형임. 하나의 배열을 공유(a와 b가 가지는 주소가 같다) 
		
		a[0]=10; a[1]=20; a[2]=30;
		b[1]=200;
		
		System.out.println("a배열내용...");
		for(int n : a) {
			System.out.println(n+"   ");  // 10  200  30
		}
		System.out.println();
		
		System.out.println("b배열내용...");
		for(int n : b) {
			System.out.println(n+"   "); // 10  200  30
		}
		System.out.println();
				
	}
}
