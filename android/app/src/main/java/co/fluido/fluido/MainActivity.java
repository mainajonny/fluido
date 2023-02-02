package co.fluido.fluido;

import android.app.Activity;
import android.content.Intent;
import android.widget.Toast;

import androidx.annotation.NonNull;

import com.hover.sdk.api.Hover;
import com.hover.sdk.api.HoverParameters;

import java.util.Arrays;

import io.flutter.Log;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {

    private static final String CHANNEL = "native.flutter/hover_helper";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("startHover")) {
                                startHover(call, result);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    void startHover(MethodCall call,MethodChannel.Result result){
        Hover.initialize(this);

        //result.success(actionId);
        String action = call.argument("action");
        String phone_number = call.argument("phonenumber");
        String till_number = call.argument("tillnumber");
        String business_number = call.argument("businessnumber");
        String account = call.argument("account");
        String amount = call.argument("amount");

        if (action != null) {
            String actionId = "";
            Intent i;

            switch (action) {
                case "CheckBalance":
                    actionId = "c9e84cca";
                    i = new HoverParameters.Builder(this).request(actionId).buildIntent();
                    break;
                case "SendMoney":
                    actionId = "<YOUR_ACTION_ID>";
                    i = new HoverParameters.Builder(this)
                            .request(actionId)
                            .extra("phonenumber", phone_number)
                            .extra("amount", amount)
                            .buildIntent();
                    break;
                case "PayBill":
                    actionId = "<YOUR_ACTION_ID>";
                    i = new HoverParameters.Builder(this)
                            .request(actionId)
                            .extra("businessnumber", business_number)
                            .extra("account", account)
                            .extra("amount", amount)
                            .buildIntent();
                    break;
                case "BuyGoods":
                    actionId = "<YOUR_ACTION_ID>";
                    i = new HoverParameters.Builder(this)
                            .request(actionId)
                            .extra("tillnumber", till_number)
                            .extra("amount", amount)
                            .buildIntent();
                    break;
                case "BuyAirtime":
                    actionId = "<YOUR_ACTION_ID>";
                    i = new HoverParameters.Builder(this)
                            .request(actionId)
                            .extra("phonenumber", phone_number)
                            .extra("amount", amount)
                            .buildIntent();
                    break;
                default:
                    throw new IllegalStateException("@@ Unexpected value: " + action);
            }

            startActivityForResult(i, 0);
        }else{
            Log.e("@@ ERROR"," action is null");
        }

    }

    @Override
    protected void onActivityResult (int requestCode, int resultCode, Intent data) {
        if (requestCode == 0 && resultCode == Activity.RESULT_OK) {
            String[] sessionTextArr = data.getStringArrayExtra("session_messages");
            String uuid = data.getStringExtra("uuid");

            Log.i("@@ UUID", uuid);
            Log.i("@@ sessionTextArr", Arrays.toString(sessionTextArr));
        } else if (requestCode == 0 && resultCode == Activity.RESULT_CANCELED) {
            Toast.makeText(this, "Error: " + data.getStringExtra("error"), Toast.LENGTH_LONG).show();
        }
    }
}
