package com.appgate.did.DetectIDCordovaPlugin.accounts;

import android.content.Context;

import com.google.gson.Gson;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

class DIDPlugAccountsManager {

    private DIDPlugAccountsManager() {

    }

    static void getAccounts(Context context, CallbackContext callbackContext) {
        try {
            List<Account> accounts = DetectID.sdk(context).getAccounts();
            String result = new Gson().toJson(accounts);
            JSONArray jsonArray = new JSONArray(result);
            callbackContext.success(jsonArray);
        } catch (IllegalArgumentException | JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    static void setAccountUsername(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            String username = getUsernameFromJsonObject(args);
            DetectID.sdk(context).setAccountUsername(account, username);
            callbackContext.success();
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    static void removeAccount(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            DetectID.sdk(context).removeAccount(account);
            callbackContext.success();
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    private static Account getAccountFromJsonObject(JSONArray args) throws JSONException {
        JSONObject accountJson = args.getJSONObject(0);
        return new Gson().fromJson(accountJson.get("currentAccount").toString(), Account.class);
    }

    private static String getUsernameFromJsonObject(JSONArray args) throws JSONException {
        JSONObject accountJson = args.getJSONObject(0);
        return accountJson.get("username").toString();
    }
}
