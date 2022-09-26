package com.appgate.did.DetectIDCordovaPlugin.listeners;

import com.appgate.appgate_sdk.data.utils.LogMessagePriority;
import com.appgate.appgate_sdk.data.utils.LogUtils;
import com.google.gson.Gson;
import com.appgate.DetectID.Wrapper.Cordova.app.MainApplication;

import com.appgate.didm_auth.common.transaction.TransactionInfo;
import com.appgate.didm_auth.push_auth.alert.listener.PushAlertOpenListener;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONException;
import org.json.JSONObject;

public class DIDPluginPushAlertOpenListener implements PushAlertOpenListener {

    private CallbackContext callbackContext;
    private TransactionInfo pendingTransactionInfo = null;

    private static DIDPluginPushAlertOpenListener instance;

    private DIDPluginPushAlertOpenListener() {
    }

    public static DIDPluginPushAlertOpenListener getInstance() {
        if (instance == null) {
            instance = new DIDPluginPushAlertOpenListener();
        }
        return instance;
    }

    public void setCallbackContext(CallbackContext callbackContext) {
        this.callbackContext = callbackContext;
        if (pendingTransactionInfo != null) {
            onPushAlertOpen(pendingTransactionInfo);
            pendingTransactionInfo = null;
        }
    }

    @Override
    public void onPushAlertOpen(TransactionInfo transactionInfo) {
        MainApplication.getInstance().OpenMainActivity();
        if (callbackContext == null) {
            pendingTransactionInfo = transactionInfo;
        } else {
            try {
                String jsonTransactionInfo = new Gson().toJson(transactionInfo);
                JSONObject jsonObject = new JSONObject(jsonTransactionInfo);
                PluginResult result = new PluginResult(PluginResult.Status.OK, jsonObject);
                result.setKeepCallback(true);
                callbackContext.sendPluginResult(result);
            } catch (JSONException e) {
                LogUtils.logErrorWithPriority(getClass().getSimpleName(), "onPushTransactionOpen", e.getMessage(), LogMessagePriority.NOT_IMPORTANT_NOT_URGENT);
            }
        }
    }
}
