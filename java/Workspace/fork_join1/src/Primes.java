import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class Primes extends RecursiveAction{
	
	private int min;
	private int max;
	
	public Primes(int i,int j) {
		// TODO Auto-generated constructor stub
		min=i;
		max=j;
	}

	@Override
	protected void compute() {
		// TODO Auto-generated method stub
		if (min==max){
			System.out.println(n);
		}
		else{
			
		}
	}

	public static void main(String[] args){
		int processors = Runtime.getRuntime().availableProcessors();
		System.out.println("No of processors: " + processors);

		Primes primes=new Primes(1,10);
		ForkJoinPool pool=new ForkJoinPool();
		pool.invoke(primes);
	}
		
}