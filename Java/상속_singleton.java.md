### Singleton
- 해당 클래스의 인스턴스를 하나만 만들고, 어디서든지 접근 가능 하게 하는 패턴
- 생성자를 private로 선언 → 인스턴스 접근 위한 public 메소드 제공 
- 공통된 객체가 필요한 경우 사용 [전역 인스턴스] 

		public class Ex02_singleton {
			public static void main(String[] args) {
			 // SingletonEx1 ob = new Singletonex1(); // 컴오류
		         // 생성자가 private 
				SingletonEx1 ob1 = SingletonEx1.getInstance();
				SingletonEx1 ob2 = SingletonEx1.getInstance();

				System.out.println(ob1==ob2);  // true 

				ob1.print();

			}
		}

		class SingletonEx1 {  // 객체를 하나만 생성하고 더이상 생성하지 못하게 할 때 사용 
			private static SingletonEx1 inst; 

			private SingletonEx1() {  // 1.생성자를 private으로 만든다
			}

			public static SingletonEx1 getInstance() { // 2.객체를 생성하는 class 메소드를 만든다
				if(inst==null) {
					inst = new SingletonEx1(); 
				}
				return inst;
			}

			public void print() {
				System.out.println("Singleton 패턴 예제 1...");
			}
		}
#
		public class Ex03 {
			public static void main(String[] args) {
				SingletonEx2 ob1 = SingletonEx2.getInstance();
				SingletonEx2 ob2 = SingletonEx2.getInstance();
				System.out.println(ob1==ob2);       // true 
			}
		}

		class SingletonEx2 {  // 진정한 의미의 Singleton 
			private SingletonEx2() {
			}

			// static 중첩 클래스 _ 멀티쓰레드 환경에서도 객체를 하나만 생성 가능
			private static class Holder {
				public static final SingletonEx2 INST = new SingletonEx2();
			}

			public static SingletonEx2 getInstance() {
				return Holder.INST;
			}
		}
