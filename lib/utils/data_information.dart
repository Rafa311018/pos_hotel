

import 'package:get_storage/get_storage.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:pos_hotel/entities/user_data.dart';

class DataInformation {

  final box = GetStorage();

  writeToken(String _token){
    box.write('token', _token);
  }

  readToken(){
    return box.read('token');
  }

  writeTokenDeserialization(String _token){
    Map<String, dynamic> decodedToken = JwtDecoder.decode(_token);
    UserData userData = UserData.fromJson(decodedToken);
    box.write('token_deserialization', userData);
  }

  UserData readUserInfo(){
    return box.read('token_deserialization');
  }

  Future<String?> readDeviceID() async {
    return await PlatformDeviceId.getDeviceId;
  }

}