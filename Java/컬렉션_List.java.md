# 컬렉션

### 컬렉션 프레임워크
- 다수의 데이터 저장소.  
- 다수의 데이터를 쉽고 효율적으로 처리 할 수 있는 표준화된 방법을 제공

      - 인터페이스 : 설계도. 데이터 관리 기능 (메소드)
      - 구현 
      - 알고리즘 

#
## List<E>인터페이스
 - 순서 있음
 - 요소 삽입 위치 제어 가능 
 - 요소를 인덱스로 관리(0~), 인덱스로 검색 or 삭제 가능 
 - 중복 저장 가능 
 - null도 저장 가능 
 - ArrayList 가 대표적 

### ArrayList
 - List 인터페이스 구현한 클래스 
 - 배열과 가장 유사 
 - 메모리가 허용 할 때까지 추가 가능
 - 인덱스로 접근한다.
 - 추가와 삭제가 빈번한 경우 성능 저하 발생 
 - 검색시 속도 빠름 
 - 동기화 X (멀티 스레드 환경에서 안전 X)
 
		import java.util.ArrayList;
		import java.util.Iterator;
		import java.util.List;
		import java.util.ListIterator;

		public class Ex01_arraylist {
			public static void main(String[] args) {
				// ArrayList : List 인터페이스 구현 클래스 
				//			      배열과 가장 유사 
				List<String> list = new ArrayList<>(); // 업 캐스팅 
				String s;

				list.add("서울");	// 메모리가 허용 할 때까지 추가 가능 
				list.add("부산");
				list.add("대구");
				list.add("인천");
				list.add("광주");
				list.add("대전");

				System.out.println("개수 : "+list.size());

				// 처음 
				s = list.get(0);				// 인덱스로 접근 
				System.out.println("처음 : "+s);

				// 두번째
				s = list.get(1);
				System.out.println("두번째 : "+s);

				// 마지막
				s = list.get(list.size()-1); 
				System.out.println("마지막 : "+s);		

				// 처음에 한국 추가 
			    list.add(0, "한국");
			    System.out.println(list);

			    // 0번째 인덱스 변경 
			    list.set(0, "대한민국"); 
			    System.out.println(list);

			    // 인천 인덱스 ? 
			    System.out.println("인천 인덱스 : " + list.indexOf("인천"));

			    // 세종 인덱스?
			    System.out.println("세종 인덱스 : " + list.indexOf("세종"));  // 없으면 -1 

			    // 부산 존재 여부 
			    System.out.println("부산 있나요? "+list.contains("부산"));

			    // 대한민국 삭제 
			    list.remove(0); 
				// or list.remove("대한민국");
			    System.out.println(list); 	

			    // 전체 출력
			    System.out.println("전체-1");
			    for(int i=0; i<list.size(); i++) {
				System.out.print(list.get(i)+" ");
			    }
			    System.out.println();

			    System.out.println("전체-2");
			    for(String str:list) {
				System.out.print(str+" ");
			    }
			    System.out.println();

			    System.out.println("전체-3");
			    Iterator<String> it = list.iterator(); // Iterator(반복자) : 인터페이스. 처음부터 끝까지 순회 하며 데이터를 가져옴 
												   // Hashmap 에서 가끔 사용함 
			    while(it.hasNext()) {
				String str = it.next();
				System.out.print(str+" ");
			    }
			    System.out.println();

			    // 전체 역순 출력 
			    System.out.println("역순-1");
			    for(int i=list.size()-1; i>=0; i--) {
				System.out.print(list.get(i)+" ");
			    }
			    System.out.println();

			    System.out.println("역순-2");
			    ListIterator<String> it2 = list.listIterator(list.size()); // 뒤에서부터 가져와야 하므로 list.size()입력하여 맨 뒤로 보냄
			    while(it2.hasPrevious()) {
				String str = it2.previous();
				System.out.print(str+" ");
			    }
			    System.out.println();
			}
		}
#
		import java.util.ArrayList;
		import java.util.Arrays;
		import java.util.List;

		public class Ex01_arraylist {
			public static void main(String[] args) {
				List<String> list1 = new ArrayList<String>();
				list1.add("서울");
				list1.add("부산");
				list1.add("대구");

				List<String> list2 = new ArrayList<String>();
				list2.add("강원");
				list2.add("경기");
				list2.add("경상");

				// list2에 list1의 모든 데이터를 추가 
				list2.addAll(list1);
				System.out.println(list2);

				// List => String[] 으로 변환 
				String[] ss = list2.toArray(new String[list2.size()]);
				System.out.println("리스트를 배열로...");
				for(String s : ss) {
					System.out.print(s+" ");
				}
				System.out.println();

				// String[] => List 로 변환
				List<String> list3 = Arrays.asList(ss);
				System.out.println("리스트 변환 후 : " + list3);

				// subList(a,b) : a인덱스에서 b-1 부분의 List  
				List<String> list4 = list2.subList(2, 5);
				System.out.println(list4);

				// 전체삭제
				list1.clear();
				System.out.println("전체 삭제 후 " + list1.size());

				// list3의 경상, 서울, 부산 삭제 
				System.out.println("삭제전:"+list2);
				list2.subList(2, 5).clear();
				System.out.println("삭제후:"+list2);		
			}
		}
