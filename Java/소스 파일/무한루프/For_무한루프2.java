package test0204;

public class Fortest10 {
	public static void main(String[] args) {
		
		int count=0;
		
/*
 	float a=2000000000, b=2000000050; 
 	System.out.println(a==b); // true 
 				float형은 정밀도가 낮아 a와 b를 같은 숫자로 봐버림
 				-> 반복횟수에 쓰지 않는다.  
 				& 실수는 증감형으로 쓰지 않는다. 
 				  정확한 결과가 나오지 않을 수 있기 때문에 
 */		
		for(float f=2000000000; f<2000000000+50; f++) {
			count++;
		}
		System.out.println(count); // 0
	}
}
