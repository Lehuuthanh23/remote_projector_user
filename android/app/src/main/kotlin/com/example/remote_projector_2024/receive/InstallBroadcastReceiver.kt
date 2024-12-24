import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import com.example.remote_projector_2024.service.RestartAppService

class InstallBroadcastReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val packageName = intent.data?.schemeSpecificPart
        if (packageName == context.packageName) {
            val serviceIntent = Intent(context, RestartAppService::class.java)
            RestartAppService.enqueueWork(context, serviceIntent)
        }
    }
}