#

### LinkedList
 - List 및 Deque 인터페이스를 구현한 클래스
 - 추가와 삭제가 빈번한 경우 ArrayList 보다 빠름
 - 검색 느림 
 - 동기화 X (멀리스레드 환경에서 안전 X) 
 - 메소드는 ArrayList와 거의 동일하게 사용된다. 

		import java.util.LinkedList;
		import java.util.List;

		public class Ex02_LinkedList {
			public static void main(String[] args) {

			List<String>list = new LinkedList<String>(); 
			list.add("서울");
			list.add("부산");
			list.add("대구");

			System.out.println(list.get(0));

			}
		}
#
### Vector
 - List 인터페이스를 구현한 클래스 
 - 동기화 O (멀티스레드 환경에서 안전) 

		import java.util.Iterator;
		import java.util.Vector;

		public class Ex04_Vector {
			public static void main(String[] args) {
				// ArrayList : 동기화 지원 안 함 
				// Vector : 동기화 지원(멀티스레드에서 안전) 
				// List<String> list = new Vector<String(); <- 상관 X
				Vector<String> list = new Vector<String>(); // Vector가 가지고 있는 list가 더 많음

				System.out.println("초기용량  : "+list.capacity()); // 10

				list.add("a1");
				list.add("a2");
				list.add("a3");
				list.add("a4");
				list.add("a5");
				list.add("a6");
				list.add("a7");
				list.add("a8");
				list.add("a9");
				list.add("a10");
				list.add("a11");
				list.add("a12");
				list.add("a13");
				list.add("a14");
				list.add("a15");

				System.out.println("개수:"+list.size()); // 15
				System.out.println("용량:"+list.capacity()); // 20 > 용량이 부족하면 10개씩 늘어남 

				list.add(0, "korea");
				System.out.println(list);

				// 처음과 마지막 출력 
				System.out.println("처음:"+list.get(0));
				System.out.println("처음:"+list.firstElement());

				System.out.println("마지막:"+list.get(list.size()-1));
				System.out.println("마지막:"+list.lastElement());

				// 내용 바꾸기 
				list.set(0, "대한민국");
				System.out.println(list);

				// 전체 리스트 
				System.out.println("전체-1");
				for(String s : list) {
					System.out.print(s+" ");
				}
				System.out.println();

				System.out.println("전체-2");
				for(int i=0; i<list.size(); i++) {
					System.out.print(list.get(i)+" ");
				}
				System.out.println();

				System.out.println("전체-3"); // 역순은 안됨 
				Iterator<String> it = list.iterator();
				while(it.hasNext()) {
					String s = it.next();
					System.out.print(s + " ");
				}
				System.out.println();

				// 역순 리스트 
				System.out.println("역순");
				for(int i=list.size()-1; i>=0; i--) {
					System.out.print(list.get(i)+" ");
				}
				System.out.println();

				// 인덱스 위치 (없으면 -1) 
				int idx = list.indexOf("a7");
				System.out.println("a7 인덱스 : "+idx);

				// 삭제 
				list.remove(3); 
				list.remove("a7");

				list.clear(); 

				System.out.println("개수 : "+list.size()); // 0
				System.out.println("용량 : "+list.capacity()); // 20 (용량은 바뀌지 않았음)

				// 용량을 개수로 조정 
				list.trimToSize();
				System.out.println("용량 : " + list.capacity()); // 0 
			}
		}
#
### Stack 
 - LIFO 구조 
 - List 인터페이스를 구현한 클래스 
 - Vector의 하위 클래스 

		// STACK : LIFO 구조 
		public class Ex02_stack {
			public static void main(String[] args) {
				// Stack : Vector의 하위 클래스 
				Stack<String> st = new Stack<>();

				// 스택에 데이터 추가 
				// push() : 추가 
				st.push("검정");	  
				st.push("노랑");
				st.push("녹색");
				st.push("청색");
				st.push("빨강");

				// 스택 데이터 가져오기 
				// pop() : top 요소 반환 후 삭제
				// peek() : top 요소 반환 후 삭제하지 않음 
				while(!st.empty()) {
					String s = st.pop(); 
					System.out.print(s+" ");
				}
				System.out.println();
			}
		}

#

### Collections

