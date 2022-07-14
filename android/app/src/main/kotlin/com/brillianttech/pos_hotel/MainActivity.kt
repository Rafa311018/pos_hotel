package com.brillianttech.pos_hotel

import android.app.Activity
import android.os.Bundle

import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

import android.content.Context
import android.content.ContextWrapper
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import android.os.Build.VERSION
import android.os.Build.VERSION_CODES
import android.view.Gravity
import android.widget.Toast
import com.google.gson.Gson
import mx.com.netpay.sdk.IPage

import mx.com.netpay.sdk.SmartApiFactory
import mx.com.netpay.sdk.exceptions.SmartApiException
import mx.com.netpay.sdk.models.*
import org.json.JSONArray

class MainActivity: FlutterActivity() {

    private val CHANNEL = "com.netpay.nw/netpaySDK"

    private val CHANNEL_REPORT = "com.netpay.nw/generateReport"

    private val CHANNEL_REPORTVENTAEFECTIVO = "com.netpay.nw/generateReportVentaEfectivo"

    private val smartApi = SmartApiFactory.createSmartApi(this)

    private var resultJSON = ""

    var mResult: MethodChannel.Result? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if(data != null) {
            val response = when(requestCode) {
                Constants.SALE_REQUEST -> smartApi.onResult(requestCode,resultCode,data) as SaleResponse
                Constants.CANCEL_REQUEST -> smartApi.onResult(requestCode,resultCode,data) as CancelResponse
                Constants.REPRINT_REQUEST-> smartApi.onResult(requestCode,resultCode,data) as ReprintResponse
                else -> null
            }

            //resultJSON = Gson().toJson(response)

            mResult?.success(Gson().toJson(response))

        }
    }

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->

            if (call.method == "getSell") {

                mResult = result

                val amount = call.argument<Double>("amount")
                val folio = call.argument<String>("folio")
                val tip = call.argument<Double>("tip")

                val createSell = amount?.let {
                    if (folio != null) {
                        if (tip != null) {
                            getSell(it, folio, tip)
                        }
                    }
                };

            }else{
                result.notImplemented()
            }
        }

/*
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_REPORT).setMethodCallHandler {
            call, result ->

            if (call.method == "generateReport") {

                mResult = result

                val totalSells = call.argument<Int>("totalSells")
                val dateReportSell = call.argument<String>("dateReportSell")

                val totalAllSells = call.argument<Double>("totalAllSells")
                val paymentMethods = call.argument<String>("paymentMethods")

                val articlePrice = call.argument<Double>("articlePrice")

                val createReport = totalSells?.let {
                    if (dateReportSell != null) {
                        if (totalAllSells != null) {
                            if (paymentMethods != null) {
                                if (articlePrice != null) {
                                    generateReport(it, dateReportSell, totalAllSells, paymentMethods, articlePrice)
                                }
                            }
                        }
                    }
                }

            }else{
                result.notImplemented()
            }
        }
*/

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_REPORT).setMethodCallHandler {
            call, result ->


            if (call.method == "generateReport") {

                mResult = result

                val dateReportSell = call.argument<String>("dateReportSell")
                val dataReport = call.argument<String>("dataReport")
                val totalReport = call.argument<String>("totalReport")

                if (dateReportSell != null) {
                    if (dataReport != null) {
                        generateReport(dateReportSell, dataReport, totalReport)
                    }
                }
                //result.success(true)
            }else{

                result.notImplemented();
            }
        }

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL_REPORTVENTAEFECTIVO).setMethodCallHandler {
            call, result ->


            if (call.method == "generateReportVentaEfectivo") {

                mResult = result

                val folio = call.argument<Int>("folioID")
                val totalSells = call.argument<Int>("totalSells")
                val dateReportSell = call.argument<String>("dateReportSell")

                val totalAllSells = call.argument<Double>("totalAllSells")
                val paymentMethods = call.argument<String>("paymentMethods")

                val articlePrice = call.argument<Double>("articlePrice")

                val createReport = totalSells?.let {
                    if (folio != null){
                        if (dateReportSell != null) {
                            if (totalAllSells != null) {
                                if (paymentMethods != null) {
                                    if (articlePrice != null) {
                                        generateReportVentaEfectivo(it, folio, dateReportSell, totalAllSells, paymentMethods, articlePrice)
                                    }
                                }
                            }
                        }
                    }
                }

            }else{

                result.notImplemented()
            }
        }
    }

    private fun getSell(_amount : Double, _folio: String, _tip: Double): String{
        val sale = SaleRequest("com.brillianttech.pos_hotel", amount = _amount, folio = _folio, tip = _tip)

        try {
            smartApi.doTrans(sale)
        } catch (e: SmartApiException) {
            //Toast.makeText(this, e.message, Toast.LENGTH_LONG).show()
            e.toString()
        }

        return ""
    }


