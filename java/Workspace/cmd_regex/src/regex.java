import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;

class regex {
	
	public static void main (String[] args) throws IOException, InterruptedException{
		System.out.println(System.getenv("path"));
		Process p = Runtime.getRuntime().exec("tasklist");
		BufferedReader rdr=new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line;
		while ((line=rdr.readLine()) != null){
			System.out.println(line);
		}
		rdr.close();
		p.waitFor();
		System.out.println(p.exitValue());
	}
	
	
}