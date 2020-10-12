package test0207;

import java.util.Arrays;

public class ArrayEx9 {

	public static void main(String[] args) {
		// 1~45까지의 숫자 발생   
		// (int)(Math.random()*45)+1; 
		
		// int []num=new int[6];
		int []a = {4, 6, 8, 34, 33, 10};	
		
		Arrays.sort(a);
		for(int n : a) {
		System.out.print(n+" ");
		}
		
		System.out.println();
	
	} 
}