/*    private fun generateReport(totalSells : Int, dateReportSell : String, totalAllSells : Double, paymentMethods : String, articlePrice : Double){


        val page: IPage = smartApi.createPage()

        //Crear unidad que contiene texto y otros formatos

        //Crear unidad que contiene texto y otros formatos
        val unit1: IPage.ILine.IUnit = page.createUnit()
        unit1.text = "REPORTE DE VENTA"
        unit1.gravity = Gravity.CENTER
        unit1.fontSize = 30
        unit1.textStyle = 3
        page.addLine().topSpaceAdjustment = 30
        page.addLine().addUnit(unit1)

        val unit2: IPage.ILine.IUnit = page.createUnit()
        //page.lineSpaceAdjustment = 10
        unit2.text = "Fecha $dateReportSell"
        unit2.gravity = Gravity.END
        page.addLine().topSpaceAdjustment = 15
        page.addLine().addUnit(unit2)

        val unit3: IPage.ILine.IUnit = page.createUnit()
        val unit4: IPage.ILine.IUnit = page.createUnit()

        unit3.text = "Métodos de pago:"
        unit3.gravity = Gravity.START

        unit3.fontSize = 23
        unit3.textStyle = 3

        unit4.text = paymentMethods
        unit4.gravity = Gravity.END
        unit4.fontSize = 24

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15
        page.addLine().addUnit(unit3).addUnit(unit4)


        val unit5: IPage.ILine.IUnit = page.createUnit()
        val unit6: IPage.ILine.IUnit = page.createUnit()
        unit5.text = "Total de ventas:"
        unit5.gravity = Gravity.START

        unit5.fontSize = 23
        unit5.textStyle = 3

        //val quantity = "totalSells = %.2f".format(totalSells)
        //val quantity = String.format("%.2f",totalSells)

        unit6.text = "$totalSells"
        unit6.gravity = Gravity.END
        unit6.fontSize = 27

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15

        page.addLine().addUnit(unit5).addUnit(unit6)


        val unit7: IPage.ILine.IUnit = page.createUnit()
        val unit8: IPage.ILine.IUnit = page.createUnit()

        unit7.text = "Precio unitario:"
        unit7.gravity = Gravity.START

        unit7.fontSize = 23
        unit7.textStyle = 3

        val unitprice = "%.2f".format(articlePrice)
        //val unitprice = String.format("%.2f",articlePrice)

        unit8.text = "\$$unitprice"
        unit8.gravity = Gravity.END
        unit8.fontSize = 27

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15

        page.addLine().addUnit(unit7).addUnit(unit8)


        val unit9: IPage.ILine.IUnit = page.createUnit()
        val unit10: IPage.ILine.IUnit = page.createUnit()

        unit9.text = "Total:"
        unit9.fontSize = 27
        unit9.textStyle = 3
        unit9.gravity = Gravity.START

        val totalVenta = "%.2f".format(totalAllSells)
        //val unitprice = String.format("%.2f",articlePrice)

        unit10.text = "\$$totalVenta"
        unit10.gravity = Gravity.END
        unit10.fontSize = 27

        page.addLine().topSpaceAdjustment = 20
        page.addLine().topSpaceAdjustment = 20

        page.addLine().addUnit(unit9).addUnit(unit10)



        val printRequest = PrintRequest("com.brillianttech.pos_hotel", page)

        smartApi.doTrans(printRequest)

    }*/

    private fun generateReport(dateReportSell: String, dataReport: String, totalReport: String?){


        val page: IPage = smartApi.createPage()

        //Crear unidad que contiene texto y otros formatos
        val unit1: IPage.ILine.IUnit = page.createUnit()
        val unitDate: IPage.ILine.IUnit = page.createUnit()

        val totalSells: IPage.ILine.IUnit = page.createUnit()

        totalSells.text = "TOTAL $totalReport"
        totalSells.gravity = Gravity.END

        unit1.text = "REPORTE DIARIO"
        unit1.gravity = Gravity.CENTER
        unit1.fontSize = 30
        unit1.textStyle = 3
        unit1.weight = IPage.ILine.IUnit.BOLD.toFloat()

        unitDate.text = "Fecha $dateReportSell"
        unitDate.gravity = Gravity.CENTER
        unitDate.fontSize = 20

        page.addLine().addUnit(unit1)
        page.addLine().addUnit(unitDate)
        page.addLine().topSpaceAdjustment = 30

        val unit2: IPage.ILine.IUnit = page.createUnit()
        val unit3: IPage.ILine.IUnit = page.createUnit()
        val unit4: IPage.ILine.IUnit = page.createUnit()
        val unit5: IPage.ILine.IUnit = page.createUnit()
        unit2.text = "Cantidad";
        unit3.text = "Concepto"
        unit4.text = "Metodo"
        unit5.text = "Precio"
        unit2.gravity = Gravity.START
        unit3.gravity = Gravity.CENTER
        unit4.gravity = Gravity.END
        unit5.gravity = Gravity.END

        page.addLine().addUnit(unit2).addUnit(unit3).addUnit(unit4).addUnit(unit5)

        page.addLine().topSpaceAdjustment = 10


        var jsonArray = JSONArray(dataReport)

        //print(jsonArray);

        for (i in 0 until jsonArray.length()) {
            val quantityText: IPage.ILine.IUnit = page.createUnit()
            val conceptText: IPage.ILine.IUnit = page.createUnit()
            val paymentMethodText: IPage.ILine.IUnit = page.createUnit()
            val priceText: IPage.ILine.IUnit = page.createUnit()
            quantityText.text = jsonArray.optJSONObject(i).getString("quantity")
            conceptText.text = jsonArray.optJSONObject(i).getString("concept")
            paymentMethodText.text = jsonArray.optJSONObject(i).getString("payment_method")
            paymentMethodText.fontSize = 17
            priceText.text = jsonArray.optJSONObject(i).getString("price")
            quantityText.gravity = Gravity.CENTER
            conceptText.gravity = Gravity.CENTER
            paymentMethodText.gravity = Gravity.END
            priceText.gravity = Gravity.END
            page.addLine().addUnit(quantityText).addUnit(conceptText).addUnit(paymentMethodText).addUnit(priceText)
        }

        page.addLine().topSpaceAdjustment = 10

        page.addLine().addUnit(totalSells)

        val printRequest = PrintRequest("com.brillianttech.pos_hotel", page)

        smartApi.doTrans(printRequest)

    }

    private fun generateReportVentaEfectivo(totalSells : Int, folio : Int, dateReportSell : String, totalAllSells : Double, paymentMethods : String, articlePrice : Double){


        val page: IPage = smartApi.createPage()

        //Crear unidad que contiene texto y otros formatos

        //Crear unidad que contiene texto y otros formatos
        val unit1: IPage.ILine.IUnit = page.createUnit()
        unit1.text = "TICKET DE VENTA"
        unit1.gravity = Gravity.CENTER
        unit1.fontSize = 30
        unit1.textStyle = 3
        page.addLine().topSpaceAdjustment = 30
        page.addLine().addUnit(unit1)

        val unit2: IPage.ILine.IUnit = page.createUnit()
        //page.lineSpaceAdjustment = 10
        unit2.text = "Fecha $dateReportSell"
        unit2.gravity = Gravity.END
        page.addLine().topSpaceAdjustment = 15
        page.addLine().addUnit(unit2)

        val unit3: IPage.ILine.IUnit = page.createUnit()
        val unit4: IPage.ILine.IUnit = page.createUnit()

        unit3.text = "FolioID:"
        unit3.gravity = Gravity.START

        unit3.fontSize = 23
        unit3.textStyle = 3

        unit4.text = "$folio"
        unit4.gravity = Gravity.END
        unit4.fontSize = 24

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15
        page.addLine().addUnit(unit3).addUnit(unit4)

        val unit5: IPage.ILine.IUnit = page.createUnit()
        val unit6: IPage.ILine.IUnit = page.createUnit()

        unit5.text = "Métodos de pago:"
        unit5.gravity = Gravity.START

        unit5.fontSize = 23
        unit5.textStyle = 3

        unit6.text = paymentMethods
        unit6.gravity = Gravity.END
        unit6.fontSize = 24

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15
        page.addLine().addUnit(unit5).addUnit(unit6)


        val unit7: IPage.ILine.IUnit = page.createUnit()
        val unit8: IPage.ILine.IUnit = page.createUnit()
        unit7.text = "Cantidad:"
        unit7.gravity = Gravity.START

        unit7.fontSize = 23
        unit7.textStyle = 3

        //val quantity = "totalSells = %.2f".format(totalSells)
        //val quantity = String.format("%.2f",totalSells)

        unit8.text = "$totalSells"
        unit8.gravity = Gravity.END
        unit8.fontSize = 27

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15

        page.addLine().addUnit(unit7).addUnit(unit8)


        val unit9: IPage.ILine.IUnit = page.createUnit()
        val unit10: IPage.ILine.IUnit = page.createUnit()

        unit9.text = "Precio unitario:"
        unit9.gravity = Gravity.START

        unit9.fontSize = 23
        unit9.textStyle = 3

        val unitprice = "%.2f".format(articlePrice)
        //val unitprice = String.format("%.2f",articlePrice)

        unit10.text = "\$$unitprice"
        unit10.gravity = Gravity.END
        unit10.fontSize = 27

        page.addLine().topSpaceAdjustment = 15
        page.addLine().topSpaceAdjustment = 15

        page.addLine().addUnit(unit9).addUnit(unit10)


        val unit11: IPage.ILine.IUnit = page.createUnit()
        val unit12: IPage.ILine.IUnit = page.createUnit()

        unit11.text = "Total:"
        unit11.fontSize = 27
        unit11.textStyle = 3
        unit11.gravity = Gravity.START

        val totalVenta = "%.2f".format(totalAllSells)
        //val unitprice = String.format("%.2f",articlePrice)

        unit12.text = "\$$totalVenta"
        unit12.gravity = Gravity.END
        unit12.fontSize = 27

        page.addLine().topSpaceAdjustment = 20
        page.addLine().topSpaceAdjustment = 20

        page.addLine().addUnit(unit11).addUnit(unit12)



        val printRequest = PrintRequest("com.brillianttech.pos_hotel", page)

        smartApi.doTrans(printRequest)

    }

}
