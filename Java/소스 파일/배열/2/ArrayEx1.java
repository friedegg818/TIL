package test0207;

public class ArrayEx1 {

	public static void main(String[] args) {
		int []a=new int[5]; // �迭����� �޸� �Ҵ� 
		
		for(int i=0; i<a.length; i++) { // 5�� �ݺ� 
			a[i] = i+1; // a[0] <-1 .. a[4]<-5 
		}
/*		
		for(int i=0; i<a.length; i++) {
			System.out.println(a[i]);
*/
		//���� for�� 
		for( int n : a ) { //  �ڷ���+���Ϻ���  : ����(collection)
			System.out.println(n); 
		}
	}
}
