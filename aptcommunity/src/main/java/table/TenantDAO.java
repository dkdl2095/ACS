package table;

import java.sql.Connection;
import table.Tenant;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TenantDAO {

	Connection conn = null;
	PreparedStatement pstmt;
	ResultSet rs;

	// 오라클 드라이버 설정
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	public TenantDAO() {

		open();
	}

	// DB 연결을 가져오는 메소드
	public void open() {
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "hr", "hr");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public int login(String id, String password) {
	    int result = -1; // 디폴트 값

	    try {
	        String query = "SELECT id, password FROM TenantComplet WHERE id = ?";
	        PreparedStatement pstmt = conn.prepareStatement(query);
	        pstmt.setString(1, id);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            String storedPassword = rs.getString("password");
	            
	            if (storedPassword.equals(password)) {
	                return 1; // 로그인 성공
	            } else {
	                return 0; // 비밀번호 다름
	            }
	        } else {
	            return 2; // 아이디가 존재하지 않음
	        }
	    } catch (SQLException e) {
	        e.printStackTrace();
	    }

	    return -2; // 데이터베이스 에러
	}	
}
