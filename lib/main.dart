import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pos_hotel/pages/home_page.dart';
import 'package:pos_hotel/pages/login_page.dart';
import 'package:pos_hotel/pages/payment_service_page.dart';
import 'package:pos_hotel/pages/report_by_date_page.dart';
import 'package:pos_hotel/pages/settings_list_devices_page.dart';
import 'package:pos_hotel/pages/settings_page.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BrilliantTech.com.mx',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.pink,
        inputDecorationTheme: const InputDecorationTheme(
          filled: true,
          fillColor: Color(0xfff8f8f8),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              borderSide: BorderSide.none),
        ),
      ),
      routes: {
        '/loginPage': (context) => const LoginPage(),
        '/homePage': (context) => const HomePage(),
        '/paymentServicePage': (context) => const PaymentServicePage(),
        '/reportByDatePage': (context) => const ReportByDatePage(),
        '/settingsPage': (context) => const SettingsPage(),
        '/settingsListDevicesPage': (context) => const SettingsListDevicesPage()
      },
      home: const LoginPage(),
    );
  }
}
