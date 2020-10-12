package test0204;

public class ForEx7 {
	public static void main(String[] args) {
		// A~Z 출력(단, 한줄에 5개씩)
		int cnt=0;
		for(char a='A'; a<='Z'; a++) {
			System.out.print(a+" ");
			if(++cnt%5==0) {
				System.out.println();
			}
		}
	}
}
