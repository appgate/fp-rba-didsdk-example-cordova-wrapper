package com.appgate.did.DetectIDCordovaPlugin.inbox;

import android.content.Context;

import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.common.account.entities.Account;
import com.appgate.didm_auth.common.transaction.TransactionInfo;
import com.appgate.didm_auth.inbox.listener.TransactionInfoListener;
import com.appgate.didm_auth.push_auth.StatusTransaction;
import com.google.gson.Gson;

import org.apache.cordova.CallbackContext;
import org.apache.cordova.CordovaInterface;
import org.apache.cordova.CordovaPlugin;
import org.apache.cordova.CordovaWebView;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.List;

public class DIDPlugInboxApi extends CordovaPlugin {

    private Context context;

    @Override
    public void initialize(CordovaInterface cordova, CordovaWebView webView) {
        super.initialize(cordova, webView);
    }

    @Override
    public boolean execute(String action, JSONArray args, final CallbackContext callbackContext) throws JSONException {
        context = cordova.getActivity().getApplicationContext();
        switch (action) {
            case "setupTransactionInbox":
                setupTransactionInbox(args, callbackContext);
                return true;

            case "getAllTransactionsByType":
                getAllTransactionsByType(args, callbackContext);
                return true;

            default:
                return false;
        }
    }

    private void getAllTransactionsByType(JSONArray args, CallbackContext cb) {
        cordova.getThreadPool().execute(() -> {
            try {

                JSONObject accountJson = args.getJSONObject(0);
                Account account = DIDPlugHelper.convertJsonToAccount(accountJson);

                int typeInt = args.getInt(1);
                int statusInt = args.getInt(2);
                int page = args.getInt(3);


                DetectID.sdk(context).getInboxApi().getAllTransactionsByType(account, TransactionInfo.TransactionType.getTransactionType(typeInt), page, new TransactionInfoListener() {
                    @Override
                    public void onResponseSuccessful(List<TransactionInfo> list, int totalPages, int totalRecords) {
                        try {

                            JSONArray jsonArray = new JSONArray();
                            for (TransactionInfo info : list) {
                                JSONObject transactionInfoJson = DIDPlugHelper.convertTransactionInfoToJson(info);
                                jsonArray.put(transactionInfoJson);
                            }

                            JSONObject response = new JSONObject();
                            response.put("arrayTransactionInfo", jsonArray);
                            response.put("totalPages", totalPages);
                            response.put("totalRecords", totalRecords);

                            cb.success(response);
                        } catch (Throwable t) {
                            handleException(t, cb);
                        }
                    }

                    @Override
                    public void onResponseFail(String errorMessage) {
                        cb.error(errorMessage);
                    }
                }, DIDPlugHelper.fromCode(statusInt));

            } catch (JSONException e) {
                throw new RuntimeException(e);
            }
        });
    }

    private void setupTransactionInbox(final JSONArray args, final CallbackContext cb) {
        cordova.getThreadPool().execute(() -> {
            try {
                String urlPushAlert = args.optString(0, null);
                String urlPushAuth = args.optString(1, null);
                String urlPushBiometric = args.optString(2, null);

                DetectID.sdk(context).getInboxApi().setupTransactionInbox(
                        urlPushAlert, urlPushAuth, urlPushBiometric
                );

                cb.success();
            } catch (Throwable t) {
                handleException(t, cb);
            }
        });
    }

    private void handleException(Throwable t, CallbackContext cb) {
        String msg = (t.getMessage() != null) ? t.getMessage() : t.toString();
        cb.error(msg);
    }

    public static class DIDPlugHelper {
        public static Account convertJsonToAccount(JSONObject accountJson) throws JSONException {
            return new Gson().fromJson(accountJson.toString(), Account.class);
        }

        public static JSONObject convertTransactionInfoToJson(TransactionInfo info) throws JSONException {
            return new JSONObject(new Gson().toJson(info));
        }

        public static StatusTransaction fromCode(int statusInt) {
            for (StatusTransaction status : StatusTransaction.values()) {
                if (status.getCode() == statusInt) {
                    return status;
                }
            }
            return null;
        }
    }
}
