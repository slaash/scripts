package com.android.persistence;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;

public class PersistenceActivity extends Activity {
    /** Called when the activity is first created. */
	public static final String PREFS_NAME = "MyPrefsFile";
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);

		final EditText edittext2 = (EditText) findViewById(R.id.editText2);
		final EditText edittext4 = (EditText) findViewById(R.id.editText4);
        
	    final Button button1 = (Button) findViewById(R.id.button1);
	    button1.setOnClickListener(new View.OnClickListener() {
	        public void onClick(View v) {
	            // Perform action on click
	            EditText edittext5 = (EditText) findViewById(R.id.editText5);
	        	Integer min=Integer.valueOf(edittext2.getText().toString());
	        	Integer max=Integer.valueOf(edittext4.getText().toString());
	        	edittext5.setText(String.valueOf(min)+" "+String.valueOf(max));
	        }
	    });
    
	    //Save button
	    final Button button3 = (Button) findViewById(R.id.button3);
	    button3.setOnClickListener(new View.OnClickListener() {
	        public void onClick(View v) {
	        	Toast.makeText(PersistenceActivity.this, getFilesDir().toString(), Toast.LENGTH_SHORT).show();
	            SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
	            SharedPreferences.Editor editor = values.edit();
	            editor.putString("start", edittext2.getText().toString());
	            editor.putString("end", edittext4.getText().toString());
	            editor.commit();
	        }
	    });
    
	    //Load button
	    final Button button2 = (Button) findViewById(R.id.button2);
	    button2.setOnClickListener(new View.OnClickListener() {
	        public void onClick(View v) {
	        	SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
	        	edittext2.setText(values.getString("start", "-1"));
	        	edittext4.setText(values.getString("end", "-1"));
	        }
	    });
    
    }
    
    protected void onStop() {
        super.onStop();
        final CheckBox checkbox = (CheckBox) findViewById(R.id.checkBox1);
        final EditText edittext2 = (EditText) findViewById(R.id.editText2);
		final EditText edittext4 = (EditText) findViewById(R.id.editText4);
        SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
        if (checkbox.isChecked()){
	        SharedPreferences.Editor editor = values.edit();
	        editor.putString("start", edittext2.getText().toString());
	        editor.putString("end", edittext4.getText().toString());
	        editor.commit();
        }
    	Toast.makeText(PersistenceActivity.this, "Stoped", Toast.LENGTH_SHORT).show();
    }
    
    protected void onResume() {
        super.onResume();
        final EditText edittext2 = (EditText) findViewById(R.id.editText2);
		final EditText edittext4 = (EditText) findViewById(R.id.editText4);
    	SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
    	edittext2.setText(values.getString("start", "-1"));
    	edittext4.setText(values.getString("end", "-1"));
    	Toast.makeText(PersistenceActivity.this, "Resumed", Toast.LENGTH_SHORT).show();
    }
}