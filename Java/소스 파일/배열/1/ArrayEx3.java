package test0206;

public class ArrayEx3 {
	
	public static void main(String[] args) {
		int []score=new int[5]; // score �� �迭 (������ ����X) 
								// score���� ù ���� ��ġ(�ּ�)�� �־��� 
		int tot, ave;			// tot, ave �� ������ ���� 
		
		System.out.println(score); // �迭 �ּ�(�ؽ��ڵ�)��� 
		
		score[0]=60; score[1]=70; score[2]=80;
		score[3]=70; score[4]=80;
		
		tot=0;
		for(int i=0; i<score.length; i++) {
			tot += score[i];
		}
		ave = tot / score.length;
		
		System.out.println("��:"+tot);
		System.out.println("���:"+ave);
	}
}
