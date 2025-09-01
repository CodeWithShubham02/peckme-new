package com.example.peckme;
import android.content.Intent;
import android.os.Bundle;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity
{
    private static final String CHANNEL = "com.example.peckme/channel1";


    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);

        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler((call, result) -> {
                    if ("callNativeMethod".equals(call.method)) {
                        // Get arguments from Flutter
                        String client_id = call.argument("client_id");
                        String lead_id = call.argument("lead_id");
                        String customerName = call.argument("customerName");
                        String sessionId = call.argument("sessionId");
                        String amzAppID = call.argument("amzAppID");
                        String user_id = call.argument("user_id");
                        String branch_id = call.argument("branch_id");
                        String auth_id = call.argument("auth_id");
                        String gpslat = call.argument("gpslat");
                        String gpslong = call.argument("gpslong");
                        String banID = call.argument("banID");
                        String userName = call.argument("userName");
                        String athena_lead_id = call.argument("athena_lead_id");
                        String agentName = call.argument("agentName");
                        String client_lead_id = call.argument("client_lead_id");

                        // condiction check for client id
                        if ("38".equals(client_id)) {
                            result.success("OAPNxt app starting...");
                        } else if ("28".equals(client_id)) {
                            result.success("Assisted app starting...");
                        } else if ("11".equals(client_id)) {
                           // openSDK();
                            result.success("Start Biometrics app starting "+client_id+","+athena_lead_id+"...");
                        } else if ("12".equals(client_id)) {
                            result.success("Client Id "+client_id+"...");
                        } else if ("89".equals(client_id)) {
                            result.success("IciciPrePaidCard  app starting...");
                        } else if ("10".equals(client_id)) {
                            result.success("GPS Lat Long ..." + gpslat + "," + gpslong);
                        } else {
                            result.success("Open ICICI APP ");
                        }
                    } else {
                        result.notImplemented();
                    }
                });


    }

}

