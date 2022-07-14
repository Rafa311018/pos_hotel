import 'dart:convert';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/data/repository/auth_repository.dart';
import 'package:pos_hotel/entities/remission_entity.dart';
import 'package:pos_hotel/entities/user_data.dart';
import 'package:pos_hotel/pages/tip_screen.dart';
import 'package:pos_hotel/utils/data_information.dart';
import 'package:pos_hotel/utils/utilitysp.dart';
import 'package:quiver/async.dart';

class PaymentServiceController extends GetxController {
  final AuthRepository repository = AuthRepository(apiClient: Api());
  UserData userData = DataInformation().readUserInfo();

  final quantityRemissionTextCtrl = TextEditingController(text: "");
  final totalRemissionTotalRemissionCtrl = TextEditingController(text: "");
  final tipAnotherAmount = TextEditingController(text: "0");
  final tipAnotherPercentage = TextEditingController(text: "0");

  String dropdownServiceValue = 'Hospedaje';
  String dropdownMethodPaymentValue = '1-Efectivo';
  int dropdownMethodPaymentNumber = 1;

  static const platform = MethodChannel('com.netpay.nw/netpaySDK');
  static const platformRep =
      MethodChannel('com.netpay.nw/generateReportVentaEfectivo');

  DateTime selectedDate = DateTime.now();
  double? totalSell = 0.0;
  double? unitPrice = 0.0;
  int quantity = 1;
  int Folio = 0;
  double tip = 0.0;

  bool isButtonActive = true;
  int _start = 10;
  int current = 10;

  UtilitySP utility = UtilitySP();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  //String statusSell = 'STATUS VENTA.';

  var jsonDesialization;

  Future<dynamic> getSell(double _amount, String _folio, double _tip) async {
    String _statusSell;
    try {
      final String result = await platform.invokeMethod(
          'getSell', {'amount': _amount, 'folio': _folio, 'tip': _tip});
      //_statusSell = 'Venta $result';

      jsonDesialization = jsonDecode(result);

      //log(jsonDesialization['success'].toString());

    } on PlatformException catch (e) {
      _statusSell = "Failed to connect with NetPay: '${e.message}'.";
    }

    //statusSell = _statusSell;

    update(['textService']);

    return jsonDesialization;
  }

  createRemission(BuildContext context) async {
    //TODO: Configuracion de Campos por Dispositivo
    if (isButtonActive) {
      print("BUTTON IS ACTIVE...");
      isButtonActive = false;
      print("BUTTON IS SET TO INACTIVE...");
      startTimer();
      //Calculating the Remision Fields
      quantity = int.parse(quantityRemissionTextCtrl.text);
      unitPrice =
          ((double.parse(totalRemissionTotalRemissionCtrl.text) / 1.16) /
              quantity);
      totalSell = double.parse(totalRemissionTotalRemissionCtrl.text);

      var FolioID = "";

      print("EmpresaID:${userData.empresaId}");

      try {
        await repository
            .getRemisionLastFolio(int.tryParse(userData.empresaId))
            .then((response) => {FolioID = response});
      } catch (err) {
        print('Error:$err');
      }

      Folio = int.parse(FolioID) + 1;
      print("Folio:$Folio");

      RemissionEntity remissionEntity = RemissionEntity(
          empresaId: int.tryParse(userData.empresaId),
          clienteId: int.tryParse(userData.clienteID!),
          cantidad: int.parse(quantityRemissionTextCtrl.text),
          folio: Folio,
          tip: tip,
          descripcion: dropdownServiceValue,
          precioUnitario: unitPrice,
          totalSell: totalSell,
          formaDePago: dropdownMethodPaymentNumber);

      var responseSellText = "";
      var responseText = "";
      var RemisionID = "";

      if (dropdownMethodPaymentNumber == 1) {
        //Efectivo
        try {
          await repository
              .getCreateRemission(remissionEntity)
              .then((response) => {responseText = response});
        } catch (err) {
          print('Error:$err');
        }
        RemisionID = responseText.replaceAll("Insertado correctamente ID:", "");
        generateReport();
        CoolAlert.show(
            context: context,
            type: CoolAlertType.success,
            title: 'Venta creada',
            text: "${responseSellText}\n${Folio}",
            confirmBtnColor: const Color(0xff278ea5));
      } else {
        //Credito o Debito con firma o sin firma electronica
        if (int.tryParse(userData.accesoCobro!) == 0) {
          try {
            await repository
                .getCreateRemission(remissionEntity)
                .then((response) => {responseText = response});
          } catch (err) {
            print('Error:$err');
          }
          RemisionID =
              responseText.replaceAll("Insertado correctamente ID:", "");
          generateReport();
          CoolAlert.show(
              context: context,
              type: CoolAlertType.success,
              title: 'Venta creada',
              text: "${responseSellText}\n${Folio}",
              confirmBtnColor: const Color(0xff278ea5));
        } else {
          try {
            await getSell(totalSell!, Folio.toString(), tip)
                .then((responseSell) async {
              //log(.toString());
              responseSellText = responseSell['message'];
              remissionEntity.tip = responseSell['tip'];
              remissionEntity.campoAdicional1 = responseSell['orderId'];
              remissionEntity.campoAdicional2 = responseSell['spanRoute'];
              remissionEntity.campoAdicional3 = responseSell['cardTypeName'];
              remissionEntity.campoAdicional4 = responseSell['authCode'];
              print("INICIA IMPRESION DE JSON DE VENTA");
              print(responseSell);
              print(responseSellText);
              print("FIN IMPRESION DE JSON DE VENTA");
              if (responseSellText == "Transacción exitosa") {
                await repository
                    .getCreateRemission(remissionEntity)
                    .then((response) => {responseText = response});
                print("INICIA IMPRESION DE INSERCION DE VENTA EN SQL SERVER");
                print(responseText);
                print("FIN IMPRESION DE INSERCION DE VENTA EN SQL SERVER");
                RemisionID =
                    responseText.replaceAll("Insertado correctamente ID:", "");
                CoolAlert.show(
                  context: context,
                  type: CoolAlertType.success,
                  title: 'Venta creada',
                  text: "${responseSellText}\n${Folio}",
                  confirmBtnColor: const Color(0xff278ea5),
                );
              } else {
                CoolAlert.show(
                    context: context,
                    type: CoolAlertType.error,
                    title: 'Venta NO creada',
                    text: "${responseSellText}",
                    confirmBtnColor: const Color(0xff273e));
              }
            });
          } catch (err) {
            print('Error:$err');
          }
        }
      }
    } else {
      print("BUTTON IS NOT ACTIVE...");
      return null;
    }
    tipAnotherPercentage.text = "0";
    tipAnotherAmount.text = "0";
    RatingBar(context);
  }

