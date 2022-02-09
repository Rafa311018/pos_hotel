import 'package:meta/meta.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/entities/devices.dart';

class SettingsRepository {
  final Api apiClient;

  SettingsRepository({required this.apiClient}) : assert(apiClient != null);

  Future<List<Devices?>?> getListDevices(String empresaID, String deviceID) {
    return apiClient.fetchListDevices(empresaID, deviceID);
  }

  Future<Devices?> getDevicesID(String deviceID, String empresaID) {
    return apiClient.fetchDeviceID(deviceID, empresaID);
  }

  Future<String?> updateDeviceID(Devices device) {
    return apiClient.fetchUpdateDeviceID(device);
  }

  Future<String?> createDevice(Devices device) {
    return apiClient.fetchCreateDevice(device);
  }
}
