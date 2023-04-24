package com.example.flutter_programe_johnny

import android.content.Intent.getIntent
import android.os.Bundle
import android.util.Log
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import tech.cherri.tpdirect.api.*



class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.flutter_programe_johnny"
    // private var paymentData = PaymentData? = null
    private var LOAD_PAYMENT_DATA_REQUEST_CODE = 102
    private val tpdMerchant = TPDMerchant()
    private val tpdConsumer = TPDConsumer()

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    super.configureFlutterEngine(flutterEngine)
    MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler{
      // This method is invoked on the main thread.
      call, result ->
      when (call.method){
        in "callAndroid" -> {
          // 處理 callAndroid 方法的請求
          val response = "Hello from Android"
          result.success(response)
        }
        in "setupTappay" -> {
          if (context == null) {
            result.error("", "context is null", "")
          } else {
            val appId: Int? = call.argument("appId")
            val appKey: String? = call.argument("appKey")
            val serverType: String? = call.argument("serverType")
            setupTappay(appId, appKey, serverType, errorMessage = { result.error("", it, "") })
          }
        }
        in "isCardValid" -> {
          if (context == null) {
            result.error("", "context is null", "")
          } else {
            val cardNumber: String? = call.argument("cardNumber")
            val dueMonth: String? = call.argument("dueMonth")
            val dueYear: String? = call.argument("dueYear")
            val ccv: String? = call.argument("ccv")
            result.success(isCardValid(cardNumber, dueMonth, dueYear, ccv))
          }
        }
        in "getPrime" -> {
          if (context == null) {
            result.error("", "context is null", "")
          } else {
            val cardNumber: String? = call.argument("cardNumber")
            val dueMonth: String? = call.argument("dueMonth")
            val dueYear: String? = call.argument("dueYear")
            val ccv: String? = call.argument("ccv")
            getPrime(cardNumber, dueMonth, dueYear, ccv, prime = {
              result.success(it)
            }, failCallBack = {
              result.success(it)
            })
          }
        }
      }
    }
  }

   //設置Tappay環境
   private fun setupTappay(appId: Int?, appKey: String?, serverType: String?, errorMessage: (String) -> (Unit)) {
    var message = ""

    if (appId == 0 || appId == null) {
      message += "appId error"
    }

    if (appKey.isNullOrEmpty()) {
      message += "/appKey error"
    }

    if (serverType.isNullOrEmpty()) {
      message += "/serverType error"
    }

    if (message.isNotEmpty()) {
      errorMessage(message)
      return
    }

    val st: TPDServerType = if (serverType == "sandBox") (TPDServerType.Sandbox) else (TPDServerType.Production)

    TPDSetup.initInstance(context, appId!!, appKey, st)
  }

  //檢查信用卡的有效性
  private fun isCardValid(cardNumber: String?, dueMonth: String?, dueYear: String?, ccv: String?): Boolean {

    if (cardNumber.isNullOrEmpty()) {
      return false
    }

    if (dueMonth.isNullOrEmpty()) {
      return false
    }

    if (dueYear.isNullOrEmpty()) {
      return false
    }

    if (ccv.isNullOrEmpty()) {
      return false
    }

    val result = TPDCard.validate(StringBuffer(cardNumber), StringBuffer(dueMonth), StringBuffer(dueYear), StringBuffer(ccv))

    return result.isCCVValid && result.isCardNumberValid && result.isExpiryDateValid
  }

  //取得Prime
  private fun getPrime(cardNumber: String?, dueMonth: String?, dueYear: String?, ccv: String?, prime: (String) -> (Unit), failCallBack: (String) -> (Unit)) {

    if (cardNumber == null || dueMonth == null || dueYear == null || ccv == null) {
      failCallBack("{\"status\":\"\", \"message\":\"something is null\", \"prime\":\"\"}")
    }else{
      val cn = StringBuffer(cardNumber)
      val dm = StringBuffer(dueMonth)
      val dy = StringBuffer(dueYear)
      val cv = StringBuffer(ccv)
      val card = TPDCard(context, cn, dm, dy, cv).onSuccessCallback { tpPrime, _, _, _ ->
        prime("{\"status\":\"\", \"message\":\"\", \"prime\":\"$tpPrime\"}")
      }.onFailureCallback { status, message ->
        failCallBack("{\"status\":\"$status\", \"message\":\"$message\", \"prime\":\"\"}")
      }
      card.createToken("Unknown")
    }
  }
}