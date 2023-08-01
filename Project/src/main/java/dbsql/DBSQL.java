package dbsql;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import table.*;

public class DBSQL {
	String table;
	Connection conn = null;
	PreparedStatement pstmt;

	// 오라클 드라이버 설정
	final String JDBC_DRIVER = "oracle.jdbc.driver.OracleDriver";
	final String JDBC_URL = "jdbc:oracle:thin:@localhost:1521:xe";

	public DBSQL(String table) { // 생성자
		this.table = table.toUpperCase();
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

	protected List<Object> DBSelect(Tenant t) {
		open();
		List<Object> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()){
			while (rs.next()) {
				t = new Tenant();
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

	protected List<Object> DBSelect(Post p) {
		open();
		List<Object> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()){
			while (rs.next()) {
				p = new Post();
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

	protected List<Object> DBSelect(Calender c) {
		open();
		List<Object> calenders = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()){
			while (rs.next()) {
				c = new Calender();
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

	protected List<Object> DBSelect(TenantBan b) {
		open();
		List<Object> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql); ResultSet rs = pstmt.executeQuery()){
			while (rs.next()) {
				b = new TenantBan();
				b.setBanid(rs.getString("banid"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return ban;
	}

	protected void DBInsert(Tenant t) {
		open();
		String sql = "INSERT INTO " + table + "(ID, NAME, PASSWORD, ACCESSIONDATE, RESIDENCE) VALUES(?, ?, ?, ?, ?)";

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

	protected void DBInsert(Post p) {
		open();
		String sql = "INSERT INTO " + table
				+ "(postid, type, title, text, writingdate, name, img, viewsnum) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, p.getPostid());
			pstmt.setString(2, p.getType());
			pstmt.setString(3, p.getTitle());
			pstmt.setString(4, p.getText());
			pstmt.setDate(5, p.getWritingdate());
			pstmt.setString(6, p.getName());
			pstmt.setString(7, p.getImg());
			pstmt.setInt(8, p.getViewsnum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBInsert(Calender c) {
		open();
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

	protected void DBInsert(TenantBan b) {
		open();
		String sql = "INSERT INTO " + table + "(banid) VALUES (?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBDelete(Tenant t, String id) {
		open();
		String sql = "DELETE FROM " + table + " WHERE id = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, id);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBDelete(Post p, int postid) {
		open();
		String sql = "DELETE FROM " + table + " WHERE postid = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postid);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBDelete(Calender c, int calid) {
		open();
		String sql = "DELETE FROM " + table + " WHERE calid = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, calid);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBDelete(TenantBan b, String banid) {
		open();
		String sql = "DELETE FROM " + table + " WHERE banid = ?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, banid);

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBUpdate(Tenant t) {
		open();
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

	protected void DBUpdate(Post p) {
		open();
		String sql = "UPDATE " + table + " SET postid=?, type=?, title=?, text=?, writingdate=?, name=?, img=?, viewsnum=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, p.getPostid());
			pstmt.setString(2, p.getType());
			pstmt.setString(3, p.getTitle());
			pstmt.setString(4, p.getText());
			pstmt.setDate(5, p.getWritingdate());
			pstmt.setString(6, p.getName());
			pstmt.setString(7, p.getImg());
			pstmt.setInt(8, p.getViewsnum());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	protected void DBUpdate(Calender c) {
		open();
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

	protected void DBUpdate(TenantBan b) {
		open();
		String sql = "UPDATE " + table + " SET banid=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}