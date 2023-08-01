package Login;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import table.Tenant;

public class LoginDAO {
	String table;
	Connection conn = null;
	PreparedStatement pstmt;

	// 오라클 드라이버 설정
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	public void open() {
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "hr", "hr");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public void close() {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public Tenant login(String id, String password) {
		open();
		Tenant result = new Tenant();
		
		try {
			String query = "SELECT id, password, name FROM TenantComplet WHERE id = ? AND password = ?";
			PreparedStatement pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				// ResultSet이 비어 있지 않은 경우에만 값을 가져옴
				String getid = rs.getString("id");
				String getpassword = rs.getString("password");
				String getname = rs.getString("name");
				System.out.println("ID: " + getid + ", Password: " + getpassword);

				String storedPassword = rs.getString("password");
				System.out.println(rs);
				if (storedPassword.equals(password)) {
					System.out.println("로그인.");
					result.setId(getid);
					result.setPassword(storedPassword);
					result.setName(getname);
					return result;
				} else {
					System.out.println("아이디 or 비밀번호 다릅니다.");
					result.setId("Error:-1");
				}
			}
			System.out.println("입력한 정보가 없습니다.");
			result.setId("Error:-2");
		} catch (SQLException e) {
			e.printStackTrace();
			result.setId("Error:-3");
		}
		return result;
	}
}
