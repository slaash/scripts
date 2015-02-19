import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.IOException;

class filez{

	public static void main (String[] args) throws IOException{
		File file1=new File("input.txt");
		File file2=new File("output.txt");
		FileReader fReader=new FileReader(file1);
		FileWriter fWriter=new FileWriter(file2);
		BufferedReader bReader=new BufferedReader(fReader);
		BufferedWriter bWriter=new BufferedWriter(fWriter);
		String line;
		while ((line=bReader.readLine()) != null){
			System.out.println(line);
			bWriter.write(line);
			bWriter.newLine();
		}
		bWriter.close();
		bReader.close();
		fWriter.close();
		fReader.close();
	}

}