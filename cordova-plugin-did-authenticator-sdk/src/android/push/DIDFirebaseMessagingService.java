package com.appgate.did.DetectIDCordovaPlugin.push;

import androidx.annotation.NonNull;

import com.appgate.appgate_sdk.data.device.provider.PushNotificationProvider;
import com.appgate.didm_auth.DetectID;
import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;

import java.util.Map;

public class DIDFirebaseMessagingService extends FirebaseMessagingService {

    @Override
    public void onMessageReceived(@NonNull RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);
        Map<String, String> data = remoteMessage.getData();
        if (!data.isEmpty() && DetectID.sdk(getApplicationContext()).isValidPayload(data)) {
            DetectID.sdk(getApplicationContext()).subscribePayload(data);
        }
    }

    @Override
    public void onNewToken(@NonNull String newToken) {
        super.onNewToken(newToken);
        DetectID.sdk(getApplicationContext()).receivePushServiceId(newToken, PushNotificationProvider.FIREBASE);
    }
}
