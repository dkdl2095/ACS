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

	public void open() { // DB 연결 연결
		try {
			Class.forName(JDBC_DRIVER);
			conn = DriverManager.getConnection(JDBC_URL, "hr", "hr"); // hr 로 접속
		} catch (Exception e) { // DB 연결 중 오류가 나면 
			e.printStackTrace();
		}
	}

	public void close() { // DB 연결 해제
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (conn != null) {
				conn.close();
			}
		} catch (Exception e) { // DB 연결 해제 중 오류가 나면 
			e.printStackTrace();
		}
	}

	public List<Tenant> DBSelect(Tenant t) { // TenantComplet, TenantWait 테이블에 회원을 전부 Select하는 함수
		open(); // DB 연결
		List<Tenant> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문  
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Tenant 객체에 할당
				t = new Tenant(); // 가져온 sql쿼리문에 관련된 객체 생성
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
			close(); // DB 연결 해제
		}
		return tenants; // 객체에 추가 후 객체 리턴
	}
	
	public List<Tenant> DBSelect(Tenant t, int id) { // TenantComplet, TenantWait 테이블의 id에 해당하는 회원을 Select하는 함수
		open(); // DB 연결
		List<Tenant> tenants = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE id=?"; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, id); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Tenant 객체에 할당
				t = new Tenant(); // 가져온 sql쿼리문에 관련된 객체 생성
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
			close(); // DB 연결 해제
		}
		return tenants; // 객체에 추가 후 객체 리턴
	}

	public List<Post> DBSelect(Post p) { // Post 테이블에 게시글을 전부 Select하는 함수
		open(); // DB 연결
		List<Post> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
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
			close(); // DB 연결 해제
		}
		return posts; // 객체에 추가 후 객체 리턴
	}
	
	public List<Post> DBSelect(Post p, int postid) { // Post 테이블의 postid에 해당하는 게시글을 Select하는 함수
		open(); // DB 연결
		List<Post> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE postid=?"; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setInt(1, postid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
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
			close(); // DB 연결 해제
		}
		return posts; // 객체에 추가 후 객체 리턴
	}
	
	public List<Post> DBSelect(Post p, String type) { // Post 테이블의 type에 해당하는 게시글을 Select하는 함수
		open(); // DB 연결
		List<Post> posts = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE type=?"; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			pstmt.setString(1, type); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Post 객체에 할당
				p = new Post(); // 가져온 sql쿼리문에 관련된 객체 생성
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
			close(); // DB 연결 해제
		}
		return posts; // 객체에 추가 후 객체 리턴
	}

	public List<Calendar> DBSelect(Calendar c) { // Calendar 테이블에 일정을 전부 Select하는 함수
		open(); // DB 연결
		List<Calendar> Calendars = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Calendar 객체에 할당
				c = new Calendar(); // 가져온 sql쿼리문에 관련된 객체 생성
				c.setCalid(rs.getInt("calid"));
				c.setCdate(rs.getDate("cdate"));
				c.setText(rs.getString("text"));
				c.setPostid(rs.getInt("postid"));

				Calendars.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return Calendars; // 객체에 추가 후 객체 리턴
	}
	
	public List<Calendar> DBSelect(Calendar c, int calid) { // Calendar 테이블의 calid에 해당하는 일정을 Select하는 함수
		open(); // DB 연결
		List<Calendar> Calendars = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE calid=?"; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			pstmt.setInt(1, calid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 Calendar 객체에 할당
				c = new Calendar(); // 가져온 sql쿼리문에 관련된 객체 생성
				c.setCalid(rs.getInt("calid"));
				c.setCdate(rs.getDate("cdate"));
				c.setText(rs.getString("text"));
				c.setPostid(rs.getInt("postid"));

				Calendars.add(c);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return Calendars; // 객체에 추가 후 객체 리턴
	}

	public List<TenantBan> DBSelect(TenantBan b) { // TenantBan 테이블에 차단 당한 회원을 전부 Select하는 함수
		open(); // DB 연결
		List<TenantBan> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 TenantBan 객체에 할당
				b = new TenantBan(); // 가져온 sql쿼리문에 관련된 객체 생성
				b.setBanid(rs.getString("banid"));
				b.setBandate(rs.getDate("bandate"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return ban; // 객체에 추가 후 객체 리턴
	}
	
	public List<TenantBan> DBSelect(TenantBan b, int banid) { // TenantBan 테이블의 banid에 해당하는 차단 당한 회원을 Select하는 함수
		open(); // DB 연결
		List<TenantBan> ban = new ArrayList<>();
		String sql = "SELECT * FROM " + table + " WHERE banid=?"; // sql 쿼리문 
		try (PreparedStatement pstmt = conn.prepareStatement(sql)){
			ResultSet rs = pstmt.executeQuery();
			pstmt.setInt(1, banid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 
			while (rs.next()) { // 데이터 베이스에서 가져온 데이터를 TenantBan 객체에 할당
				b = new TenantBan(); // 가져온 sql쿼리문에 관련된 객체 생성
				b.setBanid(rs.getString("banid"));
				b.setBandate(rs.getDate("bandate"));

				ban.add(b);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
		return ban; // 객체에 추가 후 객체 리턴
	}

	public void DBInsert(Tenant t) { // TenantComplet, TenantWait 테이블에 회원 정보를 삽입하는 함수
		open(); // DB 연결
		// sql 쿼리문 
		String sql = "INSERT INTO " + table + "(ID, NAME, PASSWORD, ACCESSIONDATE, RESIDENCE) VALUES(?, ?, ?, ?, ?)";

	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, t.getId()); // sql 쿼리문에 id에 해당하는 값 셋팅
	        pstmt.setString(2, t.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
	        pstmt.setString(3, t.getPassword()); // sql 쿼리문에 password에 해당하는 값 셋팅
	        pstmt.setDate(4, t.getAccessiondate()); // sql 쿼리문에 accessiondate에 해당하는 값 셋팅
	        pstmt.setString(5, t.getResidence()); // sql 쿼리문에 residence에 해당하는 값 셋팅

	        pstmt.executeUpdate();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        close(); // DB 연결 해제
	    }
	}

	public void DBInsert(Post p) { // Post 테이블에 게시글 정보를 삽입하는 함수
		open(); // DB 연결
		// sql 쿼리문 (postid는 시퀀스로 1씩증가 POSTID_SEQ.NEXTVAL)
		String sql = "INSERT INTO " + table
				+ "(postid, type, title, text, writingdate, name, img, viewsnum) VALUES (POSTID_SEQ.NEXTVAL, ?, ?, ?, ?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, p.getType()); // sql 쿼리문에 type에 해당하는 값 셋팅
			pstmt.setString(2, p.getTitle()); // sql 쿼리문에 title에 해당하는 값 셋팅
			pstmt.setString(3, p.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setDate(4, p.getWritingdate()); // sql 쿼리문에 writingdate에 해당하는 값 셋팅
			pstmt.setString(5, p.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
			pstmt.setString(6, p.getImg()); // sql 쿼리문에 img에 해당하는 값 셋팅
			pstmt.setInt(7, p.getViewsnum()); // sql 쿼리문에 viewsnum에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBInsert(Calendar c) { // Calendar 테이블에 일정 정보를 삽입하는 함수
		open(); // DB 연결
		// sql 쿼리문 
		String sql = "INSERT INTO " + table + "(calid, cdate, text, postid) VALUES (?, ?, ?, ?)";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, c.getCalid()); // sql 쿼리문에 calid에 해당하는 값 셋팅
			pstmt.setDate(2, c.getCdate()); // sql 쿼리문에 cdate에 해당하는 값 셋팅
			pstmt.setString(3, c.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setInt(4, c.getPostid()); // sql 쿼리문에 postid에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBInsert(TenantBan b) { // TenantBan 테이블에 차단 당한 회원의 정보를 삽입하는 함수
		open(); // DB 연결
		String sql = "INSERT INTO " + table + "(banid, bandate) VALUES (?, ?)"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid()); // sql 쿼리문에 banid에 해당하는 값 셋팅
			pstmt.setDate(2, b.getBandate()); // sql 쿼리문에 bandate에 해당하는 값 셋팅
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBDelete(Tenant t, String id) { // TenantComplet, TenantWait 테이블에 id에 해당하는 회원 정보를 삭제하는 함수
		open(); // DB 연결
		String sql = "DELETE FROM " + table + " WHERE id = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, id); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBDelete(Post p, int postid) { // Post 테이블에 psotid에 해당하는 게시글 정보를 삭제하는 함수
		open(); // DB 연결
		String sql = "DELETE FROM " + table + " WHERE postid = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, postid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBDelete(Calendar c, int calid) { // Calendar 테이블에 calid에 해당하는 일정 정보를 삭제하는 함수
		open(); // DB 연결
		String sql = "DELETE FROM " + table + " WHERE calid = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, calid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		} 
	}

	public void DBDelete(TenantBan b, String banid) { // TenantBan 테이블에 banid에 해당하는 차단 당한 회원 정보를 삭제하는 함수
		open();
		String sql = "DELETE FROM " + table + " WHERE banid = ?"; // sql 쿼리문 

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, banid); // sql 쿼리문에 첫번째 ?에 해당하는 값 셋팅 

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}

	public void DBUpdate(Tenant t) { // TenantComplet, TenantWait 테이블에 회원 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문 
		String sql = "UPDATE " + table + " SET id=?, name=?, password=?, accessiondate=?, residence=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, t.getId()); // sql 쿼리문에 id에 해당하는 값 셋팅
			pstmt.setString(2, t.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
			pstmt.setString(3, t.getPassword()); // sql 쿼리문에 password에 해당하는 값 셋팅
			pstmt.setDate(4, t.getAccessiondate()); // sql 쿼리문에 accessiondate에 해당하는 값 셋팅
			pstmt.setString(5, t.getResidence()); // sql 쿼리문에 residence에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBUpdate(Post p) { // Post 테이블에 회원 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문 
		String sql = "UPDATE " + table + " SET postid=?, type=?, title=?, text=?, writingdate=?, name=?, img=?, viewsnum=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, p.getPostid()); // sql 쿼리문에 postid에 해당하는 값 셋팅
			pstmt.setString(2, p.getType()); // sql 쿼리문에 type에 해당하는 값 셋팅
			pstmt.setString(3, p.getTitle()); // sql 쿼리문에 title에 해당하는 값 셋팅
			pstmt.setString(4, p.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setDate(5, p.getWritingdate()); // sql 쿼리문에 writingdate에 해당하는 값 셋팅
			pstmt.setString(6, p.getName()); // sql 쿼리문에 name에 해당하는 값 셋팅
			pstmt.setString(7, p.getImg()); // sql 쿼리문에 img에 해당하는 값 셋팅
			pstmt.setInt(8, p.getViewsnum()); // sql 쿼리문에 viewsnum에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}
	
	public void DBUpdate(Post p, int id, int viewsnum) { // Post 테이블에 게시글 정보를 수정하는 함수(게시글 조회수 증가에 사용)
	       open();
	       String sql = "UPDATE " + table + " SET viewsnum=? WHERE postid=?"; // sql 쿼리문 

	       try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	           pstmt.setInt(1, viewsnum + 1); // sql 쿼리문에 viewsnum에 해당하는 값 셋팅
	           pstmt.setInt(2, id); // sql 쿼리문에 postid에 해당하는 값 셋팅

	           pstmt.executeUpdate();
	       } catch (Exception e) {
	           e.printStackTrace();
	       } finally {
	           close(); // DB 연결 해제
	       }
	   }

	public void DBUpdate(Calendar c) { // Calendar 테이블에 일정 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문 
		String sql = "UPDATE " + table + " SET calid=?, cdate=?, text=?, postid=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setInt(1, c.getCalid()); // sql 쿼리문에 calid에 해당하는 값 셋팅
			pstmt.setDate(2, c.getCdate()); // sql 쿼리문에 cdate에 해당하는 값 셋팅
			pstmt.setString(3, c.getText()); // sql 쿼리문에 text에 해당하는 값 셋팅
			pstmt.setInt(4, c.getPostid()); // sql 쿼리문에 postid에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close();
		}
	}

	public void DBUpdate(TenantBan b) { // TenantBan 테이블에 차단 당한 회원의 정보를 수정하는 함수
		open(); // DB 연결
		// sql 쿼리문 
		String sql = "UPDATE " + table + " SET banid=?, bandate=?";

		try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
			pstmt.setString(1, b.getBanid()); // sql 쿼리문에 banid에 해당하는 값 셋팅
			pstmt.setDate(2, b.getBandate()); // sql 쿼리문에 bandate에 해당하는 값 셋팅

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(); // DB 연결 해제
		}
	}
}