package dbsql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import table.*;

public class DBSQL {
	private String table;
	Connection conn = null;
	PreparedStatement pstmt;
	Tenant t = null;
	Post p = null;
	Calender c = null;

	// 오라클 드라이버 설정
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	public DBSQL(String table) { // 생성자
		this.table = table;
		this.t = new Tenant();
		this.p = new Post();
		this.c = new Calender();
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
	
	public List<Object> DBSelect(String table) { // 테이블 검색
		open();
		List<Object> objs = new ArrayList<>();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			objs = selectTenantData(table, t);
		} else if (upperCaseTable.equals("POST")) {
			objs = selectPostData(table, p);
		} else if (upperCaseTable.equals("CALENDER")) {
			objs = selectCalendarData(table, c);
		}
		return objs;
	}

	public void DBInsert(String table) { // 테이블 삽입
		open();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			insertTenantData(table, t);
		} else if (upperCaseTable.equals("POST")) {
			insertPostData(table, p);
		} else if (upperCaseTable.equals("CALENDER")) {
			insertCalendarData(table, c);
		}
	}

	public void DBDelete(String table) { // 테이블 삭제
		open();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			deleteTenantData(table, t);
		} else if (upperCaseTable.equals("POST")) {
			deletePostData(table, p);
		} else if (upperCaseTable.equals("CALENDER")) {
			deleteCalendarData(table, c);
		}
	}

	public void DBUpdate(String table) { // 테이블 수정
		open();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			updateTenantData(table, t);
		} else if (upperCaseTable.equals("POST")) {
			updatePostData(table, p);
		} else if (upperCaseTable.equals("CALENDER")) {
			updateCalendarData(table, c);
		}
	}
	private List<Object> selectTenantData(String table2, Tenant t) {
		List<Object> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				t.setId(rs.getString("id"));
				t.setName(rs.getString("name"));
				t.setPassword(rs.getString("password"));
				t.setAccessiondate(rs.getDate("accessiondate"));
				t.setResidence(rs.getString("residence"));

				tenants.add(t);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return tenants;
	}
	
	private List<Object> selectPostData(String table2, Post p) {
		List<Object> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setText(rs.getString("text"));
				p.setWritingdate(rs.getDate("writingdate"));
				p.setName(rs.getString("name"));
				p.setImg(rs.getString("img"));
				p.setViewsnum(rs.getInt("viewsnum"));

				posts.add(p);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return posts;
	}
	
	private List<Object> selectCalendarData(String table2, Calender c) {
		List<Object> calenders = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();

			while (rs.next()) {
				pstmt.setInt(1, c.getCalid());
				pstmt.setDate(2, c.getCdate());
				pstmt.setString(3, c.getText());
				pstmt.setInt(4, c.getPostid());
				c.setCalid(rs.getInt("calid"));
				c.setCdate(rs.getDate("cdate"));
				c.setText(rs.getString("text"));
				c.setPostid(rs.getInt("postid"));

				calenders.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return calenders;
	}

	private void insertTenantData(String table, Tenant t) {
		String sql = "INSERT INTO " + table + "(id, name, password, accessiondate, residence) VALUES (?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

	private void insertPostData(String table, Post p) {
		String sql = "INSERT INTO " + table
				+ "(postid, type, text, writingdate, name, img, viewsnum) VALUES (?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, p.getPostid());
			pstmt.setString(2, p.getType());
			pstmt.setString(3, p.getText());
			pstmt.setDate(4, p.getWritingdate());
			pstmt.setString(5, p.getName());
			pstmt.setString(6, p.getImg());
			pstmt.setInt(7, p.getViewsnum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private void insertCalendarData(String table, Calender c) {
		String sql = "INSERT INTO " + table + "(calid, cdate, text, postid) VALUES (?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, c.getCalid());
			pstmt.setDate(2, c.getCdate());
			pstmt.setString(3, c.getText());
			pstmt.setInt(4, c.getPostid());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private void deleteTenantData(String table, Tenant t) {
		String sql = "DELETE FROM " + table + " WHERE id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, t.getId());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private void deletePostData(String table, Post p) {
		String sql = "DELETE FROM " + table + " WHERE psotid = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, p.getPostid());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private void deleteCalendarData(String table, Calender c) {
		String sql = "DELETE FROM " + table + " WHERE calid = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, c.getCalid());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private void updateTenantData(String table, Tenant t) {
		String sql = "UPDATE " + table + " SET id=?, name=?, password=?, accessiondate=?, residence=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
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

	private void updatePostData(String table, Post p) {
		String sql = "UPDATE " + table + " SET postid=?, type=?, text=?, writingdate=?, name=?, img=?, viewsnum=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, p.getPostid());
			pstmt.setString(2, p.getType());
			pstmt.setString(3, p.getText());
			pstmt.setDate(4, p.getWritingdate());
			pstmt.setString(5, p.getName());
			pstmt.setString(6, p.getImg());
			pstmt.setInt(7, p.getViewsnum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	private void updateCalendarData(String table, Calender c) {
		String sql = "UPDATE " + table + " SET id=?, name=?, password=?, accessiondate=?, residence=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, c.getCalid());
			pstmt.setDate(2, c.getCdate());
			pstmt.setString(3, c.getText());
			pstmt.setInt(4, c.getPostid());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}