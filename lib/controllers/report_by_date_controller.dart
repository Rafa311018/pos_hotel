import 'dart:convert';
import 'dart:developer';

import 'package:easy_debounce/easy_debounce.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/data/repository/auth_repository.dart';
import 'package:pos_hotel/entities/remission_by_date.dart';
import 'package:pos_hotel/entities/user_data.dart';
import 'package:pos_hotel/utils/data_information.dart';
import 'package:pos_hotel/entities/report.dart';
import 'package:pos_hotel/utils/debouncer.dart';

class ReportByDateController extends GetxController {
  final AuthRepository repository = AuthRepository(apiClient: Api());

  UserData userData = DataInformation().readUserInfo();

  DateTime selectedDate = DateTime.now();

  List<RemissionByDate?>? listRemissionByDate = [];

  String titleDate = '';

  int search = 0;

  static const platform = MethodChannel('com.netpay.nw/generateReport');

  //final Debouncer onSearchDebouncer = Debouncer(delay: const Duration(milliseconds: 500));

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();

    //2021-09-09

    handleDateListRemission(DateFormat("yyyy-MM-dd").format(selectedDate));
  }

  Future<dynamic> generateReport() async {
    String _statusSell;
    try {
      if (listRemissionByDate!.isNotEmpty) {
        double totalAllSells = 0.0;
        //List paymentMethods = [];
        List<Report> reports = [];

        /*for (int i = 0; i < listRemissionByDate!.length; i++) {
          totalAllSells += listRemissionByDate![i]!.total!;
          paymentMethods.add(listRemissionByDate![i]!.metodoDePagoId == 1
              ? '\nEFECTIVO'
              : listRemissionByDate![i]!.metodoDePagoId == 2
                  ? '\nCREDITO'
                  : listRemissionByDate![i]!.metodoDePagoId == 3
                      ? '\nDEBITO'
                      : '');
        }*/

        for (int i = 0; i < listRemissionByDate!.length; i++) {
          totalAllSells += listRemissionByDate![i]!.total!;
          reports.add(Report(
              quantity: "${listRemissionByDate![i]!.cantidadTotal}",
              concept: "Noche",
              paymentMethod: listRemissionByDate![i]!.metodoDePagoId == 1
                  ? 'EFECTIVO'
                  : listRemissionByDate![i]!.metodoDePagoId == 2
                      ? 'CREDITO'
                      : listRemissionByDate![i]!.metodoDePagoId == 3
                          ? 'DEBITO'
                          : '',
              price: "${listRemissionByDate![i]!.total}"));
        }

        var json = jsonEncode(reports.map((e) => e.toJson()).toList());

        final bool result = await platform.invokeMethod('generateReport', {
          "dateReportSell": titleDate,
          "dataReport": json,
          "totalReport": "$totalAllSells"
        });

        /*final bool result = await platform.invokeMethod('generateReport', {
          'totalSells': listRemissionByDate!.length,
          'dateReportSell': titleDate,
          'totalAllSells': totalAllSells,
          'paymentMethods': paymentMethods
              .toString()
              .replaceAll('[', ' ')
              .replaceAll(']', ' '),
          'articlePrice': 0.00
        });*/
      }
    } on PlatformException catch (e) {
      _statusSell = "Failed to print Report: '${e.message}'.";
    }

    //statusSell = _statusSell;

    update(['textService']);

    return '';
  }

  handleDateListRemission(String _date) {
    var empresaID = int.tryParse(userData.empresaId);
    titleDate = _date;
    search = 0;
    update(["list_remission", "title_date"]);
    EasyDebounce.debounce('search_list', const Duration(milliseconds: 500), () {
      repository.getListRemission(_date, empresaID!).then((response) {
        search = 0;
        update(["list_remission"]);
        listRemissionByDate = response;
      }).whenComplete(() => {
            search = 1,
            update(["list_remission"]),
            EasyDebounce.cancelAll()
          });
    });

    /*onSearchDebouncer.debounce(() {

    });*/
  }

  @override
  void onClose() {
    super.onClose();
  }
}
