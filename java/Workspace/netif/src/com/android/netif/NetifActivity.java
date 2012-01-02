package com.android.netif;

import java.net.InetAddress;
import java.net.NetworkInterface;
import java.net.SocketException;
import java.util.Enumeration;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class NetifActivity extends Activity {
    /** Called when the activity is first created. */
    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.main);
        
        final Button button1 = (Button) findViewById(R.id.button1);
        button1.setOnClickListener(new View.OnClickListener() {
            public void onClick(View v) {
                // Perform action on click
            	final EditText edittext1 = (EditText) findViewById(R.id.editText1);
            	edittext1.setText("Started"+"\n");
            	try {
					Enumeration<NetworkInterface> en=NetworkInterface.getNetworkInterfaces();
					edittext1.append("Got network interfaces"+"\n");
					while (en.hasMoreElements()){
						edittext1.append("Got next interface"+"\n");
						NetworkInterface intf=en.nextElement();
						byte[] mac=intf.getHardwareAddress();
						StringBuilder sb = new StringBuilder();
						if (mac != null){
							for (int i = 0; i < mac.length; i++) {
								sb.append(String.format("%02X%s", mac[i], (i < mac.length - 1) ? "-" : ""));		
							}
						}
						Enumeration<InetAddress> addrs=intf.getInetAddresses();
						while (addrs.hasMoreElements()){
							edittext1.append("Got next address"+"\n");
							InetAddress addr=addrs.nextElement();
							edittext1.append(addr.toString()+":"+sb.toString()+"\n");
//							Toast.makeText(NetifActivity.this, addr.getHostAddress(), Toast.LENGTH_SHORT).show();
						}
					}
				} catch (SocketException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
            	edittext1.append("End");
            }
        });
    }
}