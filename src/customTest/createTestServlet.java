package customTest;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import questionsManager.Questions_All;

@SuppressWarnings("serial")
public class createTestServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		resp.setContentType("text/html");
		String test_name=req.getParameter("test_name");
		Questions_All qa=new Questions_All();
		boolean x=qa.addTest(test_name);
		if(x==true)
		{
			RequestDispatcher jsp=req.getRequestDispatcher("/create.jsp");
			jsp.forward(req,resp);	
		}
		else
		{
		    PrintWriter out=resp.getWriter();
		    out.println("SELECT DIFFERENT TEST NAME!!!");
		    RequestDispatcher html=req.getRequestDispatcher("/create.html");
			html.forward(req,resp);
		}
		
	}

}
