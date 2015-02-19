import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

class array_of_hashes{

	public static void main (String[] args){
		HashMap hMap1=new HashMap();
		hMap1.put("val1", "aaa");
		hMap1.put("val2", "111");
		HashMap hMap2=new HashMap();
		hMap2.put("val1", "bbb");
		hMap2.put("val2", "222");
		
		HashMap[] hmArray=new HashMap[2];
		hmArray[0]=hMap1;
		hmArray[1]=hMap2;
		
		for (int k=0;k<hmArray.length;k++){
			
			HashMap crtMap=hmArray[k];
			
			Set set=crtMap.entrySet();
			Iterator i=set.iterator();
			while (i.hasNext()){
				Map.Entry me=(Map.Entry)i.next();
				String key=(String) me.getKey();
				String val=(String) me.getValue();
				System.out.println(key+" => "+val);
			}
		}
	}
	
}