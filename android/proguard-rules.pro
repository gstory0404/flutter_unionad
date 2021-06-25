## 穿山甲广告忽略
-keep class com.bykv.vk.openvk.** { *; }
-keep public interface com.bykv.vk.openvk.downloadnew.** {*;}
-keep class com.pgl.sys.ces.* {*;}

## okhttp3忽略
-dontwarn com.squareup.okhttp3.**
-keep class com.squareup.okhttp3.** { *;}
-dontwarn okio.**