package test0206;

public class ArrayEx3 {
	
	public static void main(String[] args) {
		int []score=new int[5]; // score → 배열 (정수형 변수X) 
								// score에는 첫 방의 위치(주소)만 넣어줌 
		int tot, ave;			// tot, ave → 정수형 변수 
		
		System.out.println(score); // 배열 주소(해쉬코드)출력 
		
		score[0]=60; score[1]=70; score[2]=80;
		score[3]=70; score[4]=80;
		
		tot=0;
		for(int i=0; i<score.length; i++) {
			tot += score[i];
		}
		ave = tot / score.length;
		
		System.out.println("합:"+tot);
		System.out.println("평균:"+ave);
	}
}
