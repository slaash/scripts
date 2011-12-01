package com.android.prime1;

import android.app.Activity;
import android.app.ListActivity;
import android.view.*;
import android.view.View.OnKeyListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.ListView;
import android.widget.TextView;
import android.widget.Toast;
import android.os.Bundle;

public class Prime1Activity extends ListActivity {
    /** Called when the activity is first created. */
	
	static final String[] COUNTRIES = new String[] {"Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra"};
	
    @Override
    public void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		//setContentView(R.layout.main);

		setListAdapter(new ArrayAdapter<String>(this, R.layout.list_item, COUNTRIES));

		ListView lv = getListView();
		lv.setTextFilterEnabled(true);

//		lv.setOnClickListener(new OnClickListener() {
//			public void onItemClick(AdapterView<?> parent, View view,
//				int position, long id) {
//				// When clicked, show a toast with the TextView text
//				Toast.makeText(getApplicationContext(), ((TextView) view).getText(),
//				Toast.LENGTH_SHORT).show();
//			}
//		});
    }
}