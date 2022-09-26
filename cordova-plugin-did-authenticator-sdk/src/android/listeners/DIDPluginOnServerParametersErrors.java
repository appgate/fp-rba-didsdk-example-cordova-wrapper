package com.appgate.did.DetectIDCordovaPlugin.listeners;


import com.appgate.token.challenge.otp.api.OnServerParametersErrors;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

public class DIDPluginOnServerParametersErrors implements OnServerParametersErrors {

    private final CallbackContext callbackContext;

    private static DIDPluginOnServerParametersErrors instance;

    public DIDPluginOnServerParametersErrors(CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
    }

    @Override
    public void onInvalidTimeStampLength(int length, String reason) {
        String error = length + " " + reason;
        PluginResult result = new PluginResult(PluginResult.Status.ERROR, error);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);

    }

    @Override
    public void onInvalidLengthToken(int length, String reason) {
        String error = length + " " + reason;

        PluginResult result = new PluginResult(PluginResult.Status.ERROR, error);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);
    }
}
