package dbsql;

import table.Calender;
import table.Post;
import table.Tenant;
import table.TenantBan;

public class PosInsert extends DBSQL {
	public PosInsert(String table) {
		super(table);
	}

	public void DBInsert(Tenant t, Post p, Calender c, TenantBan b) { // 테이블 삽입
		open();
		String upperCaseTable = table.toUpperCase();

		if (upperCaseTable.equals("TENANTCOMPLET") || upperCaseTable.equals("TENANTWAIT")) {
			insertTenantData(t);
		} else if (upperCaseTable.equals("POST")) {
			insertPostData(p);
		} else if (upperCaseTable.equals("CALENDER")) {
			insertCalendarData(c);
		} else if (upperCaseTable.equals("TENANTBAN")) {
			insertBanData(b);
		}
	}
}
