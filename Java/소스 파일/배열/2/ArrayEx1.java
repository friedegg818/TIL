package test0207;

public class ArrayEx1 {

	public static void main(String[] args) {
		int []a=new int[5]; // 배열선언과 메모리 할당 
		
		for(int i=0; i<a.length; i++) { // 5번 반복 
			a[i] = i+1; // a[0] <-1 .. a[4]<-5 
		}
/*		
		for(int i=0; i<a.length; i++) {
			System.out.println(a[i]);
*/
		//향상된 for형 
		for( int n : a ) { //  자료형+단일변수  : 집합(collection)
			System.out.println(n); 
		}
	}
}
