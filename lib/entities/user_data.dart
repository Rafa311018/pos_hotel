class UserData {
  UserData({
    this.uniqueName,
    this.id,
    this.role,
    required this.empresaId,
    this.userMail,
    this.userName,
    this.deviceID,
    this.clienteID,
    this.storeID,
    this.permiso,
    this.accesoCobro,
    this.iss,
    this.aud,
    this.exp,
    this.nbf,
  });

  String? uniqueName;
  String? id;
  String? role;
  String empresaId;
  String? userMail;
  String? userName;
  String? deviceID;
  String? clienteID;
  String? storeID;
  String? permiso;
  String? accesoCobro;

  String? iss;
  String? aud;
  int? exp;
  int? nbf;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uniqueName: json["unique_name"],
        id: json["id"],
        role: json["role"],
        empresaId: json["EmpresaId"],
        userMail: json["UserMail"],
        userName: json["UserName"],
        deviceID: json["DeviceID"],
        clienteID: json["ClienteID"],
        storeID: json["StoreID"],
        permiso: json["Permiso"],
        accesoCobro: json["AccesoCobro"],
        iss: json["iss"],
        aud: json["aud"],
        exp: json["exp"],
        nbf: json["nbf"],
      );

  Map<String, dynamic> toJson() => {
        "unique_name": uniqueName,
        "id": id,
        "role": role,
        "EmpresaId": empresaId,
        "UserMail": userMail,
        "UserName": userName,
        "DeviceID": deviceID,
        "ClienteID": clienteID,
        "StoreID": storeID,
        "Permiso": permiso,
        "AccesoCobro": accesoCobro,
        "iss": iss,
        "aud": aud,
        "exp": exp,
        "nbf": nbf,
      };
}
