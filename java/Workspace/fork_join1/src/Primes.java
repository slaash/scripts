import java.util.concurrent.ForkJoinPool;
import java.util.concurrent.RecursiveAction;

public class Primes extends RecursiveAction{
	
	private int min;
	private int max;
	
	public Primes(int i, int j) {
		// TODO Auto-generated constructor stub
		min=i;
		max=j;
	}

	@Override
	protected void compute() {
		// TODO Auto-generated method stub
		if (min<max){
			invokeAll(new Primes(min,max/2),new Primes(max/2,max));
			min++;
		}
		else{
			computeDirectly();
			return;
		}
	}

	protected void computeDirectly() {
		// TODO Auto-generated method stub
		for (int i=min;i<=max;i++){
//			boolean prim=true;
//			for (int j=2;j<=Math.sqrt(i);j++){
//				if (i % j==0){
//					prim=false;
//					break;
//				}
//			}
//			if (prim==true){
				System.out.println(i);
//			}
		}
	}
	
	public static void main(String[] args){
		int processors = Runtime.getRuntime().availableProcessors();
		System.out.println("No of processors: " + processors);

		Primes primes=new Primes(1,100);
		ForkJoinPool pool=new ForkJoinPool();
		pool.invoke(primes);
	}
		
}