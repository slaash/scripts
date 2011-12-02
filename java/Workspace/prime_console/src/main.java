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
			this.n=Double.valueOf(n);
		}

		public void run(){
//			System.out.println(Thread.currentThread().getThreadGroup().getName());
			is_prime(n);
		}

		public void is_prime(double n){
			boolean prim=true;
			double j;
	        for (j=2;j<=Math.sqrt(n);j=j+1){
	                if (n % j==0){
	                        prim=false;
	                        break;
	                }
	        }
	        if (prim==true){
	                System.out.println(BigDecimal.valueOf(n));
	        }
		}

	}

	public static void main (String[] args) throws InterruptedException{

		Watcher w=new Watcher();
		w.start();

		double min;
		double max;

		if (args.length>0){

			min=Double.valueOf(args[0]);
			max=Double.valueOf(args[1]);
		}
		else{
			min=Double.valueOf("1");
            max=Double.valueOf("100");
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
//		while (MyThGroup.activeCount()>0){
//		}
		
//		int count = MyThGroup.activeCount() * 2; // factor of 2 for safety 
		int count=(int) (max-min+1);
		Thread[] threads = new Thread[(int) (max-min+1)];  
		MyThGroup.enumerate(threads);  
	    for (int j = 0; j < count; j++)  
	    {  
	      Thread t = threads[j];  
	      if (t != null)  
	        t.join();  
	    }  
				
		masterAlive=0;
		w.join();
		System.out.println("Master done!");
	}

}