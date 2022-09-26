package com.appgate.did.DetectIDCordovaPlugin.accounts;

import android.content.Context;

import com.appgate.didm_auth.DetectID;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;

public class DIDPlugAccountsApi extends CordovaPlugin {

    private final String TAG = "DetectIDCordovaPlugin";
    private Context myContext;

    private final String GET_ACCOUNTS = "getAccounts";
    private final String SET_ACCOUNT_USERNAME = "setAccountUsername";
    private final String REMOVE_ACCOUNT = "removeAccount";

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args, CallbackContext callbackContext) {
        myContext = cordova.getActivity().getApplicationContext();
        DetectID.sdk(myContext);

        if (action.equals(GET_ACCOUNTS)) {
            DIDPlugAccountsManager.getAccounts(myContext, callbackContext);
        }
        if (action.equals(SET_ACCOUNT_USERNAME)) {
            DIDPlugAccountsManager.setAccountUsername(myContext, args, callbackContext);
        }
        if (action.equals(REMOVE_ACCOUNT)) {
            DIDPlugAccountsManager.removeAccount(myContext, args, callbackContext);
        }

        return true;
    }
}
