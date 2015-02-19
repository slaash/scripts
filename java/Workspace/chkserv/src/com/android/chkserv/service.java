package com.android.chkserv;

import android.app.Service;
import android.content.Intent;
import android.os.IBinder;
import android.widget.Toast;

public class service extends Service{

	@Override
	public IBinder onBind(Intent arg0) {
		// TODO Auto-generated method stub
		return null;
	}
	
	@Override
	public void onCreate() {
		Toast.makeText(this, "Service created", Toast.LENGTH_SHORT).show();
	}
	
	public void onStart() {
		Toast.makeText(this, "Service started", Toast.LENGTH_SHORT).show();
	}
	
	public void onDestroy() {
		Toast.makeText(this, "Service destroyed", Toast.LENGTH_SHORT).show();
	}
	
}