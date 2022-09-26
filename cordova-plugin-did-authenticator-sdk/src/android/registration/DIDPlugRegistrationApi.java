package com.appgate.did.DetectIDCordovaPlugin.registration;

import android.content.Context;
import android.util.Log;

import com.appgate.didm_auth.DetectID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;

public class DIDPlugRegistrationApi extends CordovaPlugin {

    private final String TAG = "DetectIDCordovaPlugin";
    private Context myContext;
    private final String didInit = "didInit";
    private final String DEVICE_REGISTRATION_BY_URL = "didRegistration";
    private final String DEVICE_REGISTRATION_BY_QR = "didRegistrationByQRCode";

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        try {
            myContext = cordova.getActivity().getApplicationContext();
            DetectID.sdk(myContext);

            if (action.equals(didInit)) {
                DIDPlugRegistrationManager.didInit(myContext, callbackContext);
            }
            if (action.equals(DEVICE_REGISTRATION_BY_URL)) {
                DIDPlugRegistrationManager.setDeviceRegistrationByCode(myContext, args, callbackContext);
            }
            if (action.equals(DEVICE_REGISTRATION_BY_QR)) {
                DIDPlugRegistrationManager.setDeviceRegistrationByQrCode(myContext, args,callbackContext);
            }

            return true;
        } catch (JSONException e) {
            Log.e(TAG, e.toString());
            callbackContext.error(e.toString());
        }
        return false;
    }
}
