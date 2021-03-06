# SQL 
**구조화 된 쿼리 언어 (Structured Query Language)**
- 데이터베이스 자체를 나타내는 것은 아님 
- 특정 유형의 데이터베이스와의 상호 작용에 사용하는 쿼리 언어
- 관계형 데이터베이스 관리 시스템(RDBMS)에서 데이터를 저장/수정/삭제/검색할 수 있음 
> RDBMS 주요 특징
>  - 데이터는 정해진 스키마(Structure)를 따라 데이터베이스 테이블에 저장 → 스키마를 준수하지 않는 레코드는 추가 불가 
>  - 데이터는 관계를 통해서 연결된 여러 개의 테이블에 분산 됨 
>  - 각각의 테이블들은 다른 테이블에 저장되지 않은 데이터만을 가지고 있음 → **중복된 데이터가 없음**
- 수직적 확장만을 지원 
> 수직적 확장 : 단순히 데이터베이스 서버의 성능을 향상 시키는 것 
- MySQL, PostgreSQL 등 

<br>

# NoSQL 
**비관계형 데이터베이스**
- 기본적으로 SQL과 반대되는 접근 방식을 따름 → **스키마/관계 없음** 
- NoSQL에서 레코드는 문서(Documents) , 문서는 JSON과 비슷한 형태
* 다른 구조의 데이터를 같은 컬렉션(SQL의 테이블)에 추가 가능 
* 일반적으로 관련 데이터를 동일한 컬렉션에 넣음 
  
    * 여러 테이블/컬렉션에 JOIN할 필요가 없음 (JOIN 이라는 개념 X) 
    * 그 대신, 컬렉션을 통해 데이터를 복제하여 각 컬렉션 일부분에 속하는 데이터를 정확하게 산출하도록 함 
    * 데이터가 **중복되기 때문에 불안정한 측면**이 있음 
    * 특정 데이터를 같이 사용하는 모든 컬렉션에서 **똑같은 데이터 업데이트**를 수행해야 함 
    
- 수직적, 수평적 확장이 모두 가능 
> 수평적 확장 : 더 많은 서버가 추가되고 데이터베이스가 전체적으로 분산 되는 것 
- MongoDB, HBASE, cassandra 등 


<br>


# 요약 

## SQL의 장/단점
### 장점 
- 명확하게 정의된 스키마
- 데이터의 무결성 보장 
- 각 데이터는 중복 없이 한번만 저장됨 

### 단점 
- 상대적으로 덜 유연함 
- 데이터 스키마는 사전에 계획되고 알려져야 함 (나중에 수정하기 번거롭거나 불가능할 수 있기 때문에) 
- 관계를 맺고 있어서 JOIN문이 많은, 매우 복잡한 쿼리가 만들어질 수 있음 
- 수평적 확장이 어렵고 대체로 수직적 확장만 가능하여, 어떤 시점에서 성장 한계에 직면할 수 있음 

### 사용하면 좋은 경우
- 관계를 맺고 있는 데이터가 자주 변경 되는 애플리케이션일 경우 
- 변경될 여지가 없고 명확한 스키마가 사용자와 데이터에게 중요한 경우 

<br>


## NoSQL의 장/단점 
### 장점 
- 스키마가 없어서 훨씬 더 유연함 → 언제든지 저장된 데이터를 조정하고 새로운 필드 추가 가능 
- 데이터가 애플리케이션이 필요로 하는 형식으로 저장됨 → 데이터를 읽어 오는 속도가 빨라짐 
- 수직 및 수평 확장이 가능 → 데이터베이스가 애플리케이션에서 발생시키는 모든 읽기/쓰기 요청을 처리할 수 있음

### 단점 
- 유연성으로 인해 데이터 구조 결정을 하지 못하고 미루게 될 수 있음
- 데이터가 여러 컬렉션에 중복되어있어서, 수정을 해야하는 경우 모든 컬렉션에서 수행해야 함 

### 사용하면 좋은 경우 
- 정확한 데이터 구조를 알 수 없거나 변경/확장될 수 있는 경우 
- 읽기 처리를 자주 하지만 데이터를 자주 변경하지는 않는 경우 
- 막대한 양의 데이터를 다뤄야 하는 경우 (데이터베이스 수평 확장) 

#

> 위의 사항들은 기본적인 특징이며, 데이터 베이스는 다른 방식으로 설계될 수 있으므로 각각의 장단점은 강화 or 완화될 수 있다. 
