package com.appgate.did.DetectIDCordovaPlugin.push;

import android.content.Context;

import com.appgate.appgate_sdk.encryptor.exceptions.SDKException;
import com.appgate.did.DetectIDCordovaPlugin.listeners.DIDPluginTransactionOpenListener;
import com.appgate.did.DetectIDCordovaPlugin.listeners.DIDPluginTransactionReceiveListener;
import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.handler.TransactionResultHandler;
import com.appgate.didm_auth.common.transaction.TransactionInfo;
import com.appgate.didm_auth.push_auth.transaction.views.PushTransactionViewProperties;
import com.google.gson.Gson;

import org.apache.cordova.CallbackContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.Map;

public class DIDPlugPushTransactionManager {

    private static final String CONFIRM = "CONFIRM";
    private static final String DECLINE = "DECLINE";
    private static final String ENABLE_NOTIFICATION_QUICK_ACTIONS = "ENABLE_NOTIFICATION_QUICK_ACTIONS";
    private static final String NOTIFICATION_ICON_RESOURCE = "NOTIFICATION_ICON_RESOURCE";
    private static final String CONFIRM_ICON_RESOURCE = "CONFIRM_ICON_RESOURCE";
    private static final String DECLINE_ICON_RESOURCE = "DECLINE_ICON_RESOURCE";
    private static final String DRAWABLE = "drawable";

    private DIDPlugPushTransactionManager() {
    }

    public static void setPushTransactionViewProperties(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        JSONObject jsonPushTransactionViewProperties = new JSONObject(args.get(0).toString());
        PushTransactionViewProperties pushTransactionViewProperties = DetectID.sdk(myContext).getPushTransactionViewPropertiesInstance();

        if (jsonPushTransactionViewProperties.has(NOTIFICATION_ICON_RESOURCE)) {
            pushTransactionViewProperties.setNotificationIconResource(myContext
                    .getResources()
                    .getIdentifier(jsonPushTransactionViewProperties.getString(NOTIFICATION_ICON_RESOURCE), DRAWABLE, myContext.getPackageName()));
        }
        if (jsonPushTransactionViewProperties.has(CONFIRM_ICON_RESOURCE)) {
            pushTransactionViewProperties.setConfirmIconResource(myContext
                    .getResources()
                    .getIdentifier(jsonPushTransactionViewProperties.getString(CONFIRM_ICON_RESOURCE), DRAWABLE, myContext.getPackageName()));
        }
        if (jsonPushTransactionViewProperties.has(DECLINE_ICON_RESOURCE)) {
            pushTransactionViewProperties.setDeclineIconResource(myContext
                    .getResources()
                    .getIdentifier(jsonPushTransactionViewProperties.getString(DECLINE_ICON_RESOURCE), DRAWABLE, myContext.getPackageName()));
        }
        if (jsonPushTransactionViewProperties.has(ENABLE_NOTIFICATION_QUICK_ACTIONS)) {
            pushTransactionViewProperties.setEnableNotificationQuickActions(jsonPushTransactionViewProperties.getBoolean(ENABLE_NOTIFICATION_QUICK_ACTIONS));
        }
        if (jsonPushTransactionViewProperties.has(CONFIRM)) {
            pushTransactionViewProperties.setConfirm(jsonPushTransactionViewProperties.getString(CONFIRM));
        }
        if (jsonPushTransactionViewProperties.has(DECLINE)) {
            pushTransactionViewProperties.setDecline(jsonPushTransactionViewProperties.getString(DECLINE));
        }
        DetectID.sdk(myContext).getPushApi().setPushTransactionViewProperties(pushTransactionViewProperties);
        callbackContext.success();
    }

    public static void setPushTransactionReceiveListener(Context myContext, JSONArray args, CallbackContext callbackContext) {
        DetectID.sdk(myContext).getPushApi().setPushTransactionReceivedListener(new DIDPluginTransactionReceiveListener(callbackContext));
    }

    public static void setPushTransactionOpenListener(Context myContext, JSONArray args, CallbackContext callbackContext) {
        DIDPluginTransactionOpenListener.getInstance().setCallbackContext(callbackContext);
        DetectID.sdk(myContext).getPushApi().setPushTransactionOpenListener(DIDPluginTransactionOpenListener.getInstance());
    }

    public static void confirmPushTransactionAction(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        TransactionInfo transactionInfo = new Gson().fromJson(args.getString(0), TransactionInfo.class);
        transactionInfo.setType(TransactionInfo.TransactionType.PUSH_AUTHENTICATION);

        DetectID.sdk(myContext).getPushApi().confirmPushTransactionAction(transactionInfo, new TransactionResultHandler() {
            @Override
            public void onSuccess() {
                callbackContext.success();
            }

            @Override
            public void onFailure(SDKException e) {
                callbackContext.error(e.getMessage());
            }
        });
    }

    public static void declinePushTransactionAction(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        TransactionInfo transactionInfo = new Gson().fromJson(args.getString(0), TransactionInfo.class);
        transactionInfo.setType(TransactionInfo.TransactionType.PUSH_AUTHENTICATION);
        DetectID.sdk(myContext).getPushApi().declinePushTransactionAction(transactionInfo, new TransactionResultHandler() {
            @Override
            public void onSuccess() {
                callbackContext.success();
            }

            @Override
            public void onFailure(SDKException e) {
                callbackContext.error(e.getMessage());
            }
        });
    }

    public static void setPushAuthenticationResponseAdditionalInfo(Context myContext, JSONArray args, CallbackContext callbackContext) throws JSONException {
        Map<String, String> map = new Gson().fromJson(args.get(0).toString(), Map.class);
        DetectID.sdk(myContext).getPushApi().setPushAuthenticationResponseAdditionalInfo(map);
    }
}
