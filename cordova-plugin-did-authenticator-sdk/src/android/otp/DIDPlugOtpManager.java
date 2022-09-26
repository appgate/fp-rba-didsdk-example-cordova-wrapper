package com.appgate.did.DetectIDCordovaPlugin.otp;

import android.content.Context;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.google.gson.Gson;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

class DIDPlugOtpManager {

    private DIDPlugOtpManager() {

    }

    static void getTokenValue(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            String tokenValue = DetectID.sdk(context).getOtpApi().getTokenValue(account);
            callbackContext.success(tokenValue);
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    static void updateTokenTimeStepValue(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            DetectID.sdk(context).updateGlobalConfig(account);
            callbackContext.success();
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }
    static void getTokenTimeStepValue(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            int tokenValue = DetectID.sdk(context).getOtpApi().getTokenTimeStepValue(account);
            callbackContext.success(tokenValue);
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    private static Account getAccountFromJsonObject(JSONArray args) throws JSONException {
        JSONObject accountJson = args.getJSONObject(0);
        return new Gson().fromJson(accountJson.toString(), Account.class);
    }
}
