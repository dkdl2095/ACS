package Login;

import java.io.IOException;
import java.lang.reflect.Method;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import table.Tenant;


@WebServlet("/lc")
public class LoginController extends HttpServlet {
	LoginDAO dao = new LoginDAO();
	
    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");
        String view = "";

        Method m = null;

        if (action == null) {
            action = "login";
        }

        try {
            m = this.getClass().getMethod(action, HttpServletRequest.class);
            view = (String) m.invoke(this, req);
        } catch (NoSuchMethodException e) {
            req.setAttribute("error", "존재하지 않는 액션 요청입니다!");
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (view.startsWith("redirect:")) {
            view = view.substring("redirect:".length());
            resp.sendRedirect(view);
        } else {
            RequestDispatcher rd = req.getRequestDispatcher(view);
            rd.forward(req, resp);
        }
    }

    public String login(HttpServletRequest req) {
        if (req.getMethod().equalsIgnoreCase("post")) {
            String id = req.getParameter("ID");
            String pass = req.getParameter("PW");

            HttpSession session = req.getSession(true);

            Tenant result = dao.login(id, pass);

            if (!result.getId().contains("Error")) {
                session.setAttribute("result", "로그인에 성공했습니다.");
                session.setAttribute("loginuser", result);
                return "redirect:/ACS/ACS/MainView.jsp";
            } else {
            	// "Error:-1" -> ["Error", "-1"]
            	int errorcode = Integer.parseInt(result.getId().split(":")[1]);
            	switch (errorcode) {
            	case -1:
            		session.setAttribute("error", "비밀번호가 다름.");
            		break;
            	case -2:
            		session.setAttribute("error", "비밀번호가 다름.");
            		break;
            	case -3:
            		session.setAttribute("error", "비밀번호가 다름.");
            		break;
            	default:
            		session.setAttribute("error", "뭔지 모를 오류.");
            	}
            }

            return "redirect:/ACS/lc?action=login";
        } else if (req.getMethod().equalsIgnoreCase("get")) {
            return "/ACS/Login.jsp";
        }

        return "/ACS/Login.jsp";
    }
}