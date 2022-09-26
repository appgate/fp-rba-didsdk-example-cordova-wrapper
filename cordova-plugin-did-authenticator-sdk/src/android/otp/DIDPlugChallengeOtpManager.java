package com.appgate.did.DetectIDCordovaPlugin.otp;

import android.content.Context;
;
import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.appgate.didm_auth.otp_auth.ocra.OtpToken;
import com.google.gson.Gson;

import com.appgate.did.DetectIDCordovaPlugin.listeners.DIDPluginOnClientArgumentsErrors;
import com.appgate.did.DetectIDCordovaPlugin.listeners.DIDPluginOnServerParametersErrors;
import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

class DIDPlugChallengeOtpManager {
    private static final String ACCOUNT = "account";
    private static final String ANSWER = "answer";
    private static final String ERROR = "ChallengeQuestionOtp - TokenValue is null";

    private DIDPlugChallengeOtpManager() {

    }

    static void getChallengeTokenValue(Context context, JSONArray args, CallbackContext callbackContext) {
        try {
            Account account = getAccountFromJsonObject(args);
            String answer = getAnswerFromJsonObject(args);
            OtpToken otpToken = DetectID.sdk(context).getChallengeOtpApi().getChallengeQuestionOtp(account,
                    answer,
                    new DIDPluginOnServerParametersErrors(callbackContext),
                    new DIDPluginOnClientArgumentsErrors(callbackContext)
            );
            if (otpToken != null && otpToken.getTokenValue() != null) {
                callbackContext.success(otpToken.getTokenValue());
            } else {
                callbackContext.error(ERROR);
            }
        } catch (JSONException e) {
            callbackContext.error(e.getMessage());
        }
    }

    private static Account getAccountFromJsonObject(JSONArray args) throws JSONException {
        JSONObject accountJson = args.getJSONObject(0);
        return new Gson().fromJson(accountJson.get(ACCOUNT).toString(), Account.class);
    }

    private static String getAnswerFromJsonObject(JSONArray args) throws JSONException {
        JSONObject accountJson = args.getJSONObject(0);
        return accountJson.get(ANSWER).toString();
    }
}
