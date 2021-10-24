package com.bkash.sim_detector

import android.Manifest
import android.content.Context
import android.content.Context.TELEPHONY_SUBSCRIPTION_SERVICE
import android.content.pm.PackageManager
import android.os.Build
import android.telephony.SubscriptionInfo
import android.telephony.SubscriptionManager
import android.telephony.SubscriptionManager.OnSubscriptionsChangedListener
import androidx.core.app.ActivityCompat
import java.util.*
import kotlin.collections.ArrayList

class SubscriptionChangeStreamHandler(var context: Context?, simSubscriptionChangeCallback: (subscribedSimInformation: PlatformApi.SubscribedSimInformation) -> Unit) {

    private val subscriptionManager: SubscriptionManager? by lazy {
        if (isApiLevelMoreThan21()) {
            context?.getSystemService(TELEPHONY_SUBSCRIPTION_SERVICE) as SubscriptionManager
        } else {
            null
        }
    }

    private val simSubscriptionChangeCallback by lazy {
        if (isApiLevelMoreThan21()) {
            object : OnSubscriptionsChangedListener() {
                override fun onSubscriptionsChanged() {
                    var subscriptionInfoList: MutableList<SubscriptionInfo>? = subscriptionManager?.activeSubscriptionInfoList
                    if(subscriptionInfoList == null){
                        subscriptionInfoList = ArrayList()
                    }
                    val subscribedSimInformation = PlatformApi.SubscribedSimInformation()
                    for (subscriptionInfo in subscriptionInfoList) {
                        if (subscriptionInfo.simSlotIndex == 0)
                            subscribedSimInformation.simSlotZeroSubscriptionId = subscriptionInfo.subscriptionId.toLong()
                        else if (subscriptionInfo.simSlotIndex == 1)
                            subscribedSimInformation.simSlotOneSubscriptionId = subscriptionInfo.subscriptionId.toLong()
                    }
                    // Notify Flutter that the sim subscription is changed
                    simSubscriptionChangeCallback(subscribedSimInformation)
                }
            }
        } else {
            null
        }
    }

    fun startListeningSimSubscriptionChanges() {
        if (isApiLevelMoreThan21() && isPhoneStatePermissionAvailable()) {
            subscriptionManager!!.addOnSubscriptionsChangedListener(simSubscriptionChangeCallback)
        }
    }

    fun stopListeningSimSubscriptionChanges() {
        if (isApiLevelMoreThan21()) {
            subscriptionManager?.removeOnSubscriptionsChangedListener(simSubscriptionChangeCallback)
        }
    }

    fun destroy() {
        stopListeningSimSubscriptionChanges()
    }

    private fun isApiLevelMoreThan21() = Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP_MR1

    private fun isPhoneStatePermissionAvailable() =
            ActivityCompat.checkSelfPermission(context!!, Manifest.permission.READ_PHONE_STATE) == PackageManager.PERMISSION_GRANTED
}