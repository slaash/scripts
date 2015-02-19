package com.example.mytest1;

import android.app.Activity;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.EditText;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.RadioButton;
import android.widget.ToggleButton;
import android.app.AlertDialog;
import android.content.DialogInterface;
import android.view.*;
import android.view.View.OnKeyListener;

public class Test1Activity extends Activity {
    /** Called when the activity is first created. */
    	
    @Override
    
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        final TextView tv = new TextView(this);
        tv.setText("Hello bai Androidule!");

        setContentView(R.layout.main);
        
        final EditText edittext1 = (EditText) findViewById(R.id.edittext1);
        edittext1.setOnKeyListener(new OnKeyListener() {
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                // If the event is a key-down event on the "enter" button
                if ((event.getAction() == KeyEvent.ACTION_DOWN) &&
                    (keyCode == KeyEvent.KEYCODE_ENTER)) {
                  // Perform action on key press
                  Toast.makeText(Test1Activity.this, edittext1.getText(), Toast.LENGTH_SHORT).show();
                  tv.setText(edittext1.getText().toString());
                  return true;
                }
                return false;
            }
        });
        
        final EditText edittext2 = (EditText) findViewById(R.id.edittext2);
        edittext2.setOnKeyListener(new OnKeyListener() {
            public boolean onKey(View v, int keyCode, KeyEvent event) {
                // If the event is a key-down event on the "enter" button
                if ((event.getAction() == KeyEvent.ACTION_DOWN) &&
                    (keyCode == KeyEvent.KEYCODE_ENTER)) {
                  // Perform action on key press
                  Toast.makeText(Test1Activity.this, edittext2.getText(), Toast.LENGTH_SHORT).show();
                  tv.setText(edittext2.getText().toString());
                  return true;
                }
                return false;
            }
        });
       
        final Button button1 = (Button) findViewById(R.id.button1);
        button1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
                Toast.makeText(Test1Activity.this, edittext1.getText(), Toast.LENGTH_SHORT).show();
                tv.setText(edittext1.getText().toString());
                edittext2.setText(edittext1.getText().toString());
                al_diag();
            }
        });

        final Button button2 = (Button) findViewById(R.id.button2);
        button2.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
            	Test1Activity.this.finish();
            }
        });
        
        final CheckBox checkbox = (CheckBox) findViewById(R.id.checkbox);
        checkbox.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on clicks, depending on whether it's now checked
                if (((CheckBox) v).isChecked()) {
                    Toast.makeText(Test1Activity.this, "Selected", Toast.LENGTH_SHORT).show();
                } else {
                    Toast.makeText(Test1Activity.this, "Not selected", Toast.LENGTH_SHORT).show();
                }
            }
        });
        
        final View.OnClickListener radio_listener = new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on clicks
                RadioButton rb = (RadioButton) v;
                Toast.makeText(Test1Activity.this, rb.getText(), Toast.LENGTH_SHORT).show();
            }
        };
        final RadioButton radio_red = (RadioButton) findViewById(R.id.radio_red);
        final RadioButton radio_blue = (RadioButton) findViewById(R.id.radio_blue);
        radio_red.setOnClickListener(radio_listener);
        radio_blue.setOnClickListener(radio_listener);
        
        final ToggleButton togglebutton = (ToggleButton) findViewById(R.id.togglebutton);
        togglebutton.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on clicks
                if (togglebutton.isChecked()) {
                    Toast.makeText(Test1Activity.this, "Checked", Toast.LENGTH_SHORT).show();
                } else {
                    Toast.makeText(Test1Activity.this, "Not checked", Toast.LENGTH_SHORT).show();
                }
            }
        });
        
    }
    
    public void al_diag(){
//    	Toast.makeText(Test1Activity.this, "al_diag", Toast.LENGTH_SHORT).show();
    	AlertDialog.Builder builder = new AlertDialog.Builder(this);
    	builder.setMessage("Are you sure you want to exit?")
    	       .setCancelable(false)
    	       .setPositiveButton("Yes", new DialogInterface.OnClickListener() {
    	           public void onClick(DialogInterface dialog, int id) {
    	        	   Test1Activity.this.finish();
    	           }
    	       })
    	       .setNegativeButton("No", new DialogInterface.OnClickListener() {
    	           public void onClick(DialogInterface dialog, int id) {
    	                dialog.cancel();
    	           }
    	       });
    	AlertDialog alert = builder.create();
    }
    
    protected void onPause() {
        super.onPause();
    	Toast.makeText(Test1Activity.this, "Paused", Toast.LENGTH_SHORT).show();
    	al_diag();
    }
    
    protected void onStop() {
        super.onStop();
    	Toast.makeText(Test1Activity.this, "Stoped", Toast.LENGTH_SHORT).show();
    	al_diag();
    }
    
    protected void onDestroy() {
        super.onDestroy();
    	Toast.makeText(Test1Activity.this, "Destroyed", Toast.LENGTH_SHORT).show();
    	al_diag();
    }

    protected void onResume() {
        super.onResume();
    	Toast.makeText(Test1Activity.this, "Resumed", Toast.LENGTH_SHORT).show();
    	al_diag();
    }
    
    protected void onRestart() {
        super.onRestart();
    	Toast.makeText(Test1Activity.this, "Restarted", Toast.LENGTH_SHORT).show();
    	al_diag();
    }
    
    public void onResume(Bundle savedInstanceState) {
    	Toast.makeText(Test1Activity.this, "Resumed", Toast.LENGTH_SHORT).show();
    	

    }
    
}