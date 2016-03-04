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
<html>
<head>
   <meta http-equiv="content-type" content="text/html; charset=UTF-8">
   <title>ASSIGN</title>
   <link rel="stylesheet" href="css/create.css" />
</head>

<body bgcolor="lightgrey">
  <div class="box" style="height:auto">
  <%
      Questions_All qa=new Questions_All(); 
      String test_name=request.getParameter("test_name");    
      ArrayList<Entity> temp=new ArrayList<Entity>();
  %>
  <p class="p" style="width:auto;text-align: center;font-size: 25px;"><%=test_name%></p>
  <%
     int i=1;
     temp=(ArrayList<Entity>)qa.getAllQues(test_name);
     if(temp!=null)
     { 
  %>
        <p>Questions:</p>
  <%
        for(Entity abc:temp)
        { 
  %>
            <div class="feed" style="border-radius:6px;padding:15px;padding-top:0;">
            <p> Q.<%=i%><span style="float:right;">Points:<%=abc.getProperty("points")%></span></p>
            <p><%=abc.getProperty("que")%></p>
  <%
            ArrayList<String> op=(ArrayList<String>)abc.getProperty("options");
            if(abc.getProperty("que_type").equals("mulc"))
            {
               
  %>
                <input type="radio" name="ans" value="A">(A) <%=op.get(0)%><br>
                <input type="radio" name="ans" value="B">(B) <%=op.get(1)%><br>
                <input type="radio" name="ans" value="C">(C) <%=op.get(2)%><br>
                <input type="radio" name="ans" value="D">(D) <%=op.get(3)%>
  <%
            }
            else if(abc.getProperty("que_type").equals("tf"))
            {
  %>          
                <input type="radio" name="ans" value="A">(A) <%=op.get(0)%><br>
                <input type="radio" name="ans" value="B">(B) <%=op.get(1)%>
  <%
            }
            i++;
            
  %>
            </div>
  <%          
        }
     }
  %> 
  </div>
</body>
</html>