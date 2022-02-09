class Report {
  Report({
    this.quantity,
    this.concept,
    this.paymentMethod,
    this.price,
  });

  String? quantity;
  String? concept;
  String? paymentMethod;
  String? price;

  factory Report.fromJson(Map<String, dynamic> json) => Report(
    quantity: json["quantity"],
    concept: json["concept"],
    paymentMethod: json["payment_method"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "quantity": quantity,
    "concept": concept,
    "payment_method": paymentMethod,
    "price": price,
  };
}
