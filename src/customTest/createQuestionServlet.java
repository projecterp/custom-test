package customTest;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import questionsManager.Questions_All;

@SuppressWarnings("serial")
public class createQuestionServlet extends HttpServlet{

	public void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws IOException, ServletException {
		String test_name=req.getParameter("test_name");
		String que_type=req.getParameter("que_type");
		String que=req.getParameter("que");
		String ans=req.getParameter("ans");
		String points=req.getParameter("points");
		ArrayList<String> options=new ArrayList<String>();
		
		if(que_type.equals("mulc")){
			
			String op1=req.getParameter("op1");
			String op2=req.getParameter("op2");
			String op3=req.getParameter("op3");
			String op4=req.getParameter("op4");
			options.add(op1);
			options.add(op2);
			options.add(op3);
			options.add(op4);
			
	    }
		else if(que_type.equals("tf"))
		{
			String op1=req.getParameter("op1");
			String op2=req.getParameter("op2");
			options.add(op1);
			options.add(op2);
		}
		Questions_All qa=new Questions_All();

		qa.addQue(test_name, que_type, que, options, ans, points);
	    RequestDispatcher jsp=req.getRequestDispatcher("/create.jsp");
		jsp.forward(req,resp);
	}
	
}