  Future<dynamic> generateReport() async {
    String _statusSell;
    try {
      final bool result =
          await platformRep.invokeMethod('generateReportVentaEfectivo', {
        'folioID': Folio,
        'totalSells': quantity,
        'dateReportSell': DateFormat("yyyy-MM-dd").format(selectedDate),
        'totalAllSells': totalSell,
        'paymentMethods': dropdownMethodPaymentValue,
        'articlePrice': unitPrice
      });
    } on PlatformException catch (e) {
      _statusSell = "Failed to get battery level: '${e.message}'.";
    }

    //statusSell = _statusSell;

    update(['textService']);

    return '';
  }

  RatingBar(BuildContext context) {
    CoolAlert.show(
        context: context,
        type: CoolAlertType.custom,
        title: 'Calidad del servicio',
        text: "Califica nuestro servicio",
        confirmBtnColor: const Color(0xff278ea5),
        widget: ratingBar());
  }

  void startTimer() {
    print("START:$_start");
    CountdownTimer countDownTimer = new CountdownTimer(
      new Duration(seconds: _start),
      new Duration(seconds: 1),
    );

    var sub = countDownTimer.listen(null);
    sub.onData((duration) {
      current = _start - duration.elapsed.inSeconds;
      print("CURRENT:$current");
    });

    sub.onDone(() {
      print("Done");
      isButtonActive = true;
      print("isButtonActive = true");
      print("BUTTON IS SET TO ACTIVE AGAIN...");
      sub.cancel();
    });
  }

  getTip(int percentage) {
    double tempTip = double.parse(totalRemissionTotalRemissionCtrl.text) *
        (percentage / 100);
    return "\$" + tempTip.toStringAsFixed(2) + " MXN";
  }

  tipValue(TipAmounts percentage) {
    switch (percentage) {
      case TipAmounts.ten:
        tip = double.parse(totalRemissionTotalRemissionCtrl.text) * .1;
        break;
      case TipAmounts.fifteen:
        tip = double.parse(totalRemissionTotalRemissionCtrl.text) * .15;
        break;
      case TipAmounts.twenty:
        tip = double.parse(totalRemissionTotalRemissionCtrl.text) * .2;
        break;
      case TipAmounts.otherAmount:
        tip = double.parse(tipAnotherAmount.text);
        break;
      case TipAmounts.otherPercentage:
        tip = double.parse(totalRemissionTotalRemissionCtrl.text) *
            (double.parse(tipAnotherPercentage.text) / 100);
        break;
      default:
        tip = 0;
        break;
    }
  }

  verifyTotal() {
    double tempTotal = totalRemissionTotalRemissionCtrl.text.isEmpty
        ? 0
        : double.parse(totalRemissionTotalRemissionCtrl.text);
    if (!tempTotal.isNaN && tempTotal > 0) {
      return false;
    } else {
      return true;
    }
  }

  bool verifyAmount() {
    double tempQuantity = quantityRemissionTextCtrl.text.isEmpty
        ? 0
        : double.parse(quantityRemissionTextCtrl.text);
    return (tempQuantity.toInt() == tempQuantity.roundToDouble()) &&
        tempQuantity > 0;
  }

  verifyTip(TipAmounts tipAmounts) {
    if ((tipAmounts == TipAmounts.otherPercentage ||
            tipAmounts == TipAmounts.otherAmount) &&
        tip > (double.parse(totalRemissionTotalRemissionCtrl.text) * .25) &&
        tip != 0) {
      return true;
    } else {
      return false;
    }
  }
}

class ratingBar extends StatelessWidget {
  const ratingBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 2.5,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
