package dbsql;

import java.util.ArrayList;
import java.util.List;

public class PosSelect extends DBSQL {
	public PosSelect(String table) {
		super(table);
	}
	
	public List<Object> DBSelect() { // 테이블 검색
		open();
		List<Object> objs = new ArrayList<>();

		if (table.equals("TENANTCOMPLET") || table.equals("TENANTWAIT")) {
			objs = selectTenantData(t);
		} else if (table.equals("POST")) {
			objs = selectPostData(p);
		} else if (table.equals("CALENDER")) {
			objs = selectCalendarData(c);
		} else if (table.equals("TENANTBAN")) {
			objs = selectBanData(b);
		}
		return objs;
	}
}
