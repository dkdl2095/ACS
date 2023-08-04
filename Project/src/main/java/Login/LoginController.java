package Login;

import java.io.IOException;
import java.lang.reflect.Method;

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
                session.setAttribute("ID", result.getId()); //ID를 세션에 저장
                session.setAttribute("NAME", result.getName());  //이름을 세션에 저장
                session.setAttribute("RESIDENCE", result.getResidence()); //입주정보를 세션에 저장
                //System.out.println("1"+result+result.getId() + result.getPassword() + result.getName() + result.getResidence());
                return "redirect:/Project/ACS/MainView.jsp";  //로그인 성공하면 메인뷰로 이동
            } else {
            	// "Error:-1" -> ["Error", "-1"]
            	int errorcode = Integer.parseInt(result.getId().split(":")[1]);   //에러코드는 split함수를 이용해 -1,-2,-3 경우 분리
            	switch (errorcode) {
            	case -1:
            		session.setAttribute("error", "비밀번호가 다름.");
            		break;
            	case -2:
            		session.setAttribute("error", "입력한 정보가 없음.");
            		break;
            	case -3:
            		session.setAttribute("error", "데이터베이스에 정보가 확인이 안됨.");
            		break;
            	default:
            		session.setAttribute("error", "뭔지 모를 오류.");
            	}
            }

            return "redirect:/Project/lc?action=login";      //로그인 성공이 안되면 다시 로그인 화면으로
        } else if (req.getMethod().equalsIgnoreCase("get")) {
            return "/ACS/Login.jsp";  
        }

        return "/ACS/Login.jsp";
    }
    

}