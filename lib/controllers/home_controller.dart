import 'dart:ui';

import 'package:get/get.dart';
import 'package:pos_hotel/entities/menu_entity.dart';

class HomeController extends GetxController {
  List<MenuEntity> listMenu = [
    const MenuEntity(
        name: 'Pago de servicio',
        assetIcon: 'assets/icons/icon_metodo_pago.png',
        routePage: '/paymentServicePage',
        backgroundColor: Color(0x0ffd5dff)),
    const MenuEntity(
        name: 'Reporte diario',
        assetIcon: 'assets/icons/icon_report.png',
        routePage: '/reportByDatePage',
        backgroundColor: Color(0xfffffCD5)),
    const MenuEntity(
        name: 'Configuración',
        assetIcon: 'assets/icons/icon_settings.png',
        routePage: '/settingsListDevicesPage',
        backgroundColor: Color(0xffd5f3ff))
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
