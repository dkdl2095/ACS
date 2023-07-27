package dbsql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import table.*;

public class DBSQL {
	Connection conn = null;
	PreparedStatement pstmt;

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

	public void insert(Tenant s) {
		open();
		String sql = "INSERT INTO tenantcomplet(id, name, password, accessiondate, residence) values(?,?,?,?,?)";

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

	public List<Tenant> getAll() {
		open();
		List<Tenant> tenants = new ArrayList<>();
		String sql = "SELECT * FROM tenantcomplet";
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