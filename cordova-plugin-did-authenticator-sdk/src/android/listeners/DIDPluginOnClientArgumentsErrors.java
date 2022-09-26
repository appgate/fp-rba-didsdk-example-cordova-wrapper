package com.appgate.did.DetectIDCordovaPlugin.listeners;

import com.appgate.token.challenge.otp.api.OnClientArgumentsErrors;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;


public class DIDPluginOnClientArgumentsErrors implements OnClientArgumentsErrors {

    private final CallbackContext callbackContext;

    private static DIDPluginOnClientArgumentsErrors instance;

    public DIDPluginOnClientArgumentsErrors(CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
    }

    @Override
    public void onInvalidChallengeLength(int length, String reason) {
        String error = length + " " + reason;
        PluginResult result = new PluginResult(PluginResult.Status.ERROR, error);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);

    }

    @Override
    public void onMissingPassword(String reason) {
        PluginResult result = new PluginResult(PluginResult.Status.ERROR, reason);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);
    }
}
