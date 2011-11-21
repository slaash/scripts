//import java.lang.*;
import java.math.BigDecimal;

class prime_console{
	
	static int masterAlive=1;
	static ThreadGroup MyThGroup=new ThreadGroup("Primes");
	
	public static class Watcher extends Thread{
		
		public void run(){
			while (masterAlive==1){
				try {
					Watcher.sleep(1000);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				System.out.println("Threads in " + Thread.currentThread().getThreadGroup().getName() + " : "+Integer.toString(Thread.currentThread().getThreadGroup().activeCount()));
				System.out.println("Threads in "+ MyThGroup.getName() +": "+Integer.toString(MyThGroup.activeCount()));
				System.out.println(Runtime.getRuntime().freeMemory()/1024/2014+ " MB free of " + Runtime.getRuntime().totalMemory()/1024/2014 + " MB Total, MAX is " + Runtime.getRuntime().maxMemory()/1024/2014 + " MB");
			}
			System.out.println("Watcher done!");
		}	
	
	}
	public static class MyThread extends Thread{
		
		double n;
		
		MyThread(ThreadGroup tg, String n){
			super(tg,n);
			this.n=Double.parseDouble(n);
		}
		
		public void run(){
//			System.out.println(Thread.currentThread().getThreadGroup().getName());
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
		
		for (i=min;i<=max;i++){
			MyThread t=new MyThread(MyThGroup,String.valueOf(i));
//			if (Thread.currentThread().getThreadGroup().activeCount()<10){
			if (MyThGroup.activeCount()<10){
				t.start();
			}
			else{
				try {
					t.join();
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
			}
		}
//		while (Thread.currentThread().getThreadGroup().activeCount()>2){
		while (MyThGroup.activeCount()>0){
		}
		masterAlive=0;
		try {
			w.join();
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println("Master done!");
	}

}
