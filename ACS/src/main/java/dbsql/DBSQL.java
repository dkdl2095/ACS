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

	public List<Object> DBSelect(Tenant t) {
		open();
		List<Object> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
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
	
	public List<Object> DBSelect(Tenant t, int id) {
		open();
		List<Object> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE id=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery();
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

	public List<Object> DBSelect(Post p) {
		open();
		List<Object> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				p = new Post();
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
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
	
	public List<Object> DBSelect(Post p, int postid) {
		open();
		List<Object> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE postid=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, postid);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				p = new Post();
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
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
	
	public List<Object> DBSelect(Post p, String type) {
		open();
		List<Object> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE type=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, type);
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				p = new Post();
				p.setPostid(rs.getInt("postid"));
				p.setType(rs.getString("type"));
				p.setTitle(rs.getString("title"));
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

	public List<Object> DBSelect(Calender c) {
		open();
		List<Object> calenders = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
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
	
	public List<Object> DBSelect(Calender c, int calid) {
		open();
		List<Object> calenders = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE calid=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			pstmt.setInt(1, calid);
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

	public List<Object> DBSelect(TenantBan b) {
		open();
		List<Object> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table;
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) {
				b = new TenantBan();
				b.setBanid(rs.getString("banid"));
				b.setBandate(rs.getDate("bandate"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return ban;
	}
	
	public List<Object> DBSelect(TenantBan b, int banid) {
		open();
		List<Object> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE banid=?";
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			pstmt.setInt(1, banid);
			while (rs.next()) {
				b = new TenantBan();
				b.setBanid(rs.getString("banid"));
				b.setBandate(rs.getDate("bandate"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
		return ban;
	}

	public void DBInsert(Tenant t) {
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

	public void DBInsert(Post p) {
		open();
		String sql = "INSERT INTO " + table
				+ "(postid, type, title, text, writingdate, name, img, viewsnum) VALUES (POSTID_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, p.getType());
			pstmt.setString(2, p.getTitle());
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

	public void DBInsert(Calender c) {
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

	public void DBInsert(TenantBan b) {
		open();
		String sql = "INSERT INTO " + table + "(banid, bandate) VALUES (?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid());
			pstmt.setDate(2, b.getBandate());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBDelete(Tenant t, String id) {
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

	public void DBDelete(Post p, int postid) {
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

	public void DBDelete(Calender c, int calid) {
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

	public void DBDelete(TenantBan b, String banid) {
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

	public void DBUpdate(Tenant t) {
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

	public void DBUpdate(Post p) {
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

	public void DBUpdate(Calender c) {
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

	public void DBUpdate(TenantBan b) {
		open();
		String sql = "UPDATE " + table + " SET banid=?, bandate=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid());
			pstmt.setDate(2, b.getBandate());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}
}