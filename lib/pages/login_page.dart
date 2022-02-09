import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/controllers/login_controller.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginController = Get.lazyPut(() => LoginController(), fenix: true);

    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 20.0),
            child: GetBuilder<LoginController>(builder: (_) {
              return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/illustrations/sistemaFELogo.png",
                      height: 170.0,
                    ),
                    const SizedBox(
                      height: 30.0,
                    ),
                    TextFormField(
                      controller: _.userNameCtrl,
                      decoration: const InputDecoration(
                          labelText: "Usuario",
                          contentPadding: EdgeInsets.all(25.0)),
                    ),
                    const SizedBox(
                      height: 25.0,
                    ),
                    TextFormField(
                      obscureText: _.isvisiblePassWord,
                      controller: _.passwordCtrl,
                      decoration: InputDecoration(
                          labelText: "Contraseña",
                          contentPadding: const EdgeInsets.all(25.0),
                          suffixIcon: IconButton(
                              onPressed: () {
                                _.isvisiblePassWord = !_.isvisiblePassWord;
                                _.update();
                              },
                              icon: _.isvisiblePassWord
                                  ? const Icon(Icons.visibility)
                                  : const Icon(Icons.visibility_off_rounded))),
                    ),
                    const SizedBox(
                      height: 40.0,
                    ),
                    SizedBox(
                      width: Get.width,
                      height: 60.0,
                      child: RoundedLoadingButton(
                        child: const Text('Iniciar sesión',
                            style: TextStyle(color: Colors.white)),
                        controller: _.btnLoginCtrl,
                        onPressed: () {
                          _.onAuthenticate(context);
                        },
                        elevation: 0.0,
                        color: const Color(0xffe41749),
                      ),
                    )

                    /*SizedBox(
                    width: Get.width,
                    height: 60.0,
                    child: TextButton(
                      onPressed: () {

                        //Navigator.pushNamed(context, '/homePage');

                        _.onAuthenticate();

                      },
                      child: const Text("Iniciar sesión", style: TextStyle(
                        fontSize: 17.0
                      ),),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xffe41749),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)
                        )
                      ),
                    ),
                  )*/
                  ]);
            }),
          ),
        ));
  }
}
