import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class regex1 {
	
	public static void main (String[] args) throws IOException, InterruptedException{
		ArrayList<String> command=new ArrayList<String>();
		command.add("tasklist");
//		command.add("status");
		ProcessBuilder builder=new ProcessBuilder(command);
		Map<String, String> env = builder.environment();
		String path=System.getenv("PATH");
		String sep=File.separator;
		String psep=File.pathSeparator;
		env.put("CCM_HOME", "P:"+sep+"cm_syn"+sep+"V7.1L.iasp051x");
		System.out.println("ccm_home: "+env.get("CCM_HOME"));
		env.put("PATH",env.get("CCM_HOME")+sep+"bin"+psep+path);
		System.out.println("procbld path: "+env.get("PATH"));
		System.out.println("sys path: "+System.getenv("PATH"));
		Process p=builder.start();
		BufferedReader rdr=new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line;
		Pattern pattern=Pattern.compile("^(s\\w+\\.\\w+).+Console");
		while ((line=rdr.readLine()) != null){
			Matcher matcher=pattern.matcher(line);
			if (matcher.find()){
				System.out.println(matcher.group(1));
			}
//			System.out.println(line);
		}
		rdr.close();
		p.waitFor();
		System.out.println(p.exitValue());
	}
	
}