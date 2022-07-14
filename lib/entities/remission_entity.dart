class RemissionEntity {
  RemissionEntity({
    this.empresaId,
    this.clienteId,
    this.cantidad,
    this.tip,
    this.folio,
    this.descripcion,
    this.precioUnitario,
    this.totalSell,
    this.formaDePago,
    this.campoAdicional1,
    this.campoAdicional2,
    this.campoAdicional3,
    this.campoAdicional4,
  });

  int? empresaId;
  int? clienteId;
  int? cantidad;
  double? tip;
  int? folio;
  String? descripcion;
  double? precioUnitario;
  double? totalSell;
  int? formaDePago;
  String? campoAdicional1;
  String? campoAdicional2;
  String? campoAdicional3;
  String? campoAdicional4;

  factory RemissionEntity.fromJson(Map<String, dynamic> json) =>
      RemissionEntity(
        empresaId: json["empresaID"],
        clienteId: json["clienteID"],
        cantidad: json["cantidad"],
        folio: json["folio"],
        descripcion: json["descripcion"],
        precioUnitario: json["precioUnitario"],
        //totalSell: json["totalSell"],
        formaDePago: json["formaDePago"],
        campoAdicional1: json["campoAdicional1"],
        campoAdicional2: json["campoAdicional2"],
        campoAdicional3: json["campoAdicional3"],
        campoAdicional4: json["campoAdicional4"],
      );

  Map<String, dynamic> toJson() => {
        "empresaID": empresaId,
        "clienteID": clienteId,
        "cantidad": cantidad,
        "folio": folio,
        "descripcion": descripcion,
        "precioUnitario": precioUnitario,
        //"totalSell": totalSell,
        "formaDePago": formaDePago,
        "campoAdicional1": campoAdicional1,
        "campoAdicional2": campoAdicional2,
        "campoAdicional3": campoAdicional3,
        "campoAdicional4": campoAdicional4,
      };
}
