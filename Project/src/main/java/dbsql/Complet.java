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

@WebServlet("/complet")
public class Complet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DBSQL dao;
	Tenant t = null;
	Post p = null;
	Calender c = null;
	TenantBan b = null;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new DBSQL("TENANTCOMPLET");
		t = new Tenant();
		p = new Post();
		c = new Calender();
		b = new TenantBan();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String action = request.getParameter("action");
		String view = "";
		if (action == null) {
			getServletContext().getRequestDispatcher("/complet?action=list").forward(request, response);
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
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(t, p, c, b);
		return list(request, response);
	}
	
	private String delete(HttpServletRequest request, HttpServletResponse response) {
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(t, p, c, b);
		return list(request, response);
	}
	
	private String update(HttpServletRequest request, HttpServletResponse response) {
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBUpdate(t, p, c, b);
		return list(request, response);
	}

	private String list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("complets", dao.DBSelect(t, p, c, b));
		return "studentInfo.jsp";
	}
}