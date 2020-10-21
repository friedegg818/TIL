# 
## Set<E>인터페이스 

### Set
 - 순서를 유지하지 않는 데이터의 집합
 - 중복 허용 안함 ★
 - 하나의 null만 저장 가능 
 - 주요 구현 클래스
 
       - HashSet : 무작위로 저장 
       - LinkedHashSet : 순서대로 저장 
       - TreeSet : 정렬 가능 (Comparable 인터페이스를 구현 할 때)   > 데이터 개수가 많을 때는 속도가 너무 느려짐 
   
		public class Ex08_hashset {
			public static void main(String[] args) {
				// Set : 중복 허용 안함. 
				// HashSet : 순서가 없음
				Set<String> set = new HashSet<String>(); 
				set.add("서울"); 
				set.add("부산");
				set.add("대구");
				set.add("인천");
				set.add("광주");
				set.add("대전");
				set.add("울산");
				set.add("세종");
				set.add("서울"); // 이전 서울을 덮어쓴다. 

				System.out.println(set); // 중복 없이 무작위 순서로 출력. 

				for(String s : set) {
					System.out.print(s+" ");
				}
				System.out.println();
			}
		}
#
		<TreeSet 이용하여 로또 만들기>

		import java.util.Random;
		import java.util.Set;
		import java.util.TreeSet;

		public class Ex11_lotto {
			public static void main(String[] args) {
				Set<Integer> set = new TreeSet<Integer>();
				Random rd = new Random(); 
				int num; 

				while(set.size()<6) { 
					num = rd.nextInt(45)+1; 
					set.add(num);
				}

				System.out.println(set);
			}
		}
#
		<TreeSet 이용한 정렬>

		import java.util.Set;
		import java.util.TreeSet;

		public class Ex12 {
			public static void main(String[] args) {
				Set<TestVO> set = new TreeSet<TestVO>(); 

				set.add(new TestVO("너너너",20));
				set.add(new TestVO("후후후",25));
				set.add(new TestVO("바바바",23));

				for(TestVO vo : set) {
					System.out.print(vo.getName()+"\t"+vo.getAge()+"\n");
				}
				System.out.println();
			}
		}
#
		class TestVO implements Comparable<TestVO> { 
			private String name; 
			private int age; 

			public TestVO() {		
			}

			public TestVO(String name, int age) { 
				this.name=name;
				this.age=age;		
			}

			public String getName() {
				return name;
			}

			public void setName(String name) {
				this.name = name;
			}

			public int getAge() {
				return age;
			}

			public void setAge(int age) {
				this.age = age;
			}

			@Override
			public int compareTo(TestVO o) { // Comparable의 compareTo
				// 이름순(오름차) 
				return name.compareTo(o.getName()); // String의 compareTo
			}	
		}
