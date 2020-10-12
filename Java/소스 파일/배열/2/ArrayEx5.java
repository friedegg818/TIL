package test0207;

public class ArrayEx5 {

	public static void main(String[] args) {
		// 배열 선언과 동시에 초기화 
		int[] a=new int[] {10,20,30};
	   // int[] a={10,20,30}; // 가능
		
		System.out.println("요소수:"+a.length);
		for(int n : a) {
			System.out.println(n+" ");
		}
		System.out.println();
	}
}
