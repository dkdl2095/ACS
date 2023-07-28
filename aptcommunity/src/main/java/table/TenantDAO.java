package table;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class TenantDAO {

	Connection conn = null;
	PreparedStatement pstmt;

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

	public boolean login(String id, String password) {
		boolean Login = false;
		try {

			String query = "SELECT * FROM TenantComplet WHERE id = ?";
			pstmt = conn.prepareStatement(query);
			pstmt.setString(1, id);

			ResultSet rs = pstmt.executeQuery();

			if (rs.next()) {
				String Password = rs.getString("password");
				if (password.equals(Password)) {
					Login = true;
				}
			}
			rs.close();
			pstmt.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return Login;
	}
	public void close() {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
