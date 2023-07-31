package dbsql;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import table.*;

@WebServlet("/TENANTCOMPLET")
public class Complet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DBSQL dao;
	String table = "TENANTCOMPLET";

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new DBSQL(table);
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String view = "";
		String dispatcher = "/" + table + "?action=list";
		if (action == null) {
			getServletContext().getRequestDispatcher(dispatcher).forward(request, response);
		} else {
			switch (action) {
			case "list":
				view = list(request, response);
				break;

			case "insert":
				view = insert(request, response);
				break;

			case "delete":
				view = delete(request, response);
				break;
				
			case "update":
				view = update(request, response);
				break;
			}
			getServletContext().getRequestDispatcher("/db/" + view).forward(request, response);
		}

	}

	private String insert(HttpServletRequest request, HttpServletResponse response) {
		Tenant s = new Tenant();
		try {
			BeanUtils.populate(s, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(table);
		return list(request, response);
	}
	
	private String delete(HttpServletRequest request, HttpServletResponse response) {
		Tenant s = new Tenant();
		try {
			BeanUtils.populate(s, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(table);
		return list(request, response);
	}
	
	private String update(HttpServletRequest request, HttpServletResponse response) {
		Tenant s = new Tenant();
		try {
			BeanUtils.populate(s, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBUpdate(table);
		return list(request, response);
	}

	private String list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute(table, dao.DBSelect(table));
		return "studentInfo.jsp";
	}
}