import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/controllers/settings_list_devices_controller.dart';
import 'package:pos_hotel/pages/settings_page.dart';

class SettingsListDevicesPage extends StatelessWidget {
  const SettingsListDevicesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final settingsListDevicesController = Get.lazyPut(() => SettingsListDevicesController(), fenix: true);

    return Scaffold(
      backgroundColor: const Color(0xffc2185b),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SettingsPage(deviceID: '', empresaID: ''),
            ),
          );

        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.indigoAccent,
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xffc2185b),
        elevation: 0.0,
        title: Stack(
          alignment: Alignment.center,
          children: [
            Align(child: IconButton(onPressed: (){
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios_rounded)), alignment: Alignment.centerLeft,),
            const Text("Regresar", style: TextStyle(
                fontSize: 17.0
            ),)
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  left: 15.0, right: 15.0, bottom: 30.0, top: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle),
                    padding: const EdgeInsets.all(15.0),
                    child: Image.asset(
                      'assets/icons/icon_settings.png',
                      width: 50.0,
                    ),
                  ),
                  const SizedBox(
                    width: 15.0,
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                       Text(
                        "Lista de\ndispositivos",
                        style: TextStyle(
                            fontSize: 28.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'Nunito'),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Container(
              decoration: const BoxDecoration(
                  color: Color(0xffFAFAFA),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0))),
              width: Get.width,
              padding: const EdgeInsets.only(top: 20.0, bottom: 30.0),
              child: Column(
                children: [

                  GetBuilder<SettingsListDevicesController>(
                    id: 'listDevices',
                    builder: (_) {
                      return _.listDevices != null ? ListView.builder(
                        shrinkWrap: true,
                        itemCount: _.listDevices!.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (ctx, index){
                          return Card(
                          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 15),
                          elevation: 7.0,
                          shadowColor: Colors.grey.withOpacity(0.1),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: InkWell(
                            onTap: (){
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => SettingsPage(deviceID: '${_.listDevices![index]!.deviceId}', empresaID: '${_.listDevices![index]!.empresaId}'),
                                ),
                              );
                            },
                            borderRadius: BorderRadius.circular(15.0),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0, bottom: 20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Empresa ID ${_.listDevices![index]!.empresaId}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("Device ID ${_.listDevices![index]!.deviceId}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),

                                  const SizedBox(
                                    height: 10.0,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Cliente ID ${_.listDevices![index]!.clienteId}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                      Text("Store ID ${_.listDevices![index]!.storeId}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  ),


                                  const SizedBox(
                                    height: 10.0,
                                  ),

                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text("Permiso ${_.listDevices![index]!.permiso}", style: const TextStyle(fontWeight: FontWeight.bold)),
                                      const SizedBox()
                                    ],
                                  )

                                ],
                              ),
                            ),
                          ),
                        );
                        },
                      ) : const Center(child: CircularProgressIndicator());
                    }
                  )

                ],
              ),
            )


          ],
        ),
      ),
    );
  }
}
