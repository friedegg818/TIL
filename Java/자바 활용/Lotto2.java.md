### Lotto 프로그램 
- 1~45 사이의 숫자 6개 + 보너스 숫자 1개 추첨 
- 로또 등수 
  
       1등 6개 일치 
       2등 5개 + 보너스번호 일치 
       3등 5개 일치 
       4등 4개 일치 
       5등 3개 일치 


- Lotto.java

      import java.util.*; 

      public class Lotto {
        private ArrayList<Integer> lotto;

        public Lotto(ArrayList<Integer> lotto) { 
            this.lotto = lotto; 
         } 

        public ArrayList<Integer> getLotto() { 
            return lotto; 
        }

        public void setLotto(ArrayList<Integer> lotto) {
            this.lotto = lotto; 
        } 

        @Override public String toString() { 
            String info = ""; 

            for(Integer a : lotto) { 
                info += " "+a; 
            } 

            return info; 
            } 
       }


