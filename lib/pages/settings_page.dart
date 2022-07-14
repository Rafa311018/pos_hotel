import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/controllers/settings_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key, this.deviceID = '', this.empresaID = ''})
      : super(key: key);

  final String deviceID;
  final String empresaID;

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  Widget build(BuildContext context) {
    final settingsController =
        Get.lazyPut(() => SettingsController(), fenix: true);

    return GetBuilder<SettingsController>(builder: (_) {
      _.deviceIDArg = widget.deviceID;
      _.empresaIDArg = widget.empresaID;
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xffc2185b),
          elevation: 0.0,
          title: Stack(
            alignment: Alignment.center,
            children: [
              Align(
                child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back_ios_rounded)),
                alignment: Alignment.centerLeft,
              ),
              const Text(
                "Regresar",
                style: TextStyle(fontSize: 17.0),
              )
            ],
          ),
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                child: Text(
                  "Pantalla de configuración",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _.enterPriseIDCtrl,
                  decoration: const InputDecoration(
                      labelText: "EmpresaID",
                      contentPadding: EdgeInsets.all(25.0)),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _.deviceIDCtrl,
                  decoration: const InputDecoration(
                      labelText: "DeviceID",
                      contentPadding: EdgeInsets.all(25.0)),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _.clientIDCtrl,
                  decoration: const InputDecoration(
                      labelText: "ClienteID",
                      contentPadding: EdgeInsets.all(25.0)),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _.storeIDCtrl,
                  decoration: const InputDecoration(
                      labelText: "StoreID",
                      contentPadding: EdgeInsets.all(25.0)),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _.permissionsCtrl,
                  decoration: const InputDecoration(
                      labelText: "Permiso",
                      contentPadding: EdgeInsets.all(25.0)),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: TextFormField(
                  controller: _.accessPaymentCtrl,
                  decoration: const InputDecoration(
                      labelText: "Acceso Cobro",
                      contentPadding: EdgeInsets.all(25.0)),
                  keyboardType: TextInputType.number,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: 70.0,
                  child: TextButton(
                    onPressed:
                        _.deviceIDArg!.isNotEmpty && _.empresaIDArg!.isNotEmpty
                            ? () {
                                _.updateDevice(context);
                              }
                            : () {
                                _.createDevice(context);
                              },
                    style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffc2185b),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.0))),
                    child: Text(
                      _.deviceIDArg!.isNotEmpty && _.empresaIDArg!.isNotEmpty
                          ? "Actualizar"
                          : "Guardar",
                      style: const TextStyle(fontSize: 17.0),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}
