package com.feedhenry.phonegap.orientation;

import org.json.JSONArray;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaPlugin;

import android.content.pm.ActivityInfo;

public class DeviceOrientation extends CordovaPlugin{
  
  public String setOrientation(String pOri){
    String newOri = "";
    int currentOrientation = this.cordova.getActivity().getRequestedOrientation();
    if("portrait".equalsIgnoreCase(pOri) && currentOrientation != ActivityInfo.SCREEN_ORIENTATION_PORTRAIT){
      this.cordova.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_PORTRAIT);
      newOri = "portrait";
    } else if("landscape".equalsIgnoreCase(pOri) && currentOrientation != ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE) {
      this.cordova.getActivity().setRequestedOrientation(ActivityInfo.SCREEN_ORIENTATION_LANDSCAPE);
      newOri = "landscape";
    }
    return newOri;
  }

  @Override
  public boolean execute(String action, JSONArray args, CallbackContext pCallbackContext) {
    try{
      if("setOrientation".equalsIgnoreCase(action)){
        String newOri = args.getString(0);
        String ori = setOrientation(newOri);
        pCallbackContext.success(ori);
        return true;
      } else {
        pCallbackContext.error("unknown action : " + action);
        return false;
      }
    }catch(Exception e){
      pCallbackContext.error(e.getMessage());
      return false;
    }
  }
  
}
