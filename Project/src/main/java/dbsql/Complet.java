package dbsql;

import java.io.IOException;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

@WebServlet("/complet")
public class Complet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	DBSQL dao;

	public void init(ServletConfig config) throws ServletException {
		super.init(config);
		dao = new DBSQL();
	}

	protected void service(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
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
		dao.insert(s);
		return list(request, response);
	}

	private String list(HttpServletRequest request, HttpServletResponse response) {
		request.setAttribute("complets", dao.getAll());
		return "studentInfo.jsp";
	}
}