import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

class regex1 {
	
	private static void show_rez (ArrayList<String> rez){
		Iterator<String> itr=rez.iterator();
		while (itr.hasNext()){
			System.out.println(itr.next());
		}
	}
	
	private static ArrayList<String> ccm_status() throws IOException, InterruptedException{
		String CCM_HOME="\\\\iasp351x\\didl9505\\SCC\\cm_syn\\V7.1L.iasp051x";
		ArrayList<String> command=new ArrayList<String>();
		command.add(CCM_HOME+"\\bin\\ccm.exe");
		command.add("status");
		ProcessBuilder builder=new ProcessBuilder(command);
		Map<String, String> env = builder.environment();
		env.put("CCM_HOME", CCM_HOME);
		Process p=builder.start();
		BufferedReader rdr=new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line;
//		Pattern pattern=Pattern.compile("^(s\\w+\\.\\w+).+Console");
		ArrayList<String> ret=new ArrayList<String>();
		while ((line=rdr.readLine()) != null){
//			Matcher matcher=pattern.matcher(line);
//			if (matcher.find()){
//				System.out.println(matcher.group(1));
//			}
			ret.add(line);
		}
		rdr.close();
		p.waitFor();
//		System.out.println(p.exitValue());
		return ret;
	}
	
	private static ArrayList<String> ccm_version() throws IOException, InterruptedException{
		String CCM_HOME="\\\\iasp351x\\didl9505\\SCC\\cm_syn\\V7.1L.iasp051x";
		ArrayList<String> command=new ArrayList<String>();
		command.add(CCM_HOME+"\\bin\\ccm.exe");
		command.add("version");
		ProcessBuilder builder=new ProcessBuilder(command);
		Map<String, String> env = builder.environment();
		env.put("CCM_HOME", CCM_HOME);
		Process p=builder.start();
		BufferedReader rdr=new BufferedReader(new InputStreamReader(p.getInputStream()));
		String line;
		ArrayList<String> ret=new ArrayList<String>();
		while ((line=rdr.readLine()) != null){
			ret.add(line);
		}
		rdr.close();
		p.waitFor();
		return ret;
	}
	
	public static void main (String[] args) throws IOException, InterruptedException{
		show_rez(ccm_status());
		show_rez(ccm_version());
	}
	
}