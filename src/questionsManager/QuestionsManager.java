package questionsManager;

import java.util.ArrayList;

import com.google.appengine.api.datastore.DatastoreService;
import com.google.appengine.api.datastore.DatastoreServiceFactory;
import com.google.appengine.api.datastore.Entity;
import com.google.appengine.api.datastore.PreparedQuery;
import com.google.appengine.api.datastore.Query;
import com.google.appengine.api.datastore.Query.CompositeFilterOperator;
import com.google.appengine.api.datastore.Query.Filter;
import com.google.appengine.api.datastore.Query.FilterOperator;
import com.google.appengine.api.datastore.Query.FilterPredicate;
import com.google.appengine.api.datastore.Query.SortDirection;

public class QuestionsManager{

	private DatastoreService ds;
	QuestionsManager()
	{
	  ds = DatastoreServiceFactory.getDatastoreService();
	}
	
	public void addQue(String test_name,String que_type,String que,ArrayList<String> options,String ans,String points)
	{
         //For adding question to question Entity.
		 
	     Entity xyz=new Entity("question");
	     xyz.setProperty("test_name",test_name);
	     xyz.setProperty("que_type",que_type);
	     xyz.setProperty("que",que);
	     xyz.setProperty("options",options);
	     xyz.setProperty("ans",ans);
	     xyz.setProperty("points",points);
	     ds.put(xyz);
	     
         //For question_count and total points.  Added in Test entity	     
	     
	     long count=0;
	     double total=0;
	     Filter test_nameFilter = new FilterPredicate("test_name", FilterOperator.EQUAL,test_name);

	     Query q = new Query("Test").setFilter(test_nameFilter);
		 PreparedQuery pq = ds.prepare(q);
		 Entity abc=pq.asSingleEntity();
		 if(abc!=null)
		 {
			 count=(long)abc.getProperty("que_count")+1;
			 total=(double)abc.getProperty("total_points")+Double.parseDouble(points);
			 abc.setProperty("que_count",count);
			 abc.setProperty("total_points",total);
		     ds.put(abc);
		 }
		 
	}

	public void addTest(String test_name) {
		 
		 long   a=0;
		 double b=0;
		 Entity xyz=new Entity("Test");
		 xyz.setProperty("test_name",test_name);
		 xyz.setProperty("que_count",a);
		 xyz.setProperty("total_points",b);
		 ds.put(xyz);
		 
	}
	
	public long getQueCount(String test_name) {

		 Filter test_nameFilter = new FilterPredicate("test_name", FilterOperator.EQUAL,test_name);

	     Query q = new Query("Test").setFilter(test_nameFilter);
		 PreparedQuery pq = ds.prepare(q);
		 Entity abc=pq.asSingleEntity();
		 if(abc!=null)
		 {   return (long)(abc.getProperty("que_count"));
		 }
		 else
		 {
			 return 0;
		 }
		
	}

	public boolean isTestRepeated(String test_name) {

		 Filter test_nameFilter = new FilterPredicate("test_name", FilterOperator.EQUAL,test_name);

	     Query q = new Query("Test").setFilter(test_nameFilter);
		 PreparedQuery pq = ds.prepare(q);
		 for(Entity abc:pq.asIterable())
		 {
			return true; 
		 }
    	 return false;
	}

	public boolean isQueRepeated(String test_name, String que_type, String que) {
		 Filter test_nameFilter = new FilterPredicate("test_name", FilterOperator.EQUAL,test_name);
		 Filter typeFilter = new FilterPredicate("que_type", FilterOperator.EQUAL,que_type);
		 Filter queFilter = new FilterPredicate("que", FilterOperator.EQUAL,que);
	     Filter validFilter = CompositeFilterOperator.and(test_nameFilter,typeFilter,queFilter);
	     Query q = new Query("question").setFilter(validFilter);
		 PreparedQuery pq = ds.prepare(q);
		 for(Entity abc:pq.asIterable())
		 {
			return true; 
		 }
		 return false;
	}

	public ArrayList<Entity> getAllTests() {
	     ArrayList<Entity> temp=new ArrayList<Entity>();
		 Query q=new Query("Test");
	     PreparedQuery pq = ds.prepare(q);
	     for(Entity abc:pq.asIterable())
		 {
			 temp.add(abc);
		 }
	     return temp;
	}

	public boolean isTestsPresent() {
		 Query q=new Query("Test");
	     PreparedQuery pq = ds.prepare(q);
	     for(Entity abc:pq.asIterable())
		 {
			return true; 
		 }
	     return false;
	}

	public ArrayList<Entity> getAllQues(String test_name) {
		 Filter test_nameFilter = new FilterPredicate("test_name", FilterOperator.EQUAL,test_name);
	     ArrayList<Entity> temp=new ArrayList<Entity>();
		 Query q=new Query("question").setFilter(test_nameFilter);
	     PreparedQuery pq = ds.prepare(q);
	     for(Entity abc:pq.asIterable())
		 {
			 temp.add(abc);
		 }
	     return temp;
	}

}
