import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Set;

class arrays_n_hashes{

	public static void main (String[] args){
		String[] sArray1=new String[3];
		sArray1[0]="a";
		sArray1[1]="b";
		sArray1[2]="c";
		String [] sArray2=new String[3];
		sArray2[0]="1";
		sArray2[1]="2";
		sArray2[2]="3";
//		for (int i=0;i<sArray1.length;i++){
//			System.out.println(sArray1[i]);
//			
//		}
		
		HashMap hMap=new HashMap();
		hMap.put("val1", sArray1);
		hMap.put("val2", sArray2);

		Set set=hMap.entrySet();
		Iterator i=set.iterator();
		
		while (i.hasNext()){
			Map.Entry me=(Map.Entry)i.next();
			String key=(String) me.getKey();
			System.out.println(key);
			
			String[] val=new String[3];
			val=(String[]) hMap.get(key);
			
			for (int j=0;j<val.length;j++){
				System.out.println(val[j]);
			}
		}
		
		
		
	}
	
}