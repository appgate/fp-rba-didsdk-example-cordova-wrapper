package com.appgate.did.DetectIDCordovaPlugin.listeners;

import com.appgate.didm_auth.common.transaction.TransactionInfo;
import com.appgate.didm_auth.push_auth.transaction.listener.PushTransactionReceivedListener;
import com.google.gson.Gson;


import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;

/**
 * Created by John Garcia on 29/05/2018.
 */


public class DIDPluginTransactionReceiveListener implements PushTransactionReceivedListener {

    private CallbackContext callbackContext;

    public DIDPluginTransactionReceiveListener(CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
    }

    @Override
    public void onPushTransactionReceived(TransactionInfo transactionInfo) {
        String jsonTransactionInfo = new Gson().toJson(transactionInfo);
        PluginResult result = new PluginResult(PluginResult.Status.OK, jsonTransactionInfo);
        result.setKeepCallback(true);
        callbackContext.sendPluginResult(result);
    }
}
