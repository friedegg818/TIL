# 
## Map
- (키, 값) 으로 구성  > 키 하나에 값 하나 
- 중복 허용 X 
- put / get / remove / size 
- map 자체에는 반복자가 없어서 key 값에서 set을 불러 반복자를 사용함

### HashMap 
   - 동시성 지원 안 함 

         private Map<String, ScoreVO> map = new HashMap<>(); 
  
### Hashtable
  - 동시성 지원 (멀티 스레드에서 안전)
  - 속도 느림 
  
        private Map<String, ScoreVO> map = new Hashtable<>()
  
### TreeMap 
  - 키로 정렬
  - 단, 키를 나타내는 클래스는 Comparable 인터페이스가 구현 되어 있어야 함 
  - 동시성 지원 안 함
  
### Map.Entry 
 - 키와 값을 Set 형태로 저장하기 위해 사용
 
### LinkedHashMap 
 - 순서 유지 


		public class Ex14_Map {
			public static void main(String[] args) {
				// Map : (키, 값) 구조
				//	키는 중복을 허용하지 않음. 순서가 없음
				//  HashMap : 동기화 지원하지 않음
				Map <String, Integer> map = new HashMap<>();					
				// map에 값 저장 
				map.put("서울", 1000);
				map.put("부산", 350);
				map.put("대구", 250);
				map.put("인천", 300);
				map.put("광주", 150); 
				map.put("대전", 150); 
				map.put("울산", 110); 
				map.put("세종", 20); 	
				map.put("서울", 990); // 키가 같으면 기존값 덮어씀
				System.out.println(map);

				// map에서 키의 값 가져오기 
				int a = map.get("서울");
				System.out.println(a);

				// Map에는 Iterator(반복자)가 없으며, 향상된 for문도 사용 할 수 없다.
				// Set<String> set = map.keySet(); 는 키에서 Set 객체를 반환하므로 
				// 키의 Set 객체를 이용하여 처음부터 끝까지 순회 할 수 있다.

				Iterator <String> it = map.keySet().iterator();
				while(it.hasNext()) { 
					String key = it.next(); 	// 키
					Integer value = map.get(key);	// 값 
					System.out.println(key+":"+value);
				}

				System.out.println("키에 서울 존재 ? " + map.containsKey("서울")); // true
				System.out.println("키에 경기 존재 ? " + map.containsKey("경기")); // false 
				System.out.println("값에 350 존재 ? " + map.containsValue(350)); // true 

				System.out.println("전체개수:"+map.size());

				map.remove("세종"); // 키가 세종인 데이터 삭제
				System.out.println(map);
			}
		}
