package dbsql;

import table.Calender;
import table.Post;
import table.Tenant;
import table.TenantBan;

public class PosDelete extends DBSQL {
	public PosDelete(String table) {
		super(table);
	}

	public void DBDelete(Tenant t, Post p, Calender c, TenantBan b) { // 테이블 삭제
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
