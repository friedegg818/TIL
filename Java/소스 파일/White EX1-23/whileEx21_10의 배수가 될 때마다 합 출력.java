package test0203;

public class whileEx21 {
	public static void main(String[] args) {
		// 1~100까지 합을 출력하되 수가 10의 배수가 될 때마다 합 출력 
		// 1~10 : 55
		// 1~20 : 210
		//      :
		// 1~100 : 5050 
	
	int n, s;
	n=0;
	s=0;
	
	while (n<100) {
		++n;
		s+=n;
		
		if (n%10==0) {
			System.out.println("1~"+n+"까지 합:"+s);
		}  
		
	} 
	
	
	}
}

	