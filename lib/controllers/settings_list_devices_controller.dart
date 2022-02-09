import 'package:get/get.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/data/repository/settings_repository.dart';
import 'package:pos_hotel/entities/devices.dart';
import 'package:pos_hotel/entities/user_data.dart';
import 'package:pos_hotel/utils/data_information.dart';

class SettingsListDevicesController extends GetxController {
  final SettingsRepository repository = SettingsRepository(apiClient: Api());

  UserData userData = DataInformation().readUserInfo();

  List<Devices?>? listDevices = [];

  @override
  void onInit() {
    var EmpresaID = userData.empresaId;
    var DeviceID = userData.deviceID;
    repository.getListDevices(EmpresaID, DeviceID!).then((response) {
      listDevices = response;
    }).whenComplete(() => update(["listDevices"]));
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
