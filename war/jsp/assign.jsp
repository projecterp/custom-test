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
  <div class="box">
  <%
      Questions_All qa=new Questions_All();     
      ArrayList<Entity> temp=new ArrayList<Entity>();
  %>
  <p class="p" style="width:auto">Your Tests are:</p>
  <%
     temp=(ArrayList<Entity>)qa.getAllTests();
     if(temp!=null)
     { 
  %>
        <p>For preview click on the Test name:</p>
  <%
        for(Entity abc:temp)
        { 
  %>
           <form action="preview.jsp" method="get">
           <p><input type="Submit" class="btn" name="test_name" value="<%=abc.getProperty("test_name")%>">
              :- <%=abc.getProperty("que_count")%> Questions ,Total Points:-<%=abc.getProperty("total_points")%>
           </p> 
           </form>
  <%
        }
     }
  %> 
  </div>
</body>
</html>