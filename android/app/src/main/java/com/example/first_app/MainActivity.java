package com.example.first_app;

import android.content.ContextWrapper;
import android.content.Intent;
import android.content.IntentFilter;
import android.media.AudioManager;
import android.os.BatteryManager;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Bundle;
import android.util.Log;

import io.flutter.app.FlutterActivity;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

  private static final int WAVEMAKER2_REQUEST = 0;
  private static final String TAG = MainActivity.class.toString();

  //initialize cpp methods
  static native void create();
  static native void delete();
  static native void setEchoOn(boolean isEchoOn);
  public native void setVolumeSliderValue(int waarde);
  public native int getWaarde();
  private boolean isPlaying;

  int previousRingerMode;
  AudioManager am;

  // Used to load the 'native-lib' library on application startup.
  static {
    System.loadLibrary("native-lib");
  }

  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    GeneratedPluginRegistrant.registerWith(this);

    //put the phone in vibrate mode when the app starts to silence incoming messages and calls
    am = (AudioManager) getSystemService(getApplicationContext().AUDIO_SERVICE);
    previousRingerMode = am.getRingerMode();    //store previous ring mode to change it back when app is closed
    // load Flutter functions by the name audiorecorder (this name is a reference to the Flutter call of the methods)
    new MethodChannel(getFlutterView(), "audiorecorder").setMethodCallHandler(
            (call, result) -> {
              // call the Flutter methods, and execute the Java methods when they are called
              switch(call.method){
                case "setVolumeSliderValue":
                  double waarde = call.argument("waarde");
                  setVolumeSliderValue((int) waarde);
                  break;
                case "toggleAudioRecordingEcho":
                  toggleAudioRecordingEcho();
                  break;
                default:
                  result.notImplemented();
                  break;
              }
            }
    );
    create();
  }

  @Override
  public void onResume(){
    super.onResume();
  }

  @Override
  public void onPause() {
    super.onPause();
  }

  public void onDestroy(){
    delete();
    super.onDestroy();
  }
  // put the recorder on/off
  public void toggleAudioRecordingEcho() {
    if (isPlaying) {
      stopEchoing();
    } else {
      startEchoing();
    }
  }
  // start the recorder
  private void startEchoing() {
    Log.d(TAG, "Attempting to start");
    //cpp method
    setEchoOn(true);
    isPlaying = true;
  }
  // stop the recorder
  private void stopEchoing() {
    Log.d(TAG, "Playing, attempting to stop");
    //cpp method
    setEchoOn(false);
    isPlaying = false;
  }

}