package test0131;

public class IfEx1 {
	public static void main(String[] args) {
		// 정수에 대한 절대값 구하기 
		int n;
		n=-10;
		if(n<0) // if(조건식)
			n=-n;
		System.out.println("절대값:"+n);
	}
}
