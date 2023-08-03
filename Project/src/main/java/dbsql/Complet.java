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
	Tenant t = new Tenant();
	Post p = new Post();
	Calendar c = new Calendar();
	TenantBan b = new TenantBan();

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
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
				view = listcomplet(request, response);
				view = listwait(request, response);
				view = listban(request, response);
				view = listpost(request, response);
				view = listcalender(request, response);
				break;

			case "insertcomplet":
				view = insertcomplet(request, response);
				break;
			case "insertwait":
				view = insertwait(request, response);
				break;
			case "insertban":
				view = insertban(request, response);
				break;
			case "insertpost":
				view = insertpost(request, response);
				break;
			case "insertcalender":
				view = insertcalender(request, response);
				break;

			case "deletecomplet":
				view = deletecomplet(request, response);
				break;
			case "deletewait":
				view = deletewait(request, response);
				break;
			case "deleteban":
				view = deleteban(request, response);
				break;
			case "deletepost":
				view = deletepost(request, response);
				break;
			case "deletecalender":
				view = deletecalender(request, response);
				break;

			case "update":
				view = update(request, response);
				break;
			}
			getServletContext().getRequestDispatcher("/db/" + view).forward(request, response);
		}

	}

	private String insertcomplet(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTCOMPLET");
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(t);
		return "MemberManagement.jsp";
	}

	private String insertwait(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTWAIT");
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(t);
		return "MemberManagement.jsp";
	}
	
	private String insertban(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTBAN");
		try {
			BeanUtils.populate(b, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(t);
		return "MemberManagement.jsp";
	}
	
	private String insertpost(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("POST");
		try {
			BeanUtils.populate(p, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(p);
		return "MemberManagement.jsp";
	}
	private String insertcalender(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("CALENDER");
		try {
			BeanUtils.populate(c, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBInsert(p);
		return "MemberManagement.jsp";
	}

	private String deletecomplet(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTCOMPLET");
		String id = request.getParameter("id");
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(t, id);
		return "MemberManagement.jsp";
	}

	private String deletewait(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTWAIT");
		String id = request.getParameter("id");
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(t, id);
		return "MemberManagement.jsp";
	}

	private String deleteban(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTBAN");
		String id = request.getParameter("banid");
		try {
			BeanUtils.populate(b, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(b, id);
		return "MemberManagement.jsp";
	}

	private String deletepost(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("POST");
		int id = Integer.parseInt(request.getParameter("postid"));
		try {
			BeanUtils.populate(p, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(p, id);
		return "MemberManagement.jsp";
	}

	private String deletecalender(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("CALENDER");
		int id = Integer.parseInt(request.getParameter("calid"));
		try {
			BeanUtils.populate(c, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBDelete(c, id);
		return "MemberManagement.jsp";
	}

	private String update(HttpServletRequest request, HttpServletResponse response) {
		try {
			BeanUtils.populate(t, request.getParameterMap());
		} catch (Exception e) {
			e.printStackTrace();
		}
		dao.DBUpdate(t);
		return "MemberManagement.jsp";
	}

	private String listcomplet(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTCOMPLET");
		request.setAttribute("complets", dao.DBSelect(t));
		return "MemberManagement.jsp";
	}

	private String listwait(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTWAIT");
		request.setAttribute("waits", dao.DBSelect(t));
		return "MemberManagement.jsp";
	}

	private String listban(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("TENANTBAN");
		request.setAttribute("bans", dao.DBSelect(b));
		return "MemberManagement.jsp";
	}

	private String listpost(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("POST");
		request.setAttribute("posts", dao.DBSelect(p));
		return "MemberManagement.jsp";
	}

	private String listcalender(HttpServletRequest request, HttpServletResponse response) {
		dao = new DBSQL("Calender");
		request.setAttribute("calenders", dao.DBSelect(c));
		return "MemberManagement.jsp";
	}
}