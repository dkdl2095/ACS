package dbsql;

public class PosDelete extends DBSQL {
	public PosDelete(String table) {
		super(table);
	}

	public void DBDelete(String table) { // 테이블 삭제
		open();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			deleteTenantData(t);
		} else if (upperCaseTable.equals("POST")) {
			deletePostData(p);
		} else if (upperCaseTable.equals("CALENDER")) {
			deleteCalendarData(c);
		} else if (upperCaseTable.equals("TENANTBAN")) {
			deleteBanData(b);
		} 
	}
}
