### Lotto 
- 1 ~ 45 사이 6개 숫자 
- 1등은 6개 , 2등은 5개 , 3등은 4개 , 4등은 3개 , 5등은 2개 그 이하는 꽝 


      import java.util.*; 

      public class Ex01 { 

          ArrayList<Integer> lottoList;                // 컴퓨터가 생성한 로또 배열
          ArrayList<Integer> userLottoList;            // 입력받는 로또 배열  

          public static void main(String[] args) {
              new Ex01().start();
          }  

          // 실행 시작   
          public void start() {      

              makeLottoList();                                    // 로또 당첨번호 생성하기
              ascList(lottoList);                                    // 오름차순 정렬
              printList(lottoList);                                // 결과 출력
              inputLotto();                                        // 유저 로또번호 입력 받기
              int result = compareList(lottoList, userLottoList);    // 당첨번호와 유저의 로또번호 비교
              printResult(result);                                // 최종 결과 출력

          }   

          // 금회차 로또번호 생성 메서드
          public void makeLottoList() {      

              lottoList = new ArrayList<>();              

              Random rnd = new Random();              

              while(lottoList.size()<=5) {           

                  int num = rnd.nextInt(45)+1;          

                  if(!isExist(lottoList, num)) {
                      lottoList.add(num);   
                  }         
              }

          }   

          // 유저 로또번호 입력받는 메서드
          public void inputLotto() {       

              userLottoList = new ArrayList<>();       

              Scanner scan = new Scanner(System.in);       

              System.out.println("당신의 로또 번호를 입력하세요");       

              int i=0;

              try {
                  while(userLottoList.size()<=5) {           

                      System.out.print(i+1+"번째 번호 입력 : ");     

                      int num = scan.nextInt();              

                      if(num>0&&num<46) {                            // 숫자가 1~45이면
                          if(!isExist(userLottoList, num)) {
                              userLottoList.add(num);
                              i++;
                          }else {
                              System.out.println("숫자가 중복됩니다! 다시 입력해주세요!");
                          }
                      }else {                                        // 숫자가 1~45가 아니면
                          System.out.println("1 ~ 45 사이의 숫자를 입력해주세요");
                      }              
                  }
              } catch (Exception e) {
                  System.out.println("1 ~ 45 사이의 숫자만 입력하세요.");
                  inputLotto();
              }
          }   

          // 당첨번호와 유저번호 비교 메서드
          public int compareList(ArrayList<Integer> lottoList, ArrayList<Integer> userList) {

              int result = 0;    // 맞은 숫자의 갯수      

              for(Integer i : lottoList) {
                  for(Integer j : userList) {
                      if(i==j) {
                          result++;
                          break;
                      }
                  }
              }      

              return result;     
          }   

          // 최종 결과 출력 메서드
          public void printResult(int result) {
              switch(result) {      

              case 6:
              case 5:
              case 4:
              case 3:
              case 2:
                  System.out.println("축하합니다! 당신은 "+ (7-result) +"등 입니다!!!");
                  break;
              default :
                  System.out.println("꽝입니다!");            
              }
          }  

          // 존재하는 숫자인지 판별 메서드
          public boolean isExist(ArrayList<Integer> list, int num) {
              boolean result = false;      

              for(Integer l : list) {
                  if(l==num) {
                      result=true;
                      break;
                  }
              }
              return result;
           }   

          // 오름차순 정렬 메서드
          public void ascList(ArrayList<Integer> list) {       

              for(int i=list.size()-1; i>=0; i--) {
                  for(int j=0; j<i; j++) {
                      if(list.get(j)>list.get(j+1)) {              

                          int temp = list.get(j);
                          list.remove(j);
                          list.add(j+1,temp);
                      }   
                  }
              }
          }   

          // 로또 번호 결과 출력 메서드
          public void printList(ArrayList<Integer> list) {

              System.out.print("이번주 당첨번호는 ");

              for(Integer result : list) {
                  System.out.print(result+" ");
              }
              System.out.println("입니다.");
          }
      }

