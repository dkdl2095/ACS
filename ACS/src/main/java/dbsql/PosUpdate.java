package dbsql;

public class PosUpdate extends DBSQL{
	public PosUpdate(String table) {
		super(table);
	}
	
	public void DBUpdate(String table) { // 테이블 수정
		open();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			updateTenantData(t);
		} else if (upperCaseTable.equals("POST")) {
			updatePostData(p);
		} else if (upperCaseTable.equals("CALENDER")) {
			updateCalendarData(c);
		} else if (upperCaseTable.equals("TENANTBAN")) {
			updateBanData(b);
		}
	}
}
