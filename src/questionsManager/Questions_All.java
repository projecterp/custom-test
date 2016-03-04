package questionsManager;

import java.util.ArrayList;

import com.google.appengine.api.datastore.Entity;

public class Questions_All {

 QuestionsManager qm=new QuestionsManager();
 
 public void addQue(String test_name,String que_type,String que,ArrayList<String> options,String ans,String points)
 {
	 if(!qm.isQueRepeated(test_name,que_type,que)){
		 qm.addQue(test_name, que_type, que, options, ans, points);
	 }
 }
 
 public boolean addTest(String test_name)
 {
	 if(!qm.isTestRepeated(test_name)){
		 qm.addTest(test_name);
		 return true;
	 }
	return false;
 }
 
 public long getQueCount(String test_name)
 {
	 return qm.getQueCount(test_name);
 }

 public ArrayList<Entity> getAllTests()
 {
	if(qm.isTestsPresent())
	{
		return qm.getAllTests();
	}
	return null;
 }
 
 public ArrayList<Entity> getAllQues(String test_name)
 {
	if(qm.getQueCount(test_name)>0)
	{
		return qm.getAllQues(test_name);
	}
	return null;
	 
 }
 
}
