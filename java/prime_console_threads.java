import java.lang.*;

class prime_console{

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
				System.out.println(n);
			}
		}

	}

	public static void main (String[] args){
		double min=1e13;
		double max=1.0000000001e13;
		double i;
		for (i=min;i<=max;i++){
			MyThread t=new MyThread(i);
			if (Thread.activeCount()<=10){
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
	}

}
