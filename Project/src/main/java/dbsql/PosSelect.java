package dbsql;

import java.util.ArrayList;
import java.util.List;

public class PosSelect extends DBSQL {
	public PosSelect(String table) {
		super(table);
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
		} else if (upperCaseTable.equals("TENANTBAN")) {
			objs = selectBanData(table, b);
		}
		return objs;
	}

}
