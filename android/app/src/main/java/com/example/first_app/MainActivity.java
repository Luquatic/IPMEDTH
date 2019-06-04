package com.example.first_app;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioManager;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.widget.ImageView;
import android.widget.SeekBar;
import android.widget.TextView;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final int WAVEMAKER2_REQUEST = 0;
  private static final String TAG = MainActivity.class.toString();

  static native void create();
  static native void delete();
  static native void setEchoOn(boolean isEchoOn);
  public native void setWaarde(int waarde);
  public native int getWaarde();
  private boolean isPlaying;

  int previousRingerMode;
  AudioManager am;

  // Used to load the 'native-lib' library on application startup.
//  static {
//    System.loadLibrary("native-lib");
//  }

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);


    new MethodChannel(getFlutterView(), "battery").setMethodCallHandler(
            (call, result) -> {
              if (call.method.equals("getBatteryLevel")) {
                int batteryLevel = getBatteryLevel();

                if (batteryLevel != -1) {
                  result.success(batteryLevel);
                } else {
                  result.error("UNAVAILABLE", "Battery level not available.", null);
                }
              } else {
                result.notImplemented();
              }
            }
    );
  }

  private int getBatteryLevel() {
    if (VERSION.SDK_INT >= VERSION_CODES.LOLLIPOP) {
      BatteryManager batteryManager = (BatteryManager) getSystemService(BATTERY_SERVICE);
      return batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY);
    } else {
      Intent intent = new ContextWrapper(getApplicationContext()).
          registerReceiver(null, new IntentFilter(Intent.ACTION_BATTERY_CHANGED));
      return (intent.getIntExtra(BatteryManager.EXTRA_LEVEL, -1) * 100) /
          intent.getIntExtra(BatteryManager.EXTRA_SCALE, -1);
    }
  }
}