package EntityManager;

import java.util.ArrayList;

import javax.persistence.Entity;

@Entity
public class question {
	private String test_name;
	private String que_type;
	private String que;
	private ArrayList<String> options;
	private String ans;
	private String points;
}
