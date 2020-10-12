# 반복문
### Break
- 반복문(while/do while/for), switch문 내의 **블록으로부터 빠져나오기 위해** 사용
- **if문에서는 절대 사용 X**  

- *break 라벨명:*
  - 반복문이 다중으로 작성된 경우 특정한 반복문을 빠져 나오기 위해 사용 
  - **빠져나오려는 반복문 윗줄에 <라벨명:>** 적어줌. 라벨명은 어떤 것이든 상관 X 
  - 한 프로그램에서 동일한 이름으로 라벨명 사용 불가 
  - **빠져나오려고 할 때 <break 라벨명;>** 

 [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/Break%20Ex)

#
### Continue 
- 반복문(while/do while/for)만 영향을 받음
- continue를 만나면 **다시 조건식으로 올라가라**는 뜻 

- *continue 라벨명:*
  - 반복문이 다중으로 작성된 경우 두개 이상의 반복문 조건식으로 올라가기 위해 사용되는
  - **다시 시행하려는 반복문 윗줄에 <라벨명:>**
    
 [관련 소스](https://github.com/friedegg818/TIL/tree/master/Java/%EC%86%8C%EC%8A%A4%20%ED%8C%8C%EC%9D%BC/Continue%20Ex)
