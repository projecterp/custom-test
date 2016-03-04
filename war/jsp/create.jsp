<%@ page language="java" 
	contentType="text/html; charset=ISO-8859-1"
  	pageEncoding="ISO-8859-1"
%>
<%@ page
import="java.io.IOException"
import ="java.io.PrintWriter"
import ="java.util.ArrayList"
import ="java.util.Iterator"
import ="com.google.appengine.api.datastore.Entity"
import ="java.util.Calendar"
import ="javax.servlet.RequestDispatcher"
import ="javax.servlet.ServletException"
import ="javax.servlet.http.*"
import ="com.google.appengine.api.datastore.DatastoreServiceFactory"
import ="java.text.SimpleDateFormat"
import ="com.google.appengine.api.datastore.PreparedQuery"
import ="com.google.appengine.api.datastore.Query"
import ="com.google.apphosting.api.DatastorePb.DatastoreService"
import ="com.sun.xml.internal.bind.v2.schemagen.xmlschema.List"
import ="com.google.appengine.api.datastore.Query.SortDirection"
import ="com.google.appengine.api.datastore.Query.Filter"
import ="com.google.appengine.api.datastore.Query.FilterPredicate"
import ="com.google.appengine.api.datastore.Query.FilterOperator"
import ="com.google.appengine.api.datastore.Query.CompositeFilter"
import ="com.google.appengine.api.datastore.Query.CompositeFilterOperator"
import ="com.google.appengine.api.users.User"
import ="com.google.appengine.api.users.UserService"
import ="com.google.appengine.api.users.UserServiceFactory"
import ="questionsManager.Questions_All"
%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8">
<title>CREATE TEST PAPER</title>
<link rel="stylesheet" href="css/create.css" />
</head>

<script>
function expand1()
{
   document.getElementById("mul_que").style.display="block";
   document.getElementById("tf_que").style.display="none";
   document.getElementById("que_type").value="mulc";
   document.getElementsByClassName("box")[0].style.height="auto";
}
function expand2()
{
   document.getElementById("tf_que").style.display="block";
   document.getElementById("mul_que").style.display="none";
   document.getElementById("tf_que_type").value="tf";
   document.getElementsByClassName("box")[0].style.height="auto";
}
function validate1()
{
   var que=document.getElementById("que").value;
   var op1=document.getElementById("op1").value;
   var op2=document.getElementById("op2").value;
   var op3=document.getElementById("op3").value;
   var op4=document.getElementById("op4").value;
   var ans=document.getElementById("ans").value;
   var points=document.getElementById("points").value;
   if(que=='' || op1=='' || op2=='' || op3=='' || op4=='' || ans=='' || points=='' )
   {
      alert("Please Fill all the fields!");
   }
   else
   {
     document.forms["mulc_form"].submit();
   }
}
function validate2()
{
   var que=document.getElementById("tf_que").value;
   var op1=document.getElementById("tf_op1").value;
   var op2=document.getElementById("tf_op2").value;
   var points=document.getElementById("tf_points").value;
   if(que=='' || op1=='' || op2=='' || ans=='' || points=='' )
   {
      alert("Please Fill all the fields!");
   }
   else
   {
     document.forms["tf_form"].submit();
   }
}
</script>

<body bgcolor="lightgrey">
  <%
      Questions_All qa=new Questions_All();
      String test_name=request.getParameter("test_name");
  %>


 
  <div class="box">
     <p class="p" style="width:auto">Questions Type:</p>
     <input type="button" class="btn" id="q_type1" name="que_type1" value="multiple choice" onclick="expand1()">
     <input type="button" class="btn" id="q_type2" name="que_type2" value="true/false" onclick="expand2()">
     <input type="button" class="btn" id="q_type3" name="que_type3" value="descriptive" onclick="expnad3()">
     <p class="p" style="width:150px;color:black;background-color:lightgrey;">No.of Questions : <%=qa.getQueCount(test_name)%></p>
     <%
        if((long)qa.getQueCount(test_name)>0)
        {
     %>
            <form action="assign.jsp" method="get">
              <input type="hidden" name="test_name" value="<%=request.getParameter("test_name")%>">
              <input type="submit" class="btn" id="submit" name="btn" value="Save & Finish">
            </form>
     <%
        }
     %>
     <div id="mul_que" style="display:none">
 
        <form id="mulc_form" action="createQuestion" method="get">
 
        <input type="hidden" name="que_type" id="que_type" value="">
        <input type="hidden" name="test_name" value="<%=request.getParameter("test_name")%>">
        <p class="p" style="width:auto;background-color:aqua;">Multiple Choice</p>
            
        <br>
        <p>Question</p>
        <textarea name="que" id="que" class="feed" style="width:600px" rows="7"></textarea>
        <br>
        <p>Options:</p>
        <p>Option (A):<input type="text" class="feed" id="op1" name="op1" style="width:350px;height:30;"></p>
        <p>Option (B):<input type="text" class="feed" id="op2" name="op2" style="width:350px;height:30;"></p>
        <p>Option (C):<input type="text" class="feed" id="op3" name="op3" style="width:350px;height:30;"></p>
        <p>Option (D):<input type="text" class="feed" id="op4" name="op4" style="width:350px;height:30;"></p>
        <br>
        <p>Correct answer:<select id="ans" name="ans">
                            <option value="op1">A</option>
                            <option value="op2">B</option>
                            <option value="op3">C</option>
                            <option value="op4">D</option>
                          </select>
        <p>Points:<input type="number" name="points" id="points" class="feed"></p>
        <input type="button" name="btn" class="btn" onClick="validate1()" value="ADD Question">                  

        </form>
     </div><!--End of mul_que-->
    
     <div id="tf_que" style="display:none">
 
        <form id="tf_form" action="createQuestion" method="get">
 
        <input type="hidden" name="que_type" id="tf_que_type" value="">
        <input type="hidden" name="test_name" value="<%=request.getParameter("test_name")%>">
        <p class="p" style="width:auto;background-color:aqua;">True/False</p>
            
        <br>
        <p>Question</p>
        <textarea name="que" id="tf_que" class="feed" style="width:600px" rows="7"></textarea>
        <br>
        <p>Options:</p>
        <p>Option (A):<input type="text" class="feed" id="tf_op1" name="op1" style="width:350px;height:30;"></p>
        <p>Option (B):<input type="text" class="feed" id="tf_op2" name="op2" style="width:350px;height:30;"></p>
        <br>
        <p>Correct answer:<select id="ans" name="ans">
                            <option value="op1">A</option>
                            <option value="op2">B</option>
                          </select>
        <p>Points:<input type="number" name="points" id="tf_points" class="feed"></p>
        <input type="button" name="btn" class="btn" onClick="validate2()" value="ADD Question">                  
        </form>
     </div><!--End of tf_que-->
       
  </div><!--END OF BOX-->
  
</body>

</html>


