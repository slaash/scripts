package com.android.prime1;

import java.math.BigDecimal;
import android.app.Activity;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class Prime1Activity extends Activity {
    /** Called when the activity is first created. */
	
	private TextView tv1;
	private Button bt1;
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.main);
		
		tv1=(TextView) findViewById(R.id.textView1);
		tv1.setMovementMethod(new ScrollingMovementMethod());
		
		bt1=(Button) findViewById(R.id.button1);
		bt1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
            	ComputePrimes primes=new ComputePrimes();
            	if ("Start".equals(bt1.getText().toString())){
            		tv1.setText("");
            		EditText et1=(EditText) findViewById(R.id.editText1);
            		EditText et2=(EditText) findViewById(R.id.editText2);
            		primes.execute(new String[] {et1.getText().toString(),et2.getText().toString()});
            		bt1.setText("Stop");
            	}
            	else if ("Stop".equals(bt1.getText().toString())){
            		primes.cancel(true);
            	}
            }
        });
		
    }
    
		private class ComputePrimes extends AsyncTask<String, Void, double[]> {

			@Override
			protected double[] doInBackground(String... minmax) {
				// TODO Auto-generated method stub
				double min=Double.parseDouble(minmax[0]);
				double max=Double.parseDouble(minmax[1]);
				double[] result=new double[(int) (max-min)+1];
				int c=0;
				for (double i=min;i<=max;i++){
					boolean prim=true;
					for (double j=2;j<=Math.sqrt(i);j++){
						if (i % j == 0){
							prim=false;
							break;
						}
					}
					if (prim==true){
						result[c]=i;
						c++;
					}
				}
				return result;
			}
			
			@Override
		    protected void onCancelled() {
				Toast.makeText(Prime1Activity.this, "Got cancel request", Toast.LENGTH_SHORT).show();
		    }
			
			protected void onPostExecute(double[] result) {
				for (double r : result){
					if (r != 0){
						tv1.append(BigDecimal.valueOf(r).toString()+"\n");
					}
				}
				bt1.setText("Start");
			}
			
		}
}