package test0206;

public class BreakEx2 {

	public static void main(String[] args) {
		//break labelName;
/*
		for(int i=1; i<=3; i++) {
			for(int j=1; j<=3; j++) {
				if(i+j==4) {
					break;     // �ι�° for�� ���������� break
				}
				System.out.println(i+","+j);   // 1,1  1,2  2,1
			}
		}
*/
		gogogo:
		for(int i=1; i<=3; i++) {
			for(int j=1; j<=3; j++) {
				if(i+j==4) {
					break gogogo; // ù��° for�� ���������� break
				}
				System.out.println(i+","+j);   // 1,1  1,2
			}
		}		
		
	}
}

