import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:splitshipv01/welcome%20page/welcome_page.dart';

import 'auth_screen/login_screen.dart';
import 'dashboard/dashboard_screen.dart';
import 'home_page/home_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Splitship App',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
        home:  WalletPage()
        // SplitShipPage()
      // home: LoginScreen(), // Start the app with WelcomePage
      // home: Scaffold( appBar: AppBar(title: Text("data"),),),
    );
  }
}

