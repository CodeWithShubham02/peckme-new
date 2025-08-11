package com.example.peckme;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.widget.Toast;

public class IciciPrePaidCardActivity extends MainActivity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        //setContentView(R.layout.icici_prepaid_card_activity);

        System.out.println("Hello World from IciciPrePaidCardActivity");

//        String clientId = getIntent().getStringExtra("client_id");
//        String leadId = getIntent().getStringExtra("lead_id");
//        Toast.makeText(this, "Client ID: " + clientId, Toast.LENGTH_SHORT).show();
//        Toast.makeText(this, "Lead ID: " + leadId, Toast.LENGTH_SHORT).show();
        // Launch third-party SDK or app based on clientId here
        // Then finish if needed
        // finish();
    }
}
