package com.gstory.flutter_unionad

import android.app.Activity
import android.content.Context
import android.os.Build
import android.util.DisplayMetrics
import android.view.View
import android.view.WindowManager
import java.lang.reflect.InvocationTargetException

/**
 * @Description:
 * @Author: gstory0404@gmail
 * @CreateDate: 2020/8/19 11:25
 */
object UIUtils {
    fun getScreenWidthDp(context: Context): Float {
        val scale = context.resources.displayMetrics.density.toFloat()
        val width = context.resources.displayMetrics.widthPixels.toFloat()
        var num = if (scale <= 0) 1f else scale
        return width / num + 0.5f
    }

    //全面屏、刘海屏适配
    fun getHeight(activity: Activity): Float {
        hideBottomUIMenu(activity)
        val height: Float
        val realHeight = getRealHeight(activity)
        height = if (UIUtils.hasNotchScreen(activity)) {
            px2dip(activity, realHeight - getStatusBarHeight(activity))
        } else {
            px2dip(activity, realHeight.toFloat())
        }
        return height
    }

    fun hideBottomUIMenu(activity: Activity?) {
        if (activity == null) {
            return
        }
        try {
            //隐藏虚拟按键，并且全屏
            if (Build.VERSION.SDK_INT > 11 && Build.VERSION.SDK_INT < 19) { // lower api
                val v = activity.window.decorView
                v.systemUiVisibility = View.GONE
            } else if (Build.VERSION.SDK_INT >= 19) {
                //for new api versions.
                val decorView = activity.window.decorView
                val uiOptions = (View.SYSTEM_UI_FLAG_LAYOUT_STABLE
                        or View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                        or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                        or View.SYSTEM_UI_FLAG_HIDE_NAVIGATION // hide nav bar
                        //                    | View.SYSTEM_UI_FLAG_FULLSCREEN // hide status bar
                        or View.SYSTEM_UI_FLAG_IMMERSIVE)
                decorView.systemUiVisibility = uiOptions
                activity.window.addFlags(WindowManager.LayoutParams.FLAG_TRANSLUCENT_NAVIGATION)
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }

    //获取屏幕真实高度，不包含下方虚拟导航栏
    fun getRealHeight(context: Context): Int {
        val windowManager = context.getSystemService(Context.WINDOW_SERVICE) as WindowManager
        val display = windowManager.defaultDisplay
        val dm = DisplayMetrics()
        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.JELLY_BEAN_MR1) {
            display.getRealMetrics(dm)
        } else {
            display.getMetrics(dm)
        }
        return dm.heightPixels
    }

    //获取状态栏高度
    fun getStatusBarHeight(context: Context): Float {
        var height = 0f
        val resourceId = context.applicationContext.resources.getIdentifier("status_bar_height", "dimen", "android")
        if (resourceId > 0) {
            height = context.applicationContext.resources.getDimensionPixelSize(resourceId).toFloat()
        }
        return height
    }

    /**
     * 根据手机的分辨率从 px(像素) 的单位 转成为 dp
     */
    fun px2dip(context: Context, pxValue: Float): Float {
        val scale = context.resources.displayMetrics.density
        var num = if (scale <= 0) 1f else scale
        return pxValue / num + 0.5f
    }

    /**
     * 根据手机的分辨率从 dp 的单位 转成为 px(像素)
     */
    fun dip2px(context: Context, dpValue: Float): Float {
        val scale = context.resources.displayMetrics.density
        return dpValue * scale + 0.5f
    }

    /**
     * 判断是否是刘海屏
     * @return
     */
    fun hasNotchScreen(activity: Activity): Boolean {
        return if (getInt("ro.miui.notch", activity) == 1 || hasNotchAtHuawei(activity) || hasNotchAtOPPO(activity)
                || hasNotchAtVivo(activity) || isAndroidPHasNotch(activity)) {
            true
        } else false
    }

    /**
     * Android P 刘海屏判断
     * @param activity
     * @return
     */
    fun isAndroidPHasNotch(activity: Activity?): Boolean {
        var ret = false
        if (Build.VERSION.SDK_INT >= 28) {
            try {
                val windowInsets = Class.forName("android.view.WindowInsets")
                val method = windowInsets.getMethod("getDisplayCutout")
                val displayCutout = method.invoke(windowInsets)
                if (displayCutout != null) {
                    ret = true
                }
            } catch (e: Exception) {
                e.printStackTrace()
            }
        }
        return ret
    }

    /**
     * 小米刘海屏判断.
     * @return 0 if it is not notch ; return 1 means notch
     * @throws IllegalArgumentException if the key exceeds 32 characters
     */
    fun getInt(key: String?, activity: Activity): Int {
        var result = 0
        if (isMiui()) {
            try {
                val classLoader = activity.classLoader
                val SystemProperties = classLoader.loadClass("android.os.SystemProperties")
                //参数类型
                val paramTypes = arrayOfNulls<Class<*>?>(2)
                paramTypes[0] = String::class.java
                paramTypes[1] = Int::class.javaPrimitiveType
                val getInt = SystemProperties.getMethod("getInt", *paramTypes)
                //参数
                val params = arrayOfNulls<Any>(2)
                params[0] = String
                params[1] = Int
                result = getInt.invoke(SystemProperties, *params) as Int
            } catch (e: ClassNotFoundException) {
                e.printStackTrace()
            } catch (e: NoSuchMethodException) {
                e.printStackTrace()
            } catch (e: IllegalAccessException) {
                e.printStackTrace()
            } catch (e: IllegalArgumentException) {
                e.printStackTrace()
            } catch (e: InvocationTargetException) {
                e.printStackTrace()
            }
        }
        return result
    }

    /**
     * 华为刘海屏判断
     * @return
     */
    fun hasNotchAtHuawei(context: Context): Boolean {
        var ret = false
        try {
            val classLoader = context.classLoader
            val HwNotchSizeUtil = classLoader.loadClass("com.huawei.android.util.HwNotchSizeUtil")
            val get = HwNotchSizeUtil.getMethod("hasNotchInScreen")
            ret = get.invoke(HwNotchSizeUtil) as Boolean
        } catch (e: ClassNotFoundException) {
        } catch (e: NoSuchMethodException) {
        } catch (e: Exception) {
        } finally {
            return ret
        }
    }

    val VIVO_NOTCH = 0x00000020 //是否有刘海

    val VIVO_FILLET = 0x00000008 //是否有圆角


    /**
     * VIVO刘海屏判断
     * @return
     */
    fun hasNotchAtVivo(context: Context): Boolean {
        var ret = false
        try {
            val classLoader = context.classLoader
            val FtFeature = classLoader.loadClass("android.util.FtFeature")
            val method = FtFeature.getMethod("isFeatureSupport", Int::class.javaPrimitiveType)
            ret = method.invoke(FtFeature, VIVO_NOTCH) as Boolean
        } catch (e: ClassNotFoundException) {
        } catch (e: NoSuchMethodException) {
        } catch (e: Exception) {
        } finally {
            return ret
        }
    }

    /**
     * OPPO刘海屏判断
     * @return
     */
    fun hasNotchAtOPPO(context: Context): Boolean {
        return context.packageManager.hasSystemFeature("com.oppo.feature.screen.heteromorphism")
    }

    fun isMiui(): Boolean {
        var sIsMiui = false
        try {
            val clz = Class.forName("miui.os.Build")
            if (clz != null) {
                sIsMiui = true
                return sIsMiui
            }
        } catch (e: Exception) {
            // ignore
        }
        return sIsMiui
    }
}