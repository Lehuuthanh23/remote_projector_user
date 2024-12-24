package com.example.remote_projector_2024.plugin

import android.content.Context
import android.net.Uri
import androidx.core.content.FileProvider
import java.io.File

class InstallFileProvider : FileProvider() {
    companion object {
        fun getUriForFile(context: Context, file: File): Uri {
            val authority = "${context.packageName}.installFileProvider.install"
            return getUriForFile(context, authority, file)
        }
    }
}