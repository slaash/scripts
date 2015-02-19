import java.io.FileReader;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

import au.com.bytecode.opencsv.CSVReader;

class big_csv{
	
	public static void listIntrebari(HashMap intrebari){
		Set set=intrebari.entrySet();
		Iterator i=set.iterator();
		while (i.hasNext()){
			Map.Entry me=(Map.Entry)i.next();
			Integer nr=(Integer) me.getKey();
			String text=(String) me.getValue();
			System.out.println(nr+" => "+text);
		}
	}
	
	public static void main (String[] args) throws IOException{
		CSVReader reader = new CSVReader(new FileReader("dump_1323623999.csv"),';','"',1);
	    String[] line;
//	    Data;Nr.;Intrebare;Varianta;Raspuns
	    String data,intrebare,varianta,raspuns;
	    Integer nr;
	    HashMap intrebari=new HashMap();
	    while ((line = reader.readNext()) != null) {
	    	data=line[0];
	    	nr=Integer.valueOf(line[1]);
	    	intrebare=line[2];
	    	varianta=line[3];
	    	raspuns=line[4];
	    	intrebari.put(nr,intrebare);
//	        System.out.println(data);
	    }
	    listIntrebari(intrebari);
	}

}