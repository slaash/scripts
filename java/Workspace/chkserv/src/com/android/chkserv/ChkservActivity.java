package com.android.chkserv;

import android.app.Activity;
import android.app.ActivityManager;
import android.app.ActivityManager.RecentTaskInfo;
import android.app.ActivityManager.RunningAppProcessInfo;
import android.app.ActivityManager.RunningServiceInfo;
import android.app.ActivityManager.RunningTaskInfo;
import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.text.method.ScrollingMovementMethod;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.Spinner;
import android.widget.TextView;
import android.widget.Toast;

public class ChkservActivity extends Activity {
    /** Called when the activity is first created. */
	public static final String PREFS_NAME = "ChkservPrefsFile";
	
	private boolean isMyServiceRunning() {
	    ActivityManager manager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
	    for (RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
	        if ("com.android.chkserv.service".equals(service.service.getClassName())) {
	            return true;
	        }
	    }
	    return false;
	}
	
	private void listServices() {
		TextView textview1=(TextView) findViewById(R.id.textView1);
		textview1.setMovementMethod(new ScrollingMovementMethod());
		textview1.setText("");
	    ActivityManager manager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
	    for (RunningServiceInfo service : manager.getRunningServices(Integer.MAX_VALUE)) {
	    	textview1.append(service.service.getClassName()+"\n");
	    }
	}
	
	private void listApplications() {
		TextView textview1=(TextView) findViewById(R.id.textView1);
		textview1.setMovementMethod(new ScrollingMovementMethod());
		textview1.setText("");
	    ActivityManager manager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
	    for (RunningAppProcessInfo appProc : manager.getRunningAppProcesses()) {
	    	textview1.append(appProc.processName+"\n");
	    }
	}

	private void listTasks() {
		TextView textview1=(TextView) findViewById(R.id.textView1);
		textview1.setText("");
	    ActivityManager manager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
	    for (RunningTaskInfo task : manager.getRunningTasks(Integer.MAX_VALUE)) {
	    	textview1.append(task.baseActivity.getClassName()+"\n");
	    }
	}
	
	private void listRecentTasks() {
		TextView textview1=(TextView) findViewById(R.id.textView1);
		textview1.setText("");
	    ActivityManager manager = (ActivityManager) getSystemService(ACTIVITY_SERVICE);
	    for (RecentTaskInfo task : manager.getRecentTasks(Integer.MAX_VALUE, ActivityManager.RECENT_WITH_EXCLUDED)) {
	    	textview1.append(task.toString()+"\n");
	    }
	}
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        Toast.makeText(ChkservActivity.this, "Create", Toast.LENGTH_SHORT).show();
        
        SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
        
        final CheckBox checkbox = (CheckBox) findViewById(R.id.checkBox1);
        
        if (values.getBoolean("checked", false)){
        	checkbox.setChecked(true);
        }
        else{
        	checkbox.setChecked(false);
        }
        		
        checkbox.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on clicks, depending on whether it's now checked
                if (checkbox.isChecked()) {
                    Toast.makeText(ChkservActivity.this, "Service starts", Toast.LENGTH_SHORT).show();
                    if (!isMyServiceRunning()){
                    	startService(new Intent(ChkservActivity.this, service.class));
        			}
        			else{
        				Toast.makeText(ChkservActivity.this, "Service is already started!", Toast.LENGTH_SHORT).show();
                    }
                } else {
                    Toast.makeText(ChkservActivity.this, "Service stops", Toast.LENGTH_SHORT).show();
                    if (isMyServiceRunning()){
                    	stopService(new Intent(ChkservActivity.this, service.class));
                    }
                    else{
                    	Toast.makeText(ChkservActivity.this, "Service is already stopped!", Toast.LENGTH_SHORT).show();
                    }
                }
            }
        });
        
        final CheckBox checkbox2 = (CheckBox) findViewById(R.id.checkBox2);
        checkbox2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
            	if (!checkbox2.isChecked()) {
            		SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
            		values.edit().remove("checked").commit();
            		Toast.makeText(ChkservActivity.this, "Checked value removed!", Toast.LENGTH_SHORT).show();
            	}
            }
        });
        
        final Button button1 = (Button) findViewById(R.id.button1);
        button1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
            	startActivity(new Intent(ChkservActivity.this,newactivity.class));
            }
        });
        
        final Button button2 = (Button) findViewById(R.id.button2);
        button2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
            	Spinner spinner = (Spinner) findViewById(R.id.spinner1);
            	String spinnerValue=spinner.getSelectedItem().toString();
            	if (spinnerValue.equals("Services")){
            		listServices();
            	}
            	else if (spinnerValue.equals("Applications")){
            		listApplications();
            	}
            	else if (spinnerValue.equals("Tasks")){
            		listTasks();
            	}
            	else if (spinnerValue.equals("Recent tasks")){
            		listRecentTasks();
            	}
            }
        });
    }
    
    protected void onStop() {
        super.onStop();
        final CheckBox checkbox2 = (CheckBox) findViewById(R.id.checkBox2);
        if (checkbox2.isChecked()) {
	        final CheckBox checkbox = (CheckBox) findViewById(R.id.checkBox1);
	        SharedPreferences values = getSharedPreferences(PREFS_NAME, 0);
	        SharedPreferences.Editor editor = values.edit();
	        if (checkbox.isChecked()){
	        	editor.putBoolean("checked", true);
	        }
	        else{
	        	editor.putBoolean("checked", false);
	        }
	        editor.commit();
	    	Toast.makeText(ChkservActivity.this, "Checked value saved", Toast.LENGTH_SHORT).show();
        }
        Toast.makeText(ChkservActivity.this, "Stoped", Toast.LENGTH_SHORT).show();
    }
}