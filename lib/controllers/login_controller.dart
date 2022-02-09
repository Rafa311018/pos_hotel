import 'dart:convert';

import 'package:device_info/device_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/data/repository/auth_repository.dart';
import 'package:pos_hotel/entities/user_data.dart';
import 'package:pos_hotel/entities/user_entity.dart';
import 'package:pos_hotel/utils/data_information.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';
import 'package:pos_hotel/utils/utilitysp.dart';

class LoginController extends GetxController {
  bool isvisiblePassWord = true;

  final AuthRepository repository = AuthRepository(apiClient: Api());

  final TextEditingController userNameCtrl = TextEditingController();
  final TextEditingController passwordCtrl = TextEditingController();

  final RoundedLoadingButtonController btnLoginCtrl =
      RoundedLoadingButtonController();

  DataInformation dataInformation = DataInformation();

  late AndroidDeviceInfo deviceInfo;

  String deviceID = "";

  final UtilitySP utility = UtilitySP();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() async {
    super.onReady();
    userNameCtrl.text = await utility.getUsernameFromSharePref();
    deviceInfo = await utility.deviceDetails();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void onAuthenticate(BuildContext context) async {
    btnLoginCtrl.start();
    //deviceID = dataInformation.readDeviceID().toString();
    deviceID = deviceInfo.androidId;
    print('deviceID: $deviceID');
    UserEntity userEntitie = UserEntity(
        userName: userNameCtrl.text,
        password: passwordCtrl.text,
        deviceID: deviceID);
    await repository.getAuth(userEntitie).then((response) async {
      if (response.isNotEmpty) {
        Navigator.pushNamed(context, '/homePage');
      } else {
        //Usuario y/o contraseña erroneas
      }
    });
    btnLoginCtrl.reset();
  }
}
