import 'package:meta/meta.dart';
import 'package:pos_hotel/data/provider/api.dart';
import 'package:pos_hotel/entities/remission_by_date.dart';
import 'package:pos_hotel/entities/remission_entity.dart';
import 'package:pos_hotel/entities/user_entity.dart';

class AuthRepository {
  final Api apiClient;

  AuthRepository({required this.apiClient}) : assert(apiClient != null);

  Future<String> getAuth(UserEntity userEntitie) {
    return apiClient.fetchAuth(userEntitie);
  }

  Future<String> getCreateRemission(RemissionEntity remissionEntity) {
    return apiClient.fetchCreateRemission(remissionEntity);
  }

  Future<String> getRemisionLastFolio(int? EmpresaID) {
    return apiClient.fetchRemisionLastFolio(EmpresaID);
  }

  Future<List<RemissionByDate?>?> getListRemission(
      String startDate, int pEmpresaID) {
    return apiClient.fetchListRemissions(startDate, pEmpresaID);
  }

  /*getAll() {
    return apiClient.getAll();
  }

  getId(id) {
    return apiClient.getId(id);
  }*/

}
