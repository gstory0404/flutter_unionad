package com.gstory.flutter_unionad

import android.content.Context
import java.io.IOException


/**
 * @Author: gstory
 * @CreateDate: 2025/6/23 14:45
 * @Description: java类作用描述
 */

object FileUtils {
    fun loadJSONFromAsset(context : Context, fileName:String) : String{
        var json: String
        try {
            val inputStream = context.assets.open(fileName)
            val size = inputStream.available()
            val buffer = ByteArray(size)
            inputStream.read(buffer)
            inputStream.close()
            json = String(buffer, charset("UTF-8"))
        } catch (ex: IOException) {
            ex.printStackTrace()
            return ""
        }
        return json
    }
}