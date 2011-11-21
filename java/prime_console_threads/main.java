//import java.lang.*;
import java.math.BigDecimal;

class prime_console{
	
	private static int masterAlive=1;
	
	public static class Watcher extends Thread{
		
		public void run(){
			while (masterAlive==1){
				try {
					Watcher.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				System.out.println("Threads: "+Integer.toString(Thread.activeCount()));
			}
		}	
	
	}
	public static class MyThread extends Thread{
		
		double n;
		
		MyThread(double n){
			this.n=n;
		}
		
		public void run(){
			is_prime(n);
		}
	
		public void is_prime(double n){
			boolean prim=true;
			double j;
	        for (j=2;j<=Math.sqrt(n);j++){
	                if (n % j==0){
	                        prim=false;
	                        break;
	                }
	        }
	        if (prim){
	                System.out.println(BigDecimal.valueOf(n));
	        }
		}

	}
	
	public static void main (String[] args){
		
		Watcher w=new Watcher();
		w.start();

		double min;
		double max;

		if (args.length>0){
		
			min=new BigDecimal(args[0]).doubleValue();
			max=new BigDecimal(args[1]).doubleValue();
		}
		else{
			min=new BigDecimal("1").doubleValue();
                        max=new BigDecimal("100").doubleValue();
                }

		double i;
		int cnt=0;
		for (i=min;i<=max;i++){
			MyThread t=new MyThread(i);
			if (Thread.activeCount()<10){
				t.start();
			}
			else{
				try {
					t.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
			cnt++;
		}
		while (Thread.activeCount()>2){
			
		}
		masterAlive=0;
		System.out.println("Master done!");
	}

}
