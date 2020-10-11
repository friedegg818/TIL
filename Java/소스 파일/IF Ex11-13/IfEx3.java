package test0203;

import java.util.Scanner;

public class IfEx3 {
	public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);
		String hak,name; // 학번.주민.우편.계좌번호 등은 반드시 문자열로 받아야 함 
		int s1, s2, absence, report;
		int score1, score2, attendscore, reportscore;
		int score;
		char grade; 
		
		System.out.print("학번?");
		hak=sc.next();
		System.out.print("이름?");
	    name=sc.next();
	    System.out.print("중간고사 점수?");
		s1=sc.nextInt();
		System.out.print("기말고사 점수?");
		s2=sc.nextInt();
		System.out.print("결석횟수?");
		absence=sc.nextInt();
		System.out.print("레포트 점수?");
		report=sc.nextInt();
		
		//환산점수 계산
		//중간,기말고사 		
		score1=(int)(s1*0.4);
		score2=(int)(s2*0.4);
		//결석점수
		if(absence>=6) 
			attendscore=0;
		else if (absence>=4)
	        attendscore=50;
	    else if (absence>=2)
	     	attendscore=80;
	    else 
	     	attendscore=100;
		attendscore=(int)(attendscore*0.1);
		//리포트점수
		reportscore=(int)(report*0.1);
		//총합
		score=score1+score2+attendscore+reportscore;
		//학점계산
		if(score>=90) grade='A';
		else if(score>=80) grade='B';
		else if(score>=70) grade='C';
		else if(score>=60) grade='D';
		else grade='F';
		//출력
		System.out.print("학번\t이름\t중간\t기말\t출석\t");
		System.out.println("리포트\t합산점수\t학점");
		System.out.print(hak+"\t"+name+"\t"+score1+"\t");
		System.out.print(score2+"\t"+attendscore+"\t");
		System.out.println(reportscore+"\t"+score+"\t"+grade);
		
		sc.close();
	  }
	}
	
