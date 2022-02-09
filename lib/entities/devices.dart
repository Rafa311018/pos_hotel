class Devices {
  Devices({
    this.seqId,
    this.empresaId,
    this.deviceId,
    this.clienteId,
    this.storeId,
    this.permiso,
    this.accesoCobro,
  });

  int? seqId;
  int? empresaId;
  String? deviceId;
  int? clienteId;
  int? storeId;
  String? permiso;
  int? accesoCobro;

  factory Devices.fromJson(Map<String, dynamic> json) => Devices(
    seqId: json["SeqID"],
    empresaId: json["EmpresaID"],
    deviceId: json["DeviceID"],
    clienteId: json["ClienteID"],
    storeId: json["StoreID"],
    permiso: json["Permiso"],
    accesoCobro: json["AccesoCobro"],
  );

  Map<String, dynamic> toJson() => {
    "SeqID": seqId,
    "EmpresaID": empresaId,
    "DeviceID": deviceId,
    "ClienteID": clienteId,
    "StoreID": storeId,
    "Permiso": permiso,
    "AccesoCobro": accesoCobro,
  };
}
