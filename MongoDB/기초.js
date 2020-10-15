c:\mongodb
c:\data\db 
생성


cmd> cd\mongodb\bin 

-- 몽고디비 서버 시작
c:\mongodb\bin> mongod (계속 열어두어야 함)

-- 몽고 쉘 클라이언트 
cmd> cd\mongodb\bin
c:\mongodb\bin > mongo

-- db 연결
> use mydb  (없으면 생성)

-- 연결된 db 확인
> db 

-- 하나의 데이터 추가 
> db.user.insert({"name":"홍길동", "age":20})
   -- user : 컬렉션 (테이블)

- 데이터 확인
> db.user.find()

-- 모든 db 목록 
> show dbs 

-- db 삭제 (db가 use된 상태)
> db.dropDatabase()

> db.close


-------------------------------------------------


-- 컬렉션 만들기 / 삭제 
> db.createCollection("user")
> show collections
> db.user.drop() 

-------------------------------------------------

-- 문서 추가 (insert, save) - 레코드 
> db.user.insert({"name":"홍길동", "age":20})
> db.user.find()


> var s = {
	"name" : "이자바", 
	"subject" : "자바란?",
	"content" : "객체지향프로그램",
	"created" : new Date("03/03/2020")
}

-- 콘솔에 변수의 내용 출력 
> printjson(s);

> db.user.insert(s);
> db.user.find();

---------------------------------------------------

var cs = "abcdefghijklmnopqrstuvwxyz";
> for(var i=0; i<cs.length; i++) {
	 var c = cs.substr(i,1);
	 var d = {char:c, code:c.charCodeAt(0)};
	 db.chars.save(d);
  }

> db.chars.find();  (처음 20개만 출력)
> it ;              (나머지 출력)
> db.chars.findOne( {char:'b'});


-- 문서 지우기 
> db.user.remove({name:"홍길동"})
> db.user.remove({});    (컬렉션의 모든 데이터 삭제)

-- 문서 수정
> db.user.update({"name":"홍길동"},{ $set : {"age":25} })
> db.user.update({age : {$gte:20} }, { $set : {score:50} }, {multi : true} )


---------------------------------------------------


> s = {
... name : "너자바",
... food1 : "사과",
... food2 : "오렌지"
... }

> db.mycoll.insert(s)
> db.mycoll.find()

> var temp = db.mycoll.findOne( {name:"너자바"} )
> printjson(temp)

> temp.my = temp.name;

> delete temp.my 

> temp.username = temp.name
> delete temp.name
> temp.menu = {food1 : temp.food1 , food2 : temp.food2 }
> delete temp.food1
> delete temp.food2

> db.mycoll.findOne({name:"너자바"})
> db.mycoll.update( {name: "너자바"}, temp)
> db.mycoll.findOne( {username : "너자바"} )
> db.mycoll.find()

-- 이름이 '가가가'인 사람 중 subject와 content만 출력 
> db.user.find({name:'가가가'}, {subject:1, content:"1"}).pretty() 

-- 이름이 '가가가'이고 나이가 27인 사람 (AND)
> db.user.find({name:'가가가', age:27})
> db.user.find({$where:"this.name=='가가가' && this.age==27"})

-- where는 연산도 가능 
> db.user.find({$where:"this.age + 5 >= 30" })

-- 이름이 '가가가' 이거나 age가 30인 사람 (OR)
> db.user.find({$or : [{name:'가가가'}, {age:30}] })

- 나이가 20, 25, 30인 사람의 이름만 (IN)
> db.user.find({age : {$in : [20, 25, 30]}}, {name:1})
  

> db.mycoll.insert({name : "다자바", age : 20})
> temp = db.mycoll.findOne({age:20})
> temp.age++;
>  db.mycoll.update({age : 20}, temp)

-- $set : 없으면 추가, 있으면 수정 
> db.mycoll.update({name:"다자바"}, {"$inc" : {age : 6} })
> db.mycoll.update({name:"다자바"}, {$set : {tel:"010-0000-0000"}})

-- tel 필드 제거 
> db.mycoll.update({name:"다자바"}, {$unset : {tel:1}})


-- 배열 추가

> db.mycoll.update({name:"다자바"}, {$push : {fruit : {{"1":"바나나", "2":"오렌지"}}});
> db.mycoll.update({name:"다자바"}, {$push : {fruit : "사과"} })
> db.mycoll.insert({subject : ["자바", "스프링", "오라클"] })

-- 배열 제거 
> db.mycoll.update({name:"다자바"}, {$pull: {fruit:"사과"}})


-- 배열 요소중 c++ 과 java가 모두 있는 것 
> db.mycoll.find({subject : {$all : ["c++", "java"]}}).pretty()

-- 요소 개수가 3개인 것
> db.mycoll.find({subject : {$size:3}}).pretty()




-- 영문자 A~Z까지 저장하기
> for(var i=65; i<=90; i++) 
	{ var c = String.fromCharCode(i);
	  var d = {char : c, code : c.charCodeAt(0)}; 
	  db.chars.save(d); }

> var cursor = db.chars.find()
> var obj
> while( cursor.hasNext() ) {
	obj = cursor.next();
	printjson(obj);
	}
	
-- 0~16번까지 출력 
> db.chars.find().limit(17)

-- 앞에 17개 스킵 후 출력
> db.chars.find().skip(17)

> db.chars.find().skip(10).limit(5)


-- 정렬 
 -- 나이 오름차순 
 > db.user.find().sort({age : 1})
 -- 나이 내림차순
 > db.user.find().sort({age : -1})


-- 집계
> db.user.find().count()


