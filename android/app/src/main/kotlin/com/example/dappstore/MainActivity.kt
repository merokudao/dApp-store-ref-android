package com.merokudao.dappstore

import android.content.Intent
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.lang.Exception

class MainActivity: FlutterActivity() {
    private val CHANNEL = "dappStore/platformChannel"
    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            when (call.method) {
                "StartForegroundService" -> {
                    try{
                        Log.d("FG","In start forground")
                        if(ForegroundService.IS_ACTIVITY_RUNNING){
                            result.success(true);
                        }else{
                            val intent = Intent(context, ForegroundService::class.java)
                            context.startService(intent)
                            result.success(true)
                        }
                       
                    }catch(e:Exception){
                        result.error("0", e.message.toString(),  null)
                    }

                }
                "StopForegroundService" -> {
                    try{
                        Log.d("FG","In Stop forground")
                        if(ForegroundService.IS_ACTIVITY_RUNNING){
                            val intent = Intent(context, ForegroundService::class.java)
                            context.stopService(intent)
                            result.success(true)
                        }else {
                            result.success(true)
                        }
                      
                    }catch(e:Exception){
                        result.error("0", e.message.toString(),  null)
                    }
                }
                "IsForegroundServiceRunning" -> {
                    try{
                        Log.d("FG","In status forground")

                        result.success(ForegroundService.IS_ACTIVITY_RUNNING)
                    }catch(e:Exception){
                        result.error("0", e.message.toString(),  null)

                    }
                }
            }
        }
    }
}
