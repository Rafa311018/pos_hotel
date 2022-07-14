import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/controllers/payment_service_controller.dart';
import 'package:pos_hotel/pages/tip_screen.dart';

class PaymentServicePage extends StatelessWidget {
  const PaymentServicePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final paymentServicecontroller =
        Get.lazyPut(() => PaymentServiceController(), fenix: true);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: const Color(0xffc2185b),
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
      body: const Builder(),
    );
  }
}

class Builder extends StatefulWidget {
  const Builder({
    Key? key,
  }) : super(key: key);

  @override
  State<Builder> createState() => _BuilderState();
}

class _BuilderState extends State<Builder> {
  bool _validateQuantity = false;
  bool _validateTotal = false;

  late FocusNode focusTotal;
  late FocusNode focusQuantity;

  @override
  void initState() {
    super.initState();
    focusTotal = FocusNode();
    focusQuantity = FocusNode();
  }

  @override
  void dispose() {
    focusTotal.dispose();
    focusQuantity.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaymentServiceController>(builder: (_) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(
                left: 15.0, right: 15.0, bottom: 20.0, top: 10.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      shape: BoxShape.circle),
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset(
                    'assets/icons/icon_metodo_pago.png',
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
                      "Venta",
                      style: TextStyle(
                          fontSize: 28.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: 'Nunito'),
                    ),
                    Text(
                      "Información de la venta",
                      style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.white,
                          fontFamily: 'Nunito'),
                    )
                  ],
                )
              ],
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                width: Get.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20.0),
                        topRight: Radius.circular(20.0))),
                padding:
                    const EdgeInsets.only(left: 15.0, right: 15.0, top: 25.0),
                child: Column(
                  children: [
                    DropdownButtonFormField(
                      items: <String>['Hospedaje']
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _.dropdownServiceValue = value!;
                      },
                      hint: const Text('Servicio'),
                      value: _.dropdownServiceValue,
                      decoration: const InputDecoration(labelText: 'Servicio'),
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      focusNode: focusQuantity,
                      decoration: InputDecoration(
                          labelText: "Cantidad",
                          hintText: "0",
                          errorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffc2185b), width: 0.0),
                          ),
                          focusedErrorBorder: const OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color(0xffc2185b), width: 0.0),
                          ),
                          errorText: _validateQuantity
                              ? "La cantidad escrita no es valida"
                              : null,
                          contentPadding: const EdgeInsets.all(25.0)),
                      keyboardType: TextInputType.number,
                      onChanged: (quantity) {
                        setState(() {
                          if (quantity == "") {
                            _validateQuantity = true;
                          } else {
                            _validateQuantity = !_.verifyAmount();
                          }
                        });
                      },
                      controller: _.quantityRemissionTextCtrl,
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    TextFormField(
                      style: const TextStyle(
                        fontSize: 20
                      ),
                      focusNode: focusTotal,
                      decoration: InputDecoration(
                        labelText: "Total de ventas",
                        hintText: "0",
                        errorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffc2185b), width: 0.0),
                        ),
                        focusedErrorBorder: const OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Color(0xffc2185b), width: 0.0),
                        ),
                        errorText: _validateTotal
                            ? "El total escrito no es valido"
                            : null,
                        contentPadding: const EdgeInsets.all(25.0),
                      ),
                      keyboardType: TextInputType.number,
                      onChanged: (total) {
                        setState(() {
                          _validateTotal = _.verifyTotal();
                        });
                      },
                      controller: _.totalRemissionTotalRemissionCtrl,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    DropdownButtonFormField(
                      items: <String>[
                        '1-Efectivo',
                        '2-Credito',
                        '3-Debito',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      onChanged: (String? value) {
                        _.dropdownMethodPaymentValue = value!;

                        if (value == "1-Efectivo") {
                          _.dropdownMethodPaymentNumber = 1;
                        }

                        if (value == "2-Credito") {
                          _.dropdownMethodPaymentNumber = 2;
                        }

                        if (value == "3-Debito") {
                          _.dropdownMethodPaymentNumber = 3;
                        }
                      },
                      value: _.dropdownMethodPaymentValue,
                      decoration: const InputDecoration(
                          labelText: 'Selecciona un metodo de pago'),
                    ),
                    /*GetBuilder<PaymentServiceController>(
                          id: 'textService',
                          builder: (_) {
                            return Text(_.statusSell);
                          }
                        ),*/
                    const SizedBox(
                      height: 20.0,
                    ),
                    SizedBox(
                      width: Get.width,
                      height: 60.0,
                      child: TextButton(
                        onPressed: () {
                          if (_.isButtonActive) {
                            _validateTotal = _.verifyTotal();
                            _validateQuantity = !_.verifyAmount();
                            if (!_validateQuantity && !_validateTotal) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TipScreen(),
                                ),
                              );
                            } else {
                              if (_validateQuantity) {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: 'Campos faltantes',
                                  text: "Introduce una cantidad entera",
                                  confirmBtnColor: const Color(0xffe41749),
                                );
                                FocusScope.of(context)
                                    .requestFocus(focusQuantity);
                              } else {
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  title: 'Campos faltantes',
                                  text:
                                      "Introduce el total de ventas correctamente",
                                  confirmBtnColor: const Color(0xffe41749),
                                );
                                FocusScope.of(context).requestFocus(focusTotal);
                              }
                            }
                          } else {
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              title: 'Boton desactivado',
                              text:
                                  "Espera ${_.current} segundos",
                              confirmBtnColor: const Color(0xffe41749),
                            );
                          }
                        },
                        child: const Text(
                          "Generar venta",
                          style: TextStyle(fontSize: 17.0),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffe41749),
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 60.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      );
    });
  }
}
