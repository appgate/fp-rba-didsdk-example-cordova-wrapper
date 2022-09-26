package com.appgate.DetectID.Wrapper.Cordova.app;

import android.content.Intent;

import androidx.multidex.MultiDexApplication;

import com.appgate.did.DetectIDCordovaPlugin.listeners.DIDPluginPushAlertOpenListener;
import com.appgate.did.DetectIDCordovaPlugin.listeners.DIDPluginTransactionOpenListener;
import com.appgate.didm_auth.DetectID;
import com.appgate.didm_auth.libs.DIDAppLifeCycleHandler;
import com.appgate.demos.democordovadid.MainActivity;

public class MainApplication extends MultiDexApplication {

    private static MainApplication instance;

    public static MainApplication getInstance() {
        return instance;
    }

    @Override
    public void onCreate() {
        instance = this;
        super.onCreate();
        registerActivityLifecycleCallbacks(new DIDAppLifeCycleHandler());
        DetectID.sdk(this).getPushApi().setPushAlertOpenListener(DIDPluginPushAlertOpenListener.getInstance());
        DetectID.sdk(this).getPushApi().setPushTransactionOpenListener(DIDPluginTransactionOpenListener.getInstance());
    }

    public void OpenMainActivity() {
        Intent intent = new Intent(this, MainActivity.class);
        intent.setFlags(Intent.FLAG_ACTIVITY_NEW_TASK | Intent.FLAG_ACTIVITY_SINGLE_TOP);
        startActivity(intent);
    }

}
