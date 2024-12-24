package com.example.remote_projector_2024.service

import android.content.Context
import android.content.Intent
import androidx.core.app.JobIntentService

class RestartAppService : JobIntentService() {
    override fun onHandleWork(intent: Intent) {
        val launchIntent = packageManager.getLaunchIntentForPackage(packageName)
        launchIntent?.addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        startActivity(launchIntent)
    }

    companion object {
        fun enqueueWork(context: Context, intent: Intent) {
            enqueueWork(context, RestartAppService::class.java, 1000, intent)
        }
    }
}