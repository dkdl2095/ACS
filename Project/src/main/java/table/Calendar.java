package table;

import java.sql.Date;

public class Calendar {
	private int calid;
	private Date cdate;
	private String text;
	private int postid;

	public int getCalid() {
		return calid;
	}

	public void setCalid(int calid) {
		this.calid = calid;
	}

	public Date getCdate() {
		return cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public int getPostid() {
		return postid;
	}

	public void setPostid(int postid) {
		this.postid = postid;
	}
}