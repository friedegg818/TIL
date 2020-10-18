### 피보나치수열

	// ------------------------------------------------
	// 피보나치수열 : 1+1+2+3+5+8+13+21
	public class Fibonacci {
	    public static void main(String[] args) {
		int a=1, b=1, c;
		int s=2;

		int n=2;
		while(n<8) {
		    c=a+b;
		    s=s+c;

		    a=b;
		    b=c;
		    n++;
		}
		System.out.println("결과 : " + s);
	    } // main_end
	}

#
### 두수를 입력받아 최대 공약수 구하기
	// ------------------------------------------------
	// 재귀 호출 이용
	import java.util.Scanner;

	public class RecursionGcd {
	    public static int gcd(int a, int b) {
		return (b == 0) ? a : gcm(b, a%b);
	    }

	    public static void main(String args[]) {
		Scanner sc=new Scanner(System.in);

		int a, b, c;

		System.out.print("첫번째 수  ? ");
		a = sc.nextInt();

		System.out.print("두번째 수  ? ");
		b = sc.nextInt();

		c = gcd(a, b);
		System.out.println("결과 : " + c);
	    }
	}

	// ------------------------------------------------
	// while 문 : 유크리드 호제법
	public class  WhileEuclid {
	    public static void main(String[] args) {
		Scanner sc=new Scanner(System.in);

		int num1, num2, result;
		System.out.print("두수 ? ");
		num1 = sc.nextInt();
		num2 = sc.nextInt();

		while(num1 != num2) {
		    if(num1>num2)
			num1=num1-num2;
		    else
			num2=num2-num1;
		}
		System.out.println("최대공약수 : "+num1);
	    }
	}

#
### 1~100 까지 합구하기(짝수, 홀수등)

	// ------------------------------------------------
	// 100까지 합 : while
	public class  Test {
		public static void main(String[] args) {
			int s, n;
			s=0;
			n=0;
			while(n<100) {
				n++;
				s+=n;
			}
		       System.out.println("합 : " +s);
		}
	}

	// ------------------------------------------------
	// 100까지 합 : for
	public class  Test {
		public static void main(String[] args) {
			int s, n;
			s=0;
			for(n=1; n<=100; n++) {
				s+=n;
			}
		       System.out.println("합 : " +s);
		}
	}

	// ------------------------------------------------
	// 100까지 홀수 합 : for
	public class  Test {
		public static void main(String[] args) {
			int s, n;
			s=0;
			for(n=1; n<=100; n+=2) {
				s+=n;
			}
		       System.out.println("합 : " +s);
		}
	}

	// ------------------------------------------------
	// 100까지 짝수 합 : for
	public class  Test {
		public static void main(String[] args) {
			int s, n;
			s=0;
			for(n=2; n<=100; n+=2) {
				s+=n;
			}
		       System.out.println("합 : " +s);
		}
	}

#
### 삼각형 모향 별찍기

	// ------------------------------------------------
	*
	*
	**
	***
	****
	*****

	public class  Test {
		public static void main(String[] args) {
			int a, b;

			for(a=1; a<=5; a++) {
				for(b=1; b<=a; b++) {
					System.out.print("*");
				}
				System.out.println();
			}
		} // main_end
	}


	// ------------------------------------------------
		*
	      **
	    ***
	  ****
	*****

	public class  Test {
		public static void main(String[] args) {
			int a, b;

			for(a=1; a<=5; a++) {
				for(b=1; b<=5-a; b++) {
					System.out.print(" ");
				}
				for(b=1; b<=a; b++) {
					System.out.print("*");
				}
				System.out.println();
			}
		} // main_end
	}

	// ------------------------------------------------
	       *
	     ***
	    *****
	  *******
	*********

	public class  Test {
		public static void main(String[] args) {
			int a, b;

			for(a=1; a<=5; a++) {
				for(b=1; b<=5-a; b++) {
					System.out.print(" ");
				}
				for(b=1; b<=a*2-1; b++) {
					System.out.print("*");
				}
				System.out.println();
			}
		} // main_end
	}

	// ------------------------------------------------
	       *
	     ***
	    *****
	  *******
	*********
	  *******
	    *****
	     ***
	       *

	public class  Test {
		public static void main(String[] args) {
			int a, b;

			for(a=1; a<=5; a++) {
				for(b=1; b<=5-a; b++) {
					System.out.print(" ");
				}
				for(b=1; b<=a*2-1; b++) {
					System.out.print("*");
				}
				System.out.println();
			}
			for(a=4; a>=1; a--) {
				for(b=1; b<=5-a; b++) {
					System.out.print(" ");
				}
				for(b=1; b<=a*2-1; b++) {
					System.out.print("*");
				}
				System.out.println();
			}
		} // main_end
	}
