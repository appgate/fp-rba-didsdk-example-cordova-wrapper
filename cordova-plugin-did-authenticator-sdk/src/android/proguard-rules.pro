# Add project specific ProGuard rules here.
# By default, the flags in this file are appended to flags specified
# in /Users/danielfernandez/Library/Android/sdk/tools/proguard/proguard-android.txt
# You can edit the include path and order by changing the proguardFiles
# directive in build.gradle.
#
# For more details, see
#   http://developer.android.com/guide/developing/tools/proguard.html

# Add any project specific keep options here:

# If your project uses WebView with JS, uncomment the following
# and specify the fully qualified class name to the JavaScript interface
# class:
#-keepclassmembers class fqcn.of.javascript.interface.for.webview {
#   public *;
#}

-dontwarn com.appgate.shortcuts.**
-dontwarn com.appgate.did.**
-dontwarn com.appgate.faceid.authenticator.**
-dontwarn com.appgate.liveness.**
-dontwarn com.appgate.faceid_detector_sdk.**
-dontwarn com.appgate.jni.dlib.**
-dontwarn com.appgate.mobile.commos.**
-keep class com.appgate.shortcuts.** {*;}
-keep class com.appgate.did.** {*;}
-keep class com.appgate.faceid.authenticator.** {*;}
-keep class com.appgate.liveness.** {*;}
-keep class com.appgate.faceid_detector_sdk.** {*;}
-keep class com.appgate.jni.dlib.** {*;}
-keep class com.appgate.mobile.commos.** {*;}

-dontwarn com.google.errorprone.annotations.**