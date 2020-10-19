### JDBC를 이용한 SELECT, INSERT, UPDATE, DELETE 등


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


  #
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

  #
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