#
	// ------------------------------------------------
	// 다이아몬드
	public class Star1 {
		public static void main(String args[]) {
			int size = 5; // 홀수만 가능
			int st = 0;

			st = size/2;
			for (int i = 0; i < size; i++) {
				for (int j = 0; j < (size - st); j++) {
					System.out.print((j >= st) ? "*" : " ");
				}
				st = i < (size / 2) ? st - 1 : st + 1;
				System.out.println();
			}
		}
	}

#
### 구구단

	// ------------------------------------------------
	// 구구단
	public class  Test {
		public static void main(String[] args) {
			int a, b;

			for(a=2; a<=9; a++) {
				System.out.println(a + "단");
				for(b=1; b<=9; b++) {
					System.out.printf("%d * %d = %d%n", a, b, a*b);
				} // for(b=1; b<=9; b++)_end
				System.out.println();
			} // for(a=2; a<=9; a++)_end
		} // main_end
	}

#
### JDBC를 이용한 SELECT, INSERT, UPDATE, DELETE 등

	// ------------------------------------------------
	// INSERT

	String url  = "jdbc:oracle:thin:@localhost:1521:ORCL";
	String user = "scott";
	String pwd = "tiger";

	Connection conn = null;
	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	    conn = DriverManager.getConnection(url, user, pwd);
	} catch (Exception e) {
	   System.out.println("Exception: " + e.toString());
	}

	PreparedStatement pstmt = null;
	String sql = "INSERT INTO score (hak, name, birth, kor, eng, mat) VALUES (?, ?, ?, ?, ?, ?) ";
	try {
		pstmt = conn.prepareStatement(sql);

		pstmt.setString(1, dto.getHak());
		pstmt.setString(2, dto.getName());
		pstmt.setString(3, dto.getBirth());
		pstmt.setInt(4, dto.getKor());
		pstmt.setInt(5, dto.getEng());
		pstmt.setInt(6, dto.getMat());
		result = pstmt.executeUpdate();
		pstmt.close();

	} catch (SQLException e) {
		System.out.println(e.toString());
	}


	// ------------------------------------------------
	// SELECT-1

	String url  = "jdbc:oracle:thin:@localhost:1521:ORCL";
	String user = "scott";
	String pwd = "tiger";

	Connection conn = null;
	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	    conn = DriverManager.getConnection(url, user, pwd);
	} catch (Exception e) {
	   System.out.println("Exception: " + e.toString());
	}

	List<ScoreDTO> lists = new ArrayList<ScoreDTO>();
	PreparedStatement pstmt = null;
	ResultSet rs = null;

	String sql="SELECT hak, name, birth, kor, eng, mat FROM score";
	try {
		pstmt = conn.prepareStatement(sql);

		while(rs.next()) {
			ScoreDTO dto = new ScoreDTO();
			dto.setHak(rs.getString("hak"));
			dto.setName(rs.getString("name"));
			dto.setBirth(rs.getString("birth"));
			dto.setKor(rs.getInt("kor"));
			dto.setEng(rs.getInt("eng"));
			dto.setMat(rs.getInt("mat"));

			lists.add(dto);
		}
		rs.close();
		stmt.close();

		  :

	} catch (Exception e) {
		System.out.println(e.toString());
	}


	// ------------------------------------------------
	// SELECT-2

	String url  = "jdbc:oracle:thin:@localhost:1521:ORCL";
	String user = "scott";
	String pwd = "tiger";

	Connection conn = null;
	try {
	    Class.forName("oracle.jdbc.driver.OracleDriver");
	    conn = DriverManager.getConnection(url, user, pwd);
	} catch (Exception e) {
	   System.out.println("Exception: " + e.toString());
	}

	ScoreDTO dto=null
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	String hak="1111";

	String sql="SELECT hak, name, birth, kor, eng, mat FROM score WHERE hak=?";
	try {
		pstmt = conn.prepareStatement(sql);
		pstmt.setString(1, hak);

		if(rs.next()) {
			dto = new ScoreDTO();
			dto.setHak(rs.getString("hak"));
			dto.setName(rs.getString("name"));
			dto.setBirth(rs.getString("birth"));
			dto.setKor(rs.getInt("kor"));
			dto.setEng(rs.getInt("eng"));
			dto.setMat(rs.getInt("mat"));
		}
		rs.close();
		stmt.close();

		  :

	} catch (Exception e) {
		System.out.println(e.toString());
	}
