package com.android.netdroid;

import java.io.IOException;
import java.net.ServerSocket;
import java.net.Socket;
import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class NetdroidActivity extends Activity {
    /** Called when the activity is first created. */
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        final TextView tv1=(TextView) findViewById(R.id.textView1);
        
        final Button bt1 = (Button) findViewById(R.id.button1);
        bt1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
            	ServerSocket server;
            	try {
                	server=new ServerSocket(9999);
                	if (server == null){
                		Toast.makeText(NetdroidActivity.this, "mumu", Toast.LENGTH_SHORT).show();
                	}
                	else{
	                	server.setSoTimeout(5000);
	                	tv1.setText("Started server");
	        			while (true){
	        				Socket client=server.accept();
	        				Toast.makeText(NetdroidActivity.this, "Got conn", Toast.LENGTH_SHORT).show();
	        			}
                	}
        		} catch (IOException e) {
        			// TODO Auto-generated catch block
        			e.printStackTrace();
        		}
            }
        });
    }
}