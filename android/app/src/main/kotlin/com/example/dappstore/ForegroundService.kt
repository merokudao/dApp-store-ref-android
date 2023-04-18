package com.merokudao.dappstore

import android.R
import android.app.Notification
import android.app.NotificationChannel
import android.app.NotificationManager
import android.app.PendingIntent
import android.app.Service
import android.content.Context
import android.content.Intent
import android.graphics.Color
import android.os.Build
import android.os.IBinder
import android.util.Log
import androidx.annotation.RequiresApi
import androidx.core.app.NotificationCompat

class ForegroundService: Service() {
    companion object{
        var IS_ACTIVITY_RUNNING = false
    }


    override fun onDestroy() {
        super.onDestroy()
        IS_ACTIVITY_RUNNING = false
    }

    @RequiresApi(Build.VERSION_CODES.O)
    private fun createNotificationChannel(channelId: String, channelName: String): String{
        Log.d("FG","In create notifs");

        val chan = NotificationChannel(channelId,
            channelName, NotificationManager.IMPORTANCE_NONE)
        chan.lightColor = Color.BLUE
        chan.lockscreenVisibility = Notification.VISIBILITY_PRIVATE
        val service = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager
        service.createNotificationChannel(chan)
        return channelId
    }
    override fun onStartCommand(intent: Intent?, flags: Int, startId: Int): Int {
        Log.d("FG","In start cmd");

        val channelId =
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
                    createNotificationChannel("STICKY", "APP Download")
                } else {
                    // If earlier version channel ID is not used
                    // https://developer.android.com/reference/android/support/v4/app/NotificationCompat.Builder.html#NotificationCompat.Builder(android.content.Context)
                    ""
                }
        val notificationIntent = Intent(this, MainActivity::class.java)

        val pendingIntent = PendingIntent.getActivity(
            this, 0,
            notificationIntent, PendingIntent.FLAG_IMMUTABLE
        )

        val notification: Notification = NotificationCompat.Builder(this, channelId)
            .setOngoing(true)
            .setContentTitle("dApp Store")
            .setContentText("This notification allows us to download apps in background")
            .setContentIntent(pendingIntent).build()

        startForeground(1, notification)
        IS_ACTIVITY_RUNNING= true;
        super.onCreate()
        return START_NOT_STICKY
    }

    override fun onBind(p0: Intent?): IBinder? {
        TODO("Not yet implemented")
    }


}