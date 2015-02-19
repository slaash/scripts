import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

public class threadpool{
	
	private static class printer implements Runnable{

		protected int crt=0;
		
		@Override
		public void run() {
			// TODO Auto-generated method stub
			crt++;
			System.out.println(crt);
		}
		
	}
	
	public static void main(String[] args){
		ExecutorService execsrv=Executors.newFixedThreadPool(10);
		for (int i=0;i<10;i++){
			execsrv.execute(new printer());
		}
		execsrv.shutdown();
	}
}