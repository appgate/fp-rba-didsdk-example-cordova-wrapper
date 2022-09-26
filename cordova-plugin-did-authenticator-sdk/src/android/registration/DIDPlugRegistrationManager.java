package com.appgate.did.DetectIDCordovaPlugin.registration;

import android.content.Context;

import com.appgate.appgate_sdk.encryptor.exceptions.SDKException;
import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.handler.EnrollmentResultHandler;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.PluginResult;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


public class DIDPlugRegistrationManager {

    private static final String CODE_IS_NULL = "Code is null";
    private static final String OK = "OK";
    private static final String URL = "url";
    private static final String DATA = "data";

    private DIDPlugRegistrationManager() {

    }

    public static void didInit(Context context, CallbackContext callbackContext) throws JSONException {
        DetectID.sdk(context).didInit();
        DetectID.sdk(context).PUSH_API.enablePushAlertDefaultDialog(false);
        DetectID.sdk(context).PUSH_API.enablePushTransactionDefaultDialog(false);
        callbackContext.success();
    }

    public static void setDeviceRegistrationByCode(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject jsonDevicerRegistrationByCode = args.getJSONObject(0);
        String url = jsonDevicerRegistrationByCode.getString(URL);
        if (url != null) {
            DetectID.sdk(myContext).didRegistration(url, new EnrollmentResultHandler() {
                @Override
                public void onSuccess() {
                    PluginResult result = new PluginResult(PluginResult.Status.OK, OK);
                    // result.setKeepCallback(true);
                    callbackContext.sendPluginResult(result);
                }

                @Override
                public void onFailure(SDKException e) {
                    callbackContext.error(e.getMessage());
                }
            });
        } else {
            callbackContext.error(CODE_IS_NULL);
        }
    }

    public static void setDeviceRegistrationByQrCode(Context myContext,  JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject json = args.getJSONObject(0);
        String data = json.getString(DATA);
        DetectID.sdk(myContext).didRegistrationByQRCode(data, null, new EnrollmentResultHandler() {
            @Override
            public void onSuccess() {
                PluginResult result = new PluginResult(PluginResult.Status.OK, OK);
                callbackContext.sendPluginResult(result);
            }

            @Override
            public void onFailure(SDKException e) {
                callbackContext.error(e.getMessage());
            }
        });
    }
}
