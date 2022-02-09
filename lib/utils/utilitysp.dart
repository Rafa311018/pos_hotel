import 'dart:io';
import 'package:flutter/services.dart';
import 'package:device_info/device_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UtilitySP {
  Future<String> getUsernameFromSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    final username = prefs.getString('username');
    if (username == null) {
      return '';
    } else {
      return username;
    }
  }

  Future<int> getEmpresaIDFromSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    final EmpresaId = prefs.getInt('EmpresaId');
    if (EmpresaId == null) {
      return 0;
    } else {
      return EmpresaId;
    }
  }

  Future<int> getRoleFromSharePref() async {
    final prefs = await SharedPreferences.getInstance();
    final role = prefs.getInt('Role');
    if (role == null) {
      return 0;
    } else {
      return role;
    }
  }

  Future<void> setEmpresaIDToSharePref(String pEmpresaID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('EmpresaId', int.parse(pEmpresaID));
  }

  Future<void> setRoleToSharePref(String pRole) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('Role', int.parse(pRole));
  }

  Future<void> setUsernameToSharePref(String pUsername) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', pUsername);
  }

  Future<AndroidDeviceInfo> deviceDetails() async {
    final DeviceInfoPlugin deviceInfoPlugin = new DeviceInfoPlugin();
    var build;
    try {
      if (Platform.isAndroid) {
        build = await deviceInfoPlugin.androidInfo;
        //UUID for Android
      }
      //else if (Platform.isIOS) {
      //  var data = await deviceInfoPlugin.iosInfo;
      //  return data;
      //}
    } on PlatformException {
      print('Failed to get platform version');
    }
    return build;
  }
}
