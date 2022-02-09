import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:meta/meta.dart';
import 'package:pos_hotel/entities/devices.dart';
import 'package:pos_hotel/entities/remission_by_date.dart';
import 'package:pos_hotel/entities/remission_entity.dart';
import 'package:pos_hotel/entities/user_entity.dart';
import 'package:pos_hotel/utils/data_information.dart';
import 'package:pos_hotel/utils/get_helper_dio.dart';

const baseUrl = 'http://1527-24186.el-alt.com/servicesfe/api/';

class Api {
  // final Dio httpClient = Dio();
  // final box = GetStorage();

  Future<String> fetchAuth(UserEntity userEntity) async {
    try {
      var response = await Dio().post(
          "http://1527-24186.el-alt.com/servicesfe/api/login/authenticate",
          data: userEntity.toJson());
      // var response = await httpClient.post("${baseUrl}login/authenticate",
      //     data: userEntitie.toJson());
      print('statuscode: ${response.statusCode}');
      if (response.statusCode == 200) {
        DataInformation().writeToken(response.data.toString());
        DataInformation().writeTokenDeserialization(response.data.toString());
        return response.data.toString();
        // box.write('token', response.data.toString());
        // return response.data.toString();
      } else {
        return '';
      }
    } catch (_) {
      print('Error...');
      return '';
    }
  }

  Future<String> fetchCreateRemission(RemissionEntity remissionEntity) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response = await httpClient.post("${baseUrl}Remision/",
      //     data: remissionEntity.toJson());

      var response = await getHelperDio()
          .post("Remision/", data: remissionEntity.toJson());

      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        return '';
      }
    } catch (_) {
      return '';
    }
  }

  Future<String> fetchRemisionLastFolio(int? EmpresaID) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response = await httpClient.post("${baseUrl}Remision/",
      //     data: remissionEntity.toJson());

      print("INICIA METODO FETCH LAST FOLIO...");

      var response =
          await getHelperDio().get("GetRemisionLastFolio/$EmpresaID");

      print(response);
      print("TERMINA METODO FETCH LAST FOLIO...");
      if (response.statusCode == 200) {
        return response.data.toString();
      } else {
        return '';
      }
    } catch (_) {
      return '';
    }
  }

  Future<List<RemissionByDate?>?> fetchListRemissions(
      String startDate, int pEmpresaID) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response = await httpClient.get(
      //   "${baseUrl}Remision/?pDateString=$startDate&pEmpresaID=1001",
      // );

      var response = await getHelperDio().get(
        "Remision/?pDateString=$startDate&pEmpresaID=$pEmpresaID",
      );

      if (response.statusCode == 200) {
        return (response.data as List)
            .map((x) => RemissionByDate.fromJson(x))
            .toList();
      } else {
        throw response.statusCode.toString();
      }
    } catch (_) {
      print(_);
    }
  }

  /*getAll() async {
    try {
      var response = await httpClient.get(baseUrl);
      if(response.statusCode == 200){
        Iterable jsonResponse = json.decode(response.body);
        List<MyModel> listMyModel = jsonResponse.map((model) => MyModel.fromJson(model)).toList();
        return listMyModel;
      }else print ('erro');
    } catch(_){ }
  }

  getId(id) async {
    try {
      var response = await httpClient.get('baseUrlid');
      if(response.statusCode == 200){
        //Map<String, dynamic> jsonResponse = json.decode(response.body);
      }else print ('erro -get');
    } catch(_){ }
  }*/

  Future<List<Devices?>?> fetchListDevices(
      String empresaID, String deviceID) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response = await httpClient.get(
      //   "${baseUrl}DeviceConfig/",
      // );

      var response = await getHelperDio().get(
        "DeviceConfigList?pDeviceID=$deviceID&pEmpresaID=$empresaID",
      );

      if (response.statusCode == 200) {
        return (response.data as List).map((x) => Devices.fromJson(x)).toList();
      } else {
        throw response.statusCode.toString();
      }
    } catch (_) {
      print(_);
    }
  }

  Future<Devices?> fetchDeviceID(String deviceID, String empresaID) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response = await httpClient.get(
      //   "${baseUrl}DeviceConfig?pDeviceID=$deviceID&pEmpresaID=$empresaID",
      // );

      var response = await getHelperDio().get(
        "DeviceConfig?pDeviceID=$deviceID&pEmpresaID=$empresaID",
      );

      if (response.statusCode == 200) {
        return Devices.fromJson(response.data);
      } else {
        throw response.statusCode.toString();
      }
    } catch (_) {
      print(_);
    }
  }

  Future<String?> fetchUpdateDeviceID(Devices device) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response =
      //     await httpClient.put("${baseUrl}DeviceConfig", data: device.toJson());

      var response =
          await getHelperDio().put("DeviceConfig", data: device.toJson());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response.statusCode.toString();
      }
    } catch (_) {
      print(_);
    }
  }

  Future<String?> fetchCreateDevice(Devices device) async {
    try {
      // httpClient.options.headers = {
      //   'Authorization': 'Bearer ${box.read('token')}'
      // };
      //
      // var response = await httpClient.post("${baseUrl}DeviceConfig/",
      //     data: device.toJson());

      var response =
          await getHelperDio().post("DeviceConfig/", data: device.toJson());

      if (response.statusCode == 200) {
        return response.data;
      } else {
        throw response.statusCode.toString();
      }
    } catch (_) {
      print(_);
    }
  }
}
