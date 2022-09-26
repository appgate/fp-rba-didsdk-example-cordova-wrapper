package com.appgate.did.DetectIDCordovaPlugin.listeners;

import com.appgate.didm_auth.push_auth.transaction.listener.PushTransactionServerResponseListener;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

/**
 * Created by John Garcia on 29/05/2018.
 */

public class DIDPluginTransactionServerResponseListener implements PushTransactionServerResponseListener {
    private CallbackContext callbackContext;

    public DIDPluginTransactionServerResponseListener(CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
    }

    @Override
    public void onPushTransactionServerResponse(String response) {
        PluginResult result = new PluginResult(PluginResult.Status.OK, response);
        // result.setKeepCallback(false);
        callbackContext.sendPluginResult(result);
    }
}