#### Collections를 사용한 정렬

	import java.util.ArrayList;
	import java.util.Collections;
	import java.util.List;

	public class Ex05_Collections {
		public static void main(String[] args) {
			List<String> list = new ArrayList<String>();

			list.add("서울");
			list.add("부산");
			list.add("대구");
			list.add("인천");
			list.add("광주");
			list.add("대전");
			list.add("울산");
			list.add("세종");
			System.out.println(list);

			int idx;
			// 순차검색
			idx = list.indexOf("부산");
			System.out.println("부산 위치 : "+idx);

			// 크기순으로 정렬 : Comparable 인터페이스가 구현된 클래스만 가능 
			Collections.sort(list);
			System.out.println("정렬 후 : "+list);

			// 이분 검색(정렬되어 있어야 가능) : 없으면 -1  // 데이터가 많을 수록 속도가 빨라짐 
			idx = Collections.binarySearch(list, "서울");
			System.out.println("서울 위치 : "+idx);

			// 역순 정렬
			Collections.sort(list, Collections.reverseOrder());
			System.out.println("역순 후 : "+list);
		}
	}
#
	public class Ex06 {
		public static void main(String[] args) {
			List<UserVO> list = new ArrayList<UserVO>();
			list.add(new UserVO("도도도", "010", 25));
			list.add(new UserVO("후후후", "011", 20)); 
			list.add(new UserVO("가가가", "012", 22)); 
			list.add(new UserVO("마마마", "013", 25)); 
			list.add(new UserVO("마가가", "014", 23)); 	

			print("정렬 전...",list);

			Collections.sort(list); // Comparable 인터페이스가 구현되지 않았음 (정렬 기준이 없다)

			print("정렬 후...",list);		
		}

		public static void print(String title, List<UserVO> list) { // 출력 쉽게 하기 위해 만든 static 메소드
			System.out.println(title);

			for(UserVO vo : list) {
				System.out.print(vo.getName()+"\t");
				System.out.print(vo.getTel()+"\t");
				System.out.print(vo.getAge()+"\n");

			}
			System.out.println();
		}
	}

	class UserVO implements Comparable<UserVO> { 
		private String name;
		private String tel;
		private int age;

		public UserVO() {
		}	
		public UserVO(String name, String tel, int age) {
			this.name=name;
			this.tel=tel;
			this.age=age;
		}

		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}

		// compareTO : Comparable 메소드로 정렬 기준을 설정한다. 
		@Override
		public int compareTo(UserVO o) {
			// String 클래스의 compareTo() : 문자열을 사전식으로 비교 
			// return name.compareTo(o.getName()); // 이름 오름차순 
			// return - name.compareTo(o.getName()); // 이름 내림차순
			return age - o.getAge(); // 나이 오름차 
		}	
	}
#
	public class Ex07 {
		public static void main(String[] args) {
			List<UserDTO> list = new ArrayList<UserDTO>();
			list.add(new UserDTO("도도도", "010", 25));
			list.add(new UserDTO("후후후", "011", 20)); 
			list.add(new UserDTO("가가가", "012", 22)); 
			list.add(new UserDTO("마마마", "013", 25)); 
			list.add(new UserDTO("마가가", "014", 23)); 	

			print("정렬 전...",list);

			// 크기순으로 정렬
			// 이름 정렬 
			// Comparator 인터페이스 구현 : 정렬 기준 설정 
			Comparator<UserDTO> comp = new Comparator<UserDTO>() {
				@Override
				public int compare(UserDTO o1, UserDTO o2) {				
					return o1.getName().compareTo(o2.getName());
				}
			};
			Collections.sort(list,comp);

			print("이름 정렬 후...",list);		

			// 나이 정렬 
			Comparator<UserDTO> comp2 = new Comparator<UserDTO>() {
				@Override
				public int compare(UserDTO o1, UserDTO o2) {
					return o1.getAge() - o2.getAge();
				}
			};
			Collections.sort(list, comp2);
			print("나이 정렬 후...", list);

		}

		public static void print(String title, List<UserDTO> list) { // 출력 쉽게 하기 위해 만든 static 메소드
			System.out.println(title);

			for(UserDTO vo : list) {
				System.out.print(vo.getName()+"\t");
				System.out.print(vo.getTel()+"\t");
				System.out.print(vo.getAge()+"\n");

			}
			System.out.println();
		}
	}

	class UserDTO  { 
		private String name;
		private String tel;
		private int age;

		public UserDTO() {
		}	
		public UserDTO(String name, String tel, int age) {
			this.name=name;
			this.tel=tel;
			this.age=age;
		}

		public String getName() {
			return name;
		}
		public void setName(String name) {
			this.name = name;
		}
		public String getTel() {
			return tel;
		}
		public void setTel(String tel) {
			this.tel = tel;
		}
		public int getAge() {
			return age;
		}
		public void setAge(int age) {
			this.age = age;
		}	
	}

