package com.android.chkserv;

import android.app.Activity;
import android.content.SharedPreferences;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

public class newactivity extends Activity {
    /** Called when the activity is first created. */
	public static final String PREFS_NAME = "ChkservPrefsFile";
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main2);
        
        final SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
        final EditText edittext1=(EditText) findViewById(R.id.editText1);
        edittext1.setText(values.getString("newapptext1", ""));
        
        Button button1 = (Button) findViewById(R.id.button1);
        button1.setOnClickListener(new View.OnClickListener() {
			public void onClick(View v) {
				// TODO Auto-generated method stub
				values.edit().putString("newapptext1", edittext1.getText().toString()).commit();
			}
		});
        button1.setOnLongClickListener(new View.OnLongClickListener() {
			public boolean onLongClick(View v) {
				// TODO Auto-generated method stub
				values.edit().remove("newapptext1").commit();
				Toast.makeText(newactivity.this, "Value removed", Toast.LENGTH_SHORT).show();
				edittext1.setText("");
				return false;
			}
		});
        
    }
 
    protected void onStop() {
        super.onStop();
        Toast.makeText(newactivity.this, "Newapp stopped", Toast.LENGTH_SHORT).show();
    }

    protected void onDestroy() {
        super.onStop();
        Toast.makeText(newactivity.this, "Newapp destroyed", Toast.LENGTH_SHORT).show();
    }
    
    protected void onResume() {
        super.onStop();
        Toast.makeText(newactivity.this, "Newapp resumed", Toast.LENGTH_SHORT).show();
    }
}