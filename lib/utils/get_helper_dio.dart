import 'package:dio/dio.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

import 'data_information.dart';

const urlBaseName ='http://1527-24186.el-alt.com/servicesfe/api/';

Dio getHelperDio(){

  var options = BaseOptions(
    baseUrl: urlBaseName,
    contentType: 'application/json; charset=UTF-8',
    headers: {
      'Authorization':'Bearer ${DataInformation().readToken()}',
    },
  );

  Dio dio = Dio(options);

  return dio;
}