import 'dart:io';

import 'package:flutter/material.dart';
import 'src/app.dart';
import 'package:firebase_core/firebase_core.dart';

const appid = "e718dc1d125d4b59a3026ac5a600d65b";
const token = "006e718dc1d125d4b59a3026ac5a600d65bIABNx2T+6qzf3mKNpyQ36O+uprJB5Yf7ZjgtdTnler8kytzDPrsAAAAAEACcjToM52cZYQEAAQDnZxlh";

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();
  runApp(App());
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
