class RemissionByDate {
  RemissionByDate({
    this.remisionId,
    this.folio,
    this.clienteId,
    this.empresaId,
    this.atencionCliente,
    this.lugarEntrega,
    this.fechaEntrega,
    this.fechaRemision,
    this.statusId,
    this.descuento,
    this.motivoDescuento,
    this.monedaId,
    this.tipoCambio,
    this.cargoRetrasoId,
    this.condicionesDePagoId,
    this.metodoDePagoId,
    this.impuestoId,
    this.tasa,
    this.costoEnvio,
    this.total,
    this.cantidadTotal,
    this.noOrdenCliente,
    this.observaciones,
    this.campoAdicional1,
    this.campoAdicional2,
    this.campoAdicional3,
    this.campoAdicional4,
    required this.createdDate,
    this.createdBy,
    this.updatedDate,
    this.updatedBy,
    this.deletedDate,
    this.deletedBy,
    this.deleted,
  });

  int? remisionId;
  String? folio;
  int? clienteId;
  int? empresaId;
  String? atencionCliente;
  String? lugarEntrega;
  DateTime? fechaEntrega;
  DateTime? fechaRemision;
  int? statusId;
  double? descuento;
  String? motivoDescuento;
  int? monedaId;
  double? tipoCambio;
  int? cargoRetrasoId;
  int? condicionesDePagoId;
  int? metodoDePagoId;
  int? impuestoId;
  double? tasa;
  double? costoEnvio;
  double? total;
  double? cantidadTotal;
  String? noOrdenCliente;
  String? observaciones;
  String? campoAdicional1;
  String? campoAdicional2;
  String? campoAdicional3;
  String? campoAdicional4;
  DateTime createdDate;
  int? createdBy;
  DateTime? updatedDate;
  int? updatedBy;
  DateTime? deletedDate;
  int? deletedBy;
  int? deleted;

  factory RemissionByDate.fromJson(Map<String, dynamic> json) =>
      RemissionByDate(
        remisionId: json["remisionID"],
        folio: json["folio"],
        clienteId: json["clienteID"],
        empresaId: json["empresaID"],
        atencionCliente: json["atencionCliente"],
        lugarEntrega: json["lugarEntrega"],
        fechaEntrega: DateTime.parse(json["fechaEntrega"]),
        fechaRemision: DateTime.parse(json["fechaRemision"]),
        statusId: json["statusID"],
        descuento: json["descuento"],
        motivoDescuento: json["motivoDescuento"],
        monedaId: json["monedaID"],
        tipoCambio: json["tipoCambio"],
        cargoRetrasoId: json["cargoRetrasoID"],
        condicionesDePagoId: json["condicionesDePagoID"],
        metodoDePagoId: json["metodoDePagoID"],
        impuestoId: json["impuestoID"],
        tasa: json["tasa"],
        costoEnvio: json["costoEnvio"],
        total: json["total"],
        cantidadTotal: json["cantidadTotal"],
        noOrdenCliente: json["noOrdenCliente"],
        observaciones: json["observaciones"],
        campoAdicional1: json["campoAdicional1"],
        campoAdicional2: json["campoAdicional2"],
        campoAdicional3: json["campoAdicional3"],
        campoAdicional4: json["campoAdicional4"],
        createdDate: DateTime.parse(json["createdDate"]),
        createdBy: json["createdBy"],
        updatedDate: DateTime.parse(json["updatedDate"]),
        updatedBy: json["updatedBy"],
        deletedDate: DateTime.parse(json["deletedDate"]),
        deletedBy: json["deletedBy"],
        deleted: json["deleted"],
      );

  Map<String, dynamic> toJson() => {
        "remisionID": remisionId,
        "folio": folio,
        "clienteID": clienteId,
        "empresaID": empresaId,
        "atencionCliente": atencionCliente,
        "lugarEntrega": lugarEntrega,
        "fechaEntrega": fechaEntrega?.toIso8601String(),
        "fechaRemision": fechaRemision?.toIso8601String(),
        "statusID": statusId,
        "descuento": descuento,
        "motivoDescuento": motivoDescuento,
        "monedaID": monedaId,
        "tipoCambio": tipoCambio,
        "cargoRetrasoID": cargoRetrasoId,
        "condicionesDePagoID": condicionesDePagoId,
        "metodoDePagoID": metodoDePagoId,
        "impuestoID": impuestoId,
        "tasa": tasa,
        "costoEnvio": costoEnvio,
        "total": total,
        "cantidadTotal": cantidadTotal,
        "noOrdenCliente": noOrdenCliente,
        "observaciones": observaciones,
        "campoAdicional1": campoAdicional1,
        "campoAdicional2": campoAdicional2,
        "campoAdicional3": campoAdicional3,
        "campoAdicional4": campoAdicional4,
        "createdDate": createdDate.toIso8601String(),
        "createdBy": createdBy,
        "updatedDate": updatedDate?.toIso8601String(),
        "updatedBy": updatedBy,
        "deletedDate": deletedDate?.toIso8601String(),
        "deletedBy": deletedBy,
        "deleted": deleted,
      };
}
