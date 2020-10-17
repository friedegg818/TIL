### final 
- 상수의 의미를 가지고 있는 키워드 (불변) 
- 자식 가질 수 x  (ex.String) 
- final 클래스 : 하위 클래스 가질 수 X 
- final 변수 " 한번만 초기값 부여. 필드에 붙이면 값을 바꿀 수 없음 (=상수). 대부분 static,대문자로 		   
- final 메소드 : 재정의 불가  

		public class Ex01_final {
			public static void main(String[] args) {
			}
		}

		/*
		final class Sam {  // final 클래스 : 하위 클래스를 가질 수 없다 
			int a; 
		}

		class Ex extends Sam { // 컴오류 
		}
		*/

		class Demo1 { 
			int a; 
			public final void print() { // 하위 클래스에서 메소드 재정의 불가 
				System.out.println(a);
			}
		}

		class Test1 extends Demo1 { 
			// public void print() {}   // 컴오류 

			final int x;   
			final int y=10; // 컴오류. final 변수는 반드시 한 번 초기화 필요 
					// 인스턴스 final 변수는 선언시/ 생성자/ 초기화 블럭에서 초기화 가능

			static final int A; 
			static final int B=10; 
					// static final 변수는 선언시 or static 초기화 블럭에서 초기화 해야함 
					// 생성자에서는 초기화 불가능 

			static {     // static 초기화 블럭 
				A=5; 
			}

			public Test1() {
				x=5; 	
			}	

			public void write() { 
				final int n=10; 
				// n=20; // 컴오류 . final 변수는 값 변경 불가 
				// x = 25; // 컴오류. final 변수는 값 변경 불가 
				System.out.println(x+":"+y+":"+n);
			}	
		}
