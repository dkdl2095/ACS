package dbsql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import org.apache.catalina.valves.rewrite.InternalRewriteMap.UpperCase;

import table.*;

public class DBSQL {
	private String table;
	Connection conn = null;
	PreparedStatement pstmt;
	Object obj;

	// 오라클 드라이버 설정
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	public DBSQL(String table) { // 생성자
		this.table = table;
	}

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

	public void insert(Tenant t) {
		open();
		String sql = "INSERT INTO " + table + "(id, name, password, accessiondate, residence) values(?,?,?,?,?)";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, t.getId());
			pstmt.setString(2, t.getName());
			pstmt.setString(3, t.getPassword());
			pstmt.setDate(4, t.getAccessiondate());
			pstmt.setString(5, t.getResidence());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void delete(Tenant s) {
		open();
		String sql = "DELETE FROM " + table + " WHERE id = ?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s.getId());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void update(Tenant s) {
		open();
		String sql = "UPDATE " + table + " SET id=?, name=?, password=?, accessiondate=?, residence=?";

		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, s.getId());
			pstmt.setString(2, s.getName());
			pstmt.setString(3, s.getPassword());
			pstmt.setDate(4, s.getAccessiondate());
			pstmt.setString(5, s.getResidence());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public List<Tenant> select() {
		open();
		List<Tenant> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				Tenant s = new Tenant();
				s.setId(rs.getString("id"));
				s.setName(rs.getString("name"));
				s.setPassword(rs.getString("password"));
				s.setAccessiondate(rs.getDate("accessiondate"));
				s.setResidence(rs.getString("residence"));

				tenants.add(s);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return tenants;
	}
}