import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pos_hotel/controllers/home_controller.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final homeController = Get.lazyPut(() => HomeController(), fenix: true);

    return Scaffold(
        backgroundColor: Colors.grey[100],
        body: SafeArea(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            physics: const BouncingScrollPhysics(),
            padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 20.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Image.asset(
                "assets/illustrations/sistemaFELogo.png",
                height: 170.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              GetBuilder<HomeController>(builder: (_) {
                return GridView.builder(
                    shrinkWrap: true,
                    itemCount: _.listMenu.length,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio:
                            MediaQuery.of(context).size.height / 830,
                        crossAxisSpacing: 10.0,
                        mainAxisSpacing: 10.0),
                    itemBuilder: (ctx, index) {
                      return InkWell(
                        borderRadius: BorderRadius.circular(15.0),
                        onTap: () {
                          Navigator.pushNamed(
                              context, _.listMenu[index].routePage);
                        },
                        child: Ink(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.02),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Ink(
                                child: Image.asset(
                                    '${_.listMenu[index].assetIcon}'),
                                width: 100.0,
                                height: 100.0,
                                padding: const EdgeInsets.all(20.0),
                                decoration: BoxDecoration(
                                    color: _.listMenu[index].backgroundColor,
                                    borderRadius: BorderRadius.circular(15.0)),
                              ),
                              const SizedBox(
                                height: 30.0,
                              ),
                              Text(
                                '${_.listMenu[index].name}',
                                style: const TextStyle(
                                    fontFamily: 'Nunito',
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      );
                    });
              })
            ]),
          ),
        ));
  }
}
