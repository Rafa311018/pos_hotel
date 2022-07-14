import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pos_hotel/controllers/payment_service_controller.dart';

enum TipAmounts { noTip, ten, fifteen, twenty, otherAmount, otherPercentage }

class TipScreen extends StatefulWidget {
  const TipScreen({Key? key}) : super(key: key);

  @override
  _TipScreen createState() => _TipScreen();
}

class _TipScreen extends State<TipScreen> {
  TipAmounts? _tip = TipAmounts.noTip;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<PaymentServiceController>(builder: (_) {
        return Scaffold(
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
                        _tip = TipAmounts.noTip;
                        _.tipAnotherAmount.text = "0";
                        _.tipAnotherPercentage.text = "0";
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
          body: Column(
            children: <Widget>[
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                "¿Desea agregar propina?",
                style: TextStyle(
                  fontSize: 30.0,
                  color: Colors.white,
                ),
              ),
              const SizedBox(
                height: 30.0,
              ),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20.0,
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "sin propina",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.noTip
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                                Text(
                                  "\$0.00 MXN",
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.noTip
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          leading: Radio<TipAmounts>(
                              value: TipAmounts.noTip,
                              groupValue: _tip,
                              onChanged: (value) {
                                setState(() {
                                  _tip = value;
                                  _.tipValue(value!);
                                });
                              }),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "10%",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.ten
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                                Text(
                                  _.getTip(10),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.ten
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          leading: Radio<TipAmounts>(
                              value: TipAmounts.ten,
                              groupValue: _tip,
                              onChanged: (value) {
                                setState(() {
                                  _tip = value;
                                  _.tipValue(value!);
                                });
                              }),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "15%",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.fifteen
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                                Text(
                                  _.getTip(15),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.fifteen
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          leading: Radio<TipAmounts>(
                              value: TipAmounts.fifteen,
                              groupValue: _tip,
                              onChanged: (value) {
                                setState(() {
                                  _tip = value;
                                  _.tipValue(value!);
                                });
                              }),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "20%",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.twenty
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                                Text(
                                  _.getTip(20),
                                  textAlign: TextAlign.end,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.twenty
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                              ],
                            ),
                          ),
                          leading: Radio<TipAmounts>(
                              value: TipAmounts.twenty,
                              groupValue: _tip,
                              onChanged: (value) {
                                setState(() {
                                  _tip = value;
                                  _.tipValue(value!);
                                });
                              }),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Otro (\$) :",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.otherAmount
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                                const SizedBox(
                                  width: 80.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      _.tipValue(TipAmounts.otherAmount);
                                    },
                                    readOnly: _tip == TipAmounts.otherAmount
                                        ? false
                                        : true,
                                    style: TextStyle(
                                        color: _tip == TipAmounts.otherAmount
                                            ? const Color(0xffe41749)
                                            : Colors.grey),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color:
                                                _tip == TipAmounts.otherAmount
                                                    ? const Color(0xffe41749)
                                                    : Colors.grey,
                                          ),
                                        ),
                                        fillColor: Colors.white),
                                    keyboardType: TextInputType.number,
                                    controller: _.tipAnotherAmount,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          leading: Radio<TipAmounts>(
                              value: TipAmounts.otherAmount,
                              groupValue: _tip,
                              onChanged: (value) {
                                setState(() {
                                  _tip = value;
                                });
                              }),
                        ),
                        ListTile(
                          title: Padding(
                            padding: const EdgeInsets.only(right: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Text(
                                  "Otro (%) :",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      color: _tip == TipAmounts.otherPercentage
                                          ? const Color(0xffe41749)
                                          : Colors.grey),
                                ),
                                const SizedBox(
                                  width: 80.0,
                                ),
                                Expanded(
                                  child: TextFormField(
                                    onChanged: (value) {
                                      _.tipValue(TipAmounts.otherPercentage);
                                    },
                                    readOnly: _tip == TipAmounts.otherPercentage
                                        ? false
                                        : true,
                                    style: TextStyle(
                                        color:
                                            _tip == TipAmounts.otherPercentage
                                                ? const Color(0xffe41749)
                                                : Colors.grey),
                                    textAlign: TextAlign.center,
                                    decoration: InputDecoration(
                                      enabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              _tip == TipAmounts.otherPercentage
                                                  ? const Color(0xffe41749)
                                                  : Colors.grey,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                    ),
                                    keyboardType: TextInputType.number,
                                    controller: _.tipAnotherPercentage,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          leading: Radio<TipAmounts>(
                              value: TipAmounts.otherPercentage,
                              groupValue: _tip,
                              onChanged: (value) {
                                setState(() {
                                  _tip = value;
                                  _.tipValue(value!);
                                });
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          bottomSheet: Row(
            children: <Widget>[
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    if (_.verifyTip(_tip!)) {
                      CoolAlert.show(
                        context: context,
                        type: CoolAlertType.error,
                        title: 'Error en propina',
                        text: "Introduzca una propina no mayor al 25%",
                        confirmBtnColor: const Color(0xff278ea5),
                      );
                    } else {
                      Navigator.pop(context);
                      _.createRemission(context);
                    }
                  },
                  child: const Text(
                    "Continuar",
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
                width: 10.0,
              ),
            ],
          ),
        );
      }),
    );
  }
}
