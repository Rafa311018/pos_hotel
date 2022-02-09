import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/data/repository/settings_repository.dart';
import 'package:pos_hotel/entities/devices.dart';

class SettingsController extends GetxController{


  final TextEditingController enterPriseIDCtrl = TextEditingController();
  final TextEditingController deviceIDCtrl = TextEditingController();
  final TextEditingController clientIDCtrl = TextEditingController();
  final TextEditingController storeIDCtrl = TextEditingController();
  final TextEditingController permissionsCtrl = TextEditingController();
  final TextEditingController accessPaymentCtrl = TextEditingController();

  final SettingsRepository repository = SettingsRepository(apiClient: Api());

  String? deviceIDArg;
  String? empresaIDArg;

  Devices? modelDeviceID;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {

    if (deviceIDArg!.isNotEmpty && empresaIDArg!.isNotEmpty){

      repository.getDevicesID(deviceIDArg!, empresaIDArg!).then((response) {
        modelDeviceID = response;
        enterPriseIDCtrl.text = response!.empresaId.toString();
        deviceIDCtrl.text = response.deviceId.toString();
        clientIDCtrl.text = response.clienteId.toString();
        storeIDCtrl.text = response.storeId.toString();
        permissionsCtrl.text = response.permiso.toString();
        accessPaymentCtrl.text = response.accesoCobro.toString();
      });

    }

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }


  updateDevice(BuildContext context){

    Devices deviceUpdate = Devices(
      seqId: modelDeviceID!.seqId,
      empresaId: int.parse(enterPriseIDCtrl.text),
      deviceId: deviceIDCtrl.text,
      clienteId: int.parse(clientIDCtrl.text),
      storeId: int.parse(storeIDCtrl.text),
      permiso: permissionsCtrl.text,
      accesoCobro: int.parse(accessPaymentCtrl.text)
    );

    repository.updateDeviceID(deviceUpdate).then((value) {

      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Actualización',
          text: "$value",
          confirmBtnColor: const Color(0xff278ea5));

    });

  }

  createDevice(BuildContext context){

    Devices deviceUpdate = Devices(
        seqId: 0,
        empresaId: int.parse(enterPriseIDCtrl.text),
        deviceId: deviceIDCtrl.text,
        clienteId: int.parse(clientIDCtrl.text),
        storeId: int.parse(storeIDCtrl.text),
        permiso: permissionsCtrl.text,
        accesoCobro: int.parse(accessPaymentCtrl.text)
    );

    repository.createDevice(deviceUpdate).then((value) {

      CoolAlert.show(
          context: context,
          type: CoolAlertType.success,
          title: 'Actualización',
          text: "$value",
          confirmBtnColor: const Color(0xff278ea5));

    });

  }


}