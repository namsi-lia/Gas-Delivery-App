import 'package:flutter/material.dart';
import 'package:gas_delivery_app/constants.dart';
import 'package:gas_delivery_app/screens/auth/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gas_delivery_app/firebase_options.dart';
import 'package:gas_delivery_app/constants.dart';
import 'package:gas_delivery_app/widgets/splash_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Okoa Gas App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            // This is the theme of your application.
            primarySwatch: MaterialColor(0x1e346C, <int, Color>{
              50: kIconColor.withOpacity(0.1),
              100: kIconColor.withOpacity(0.2),
              200: kIconColor.withOpacity(0.3),
              300: kIconColor.withOpacity(0.4),
              400: kIconColor.withOpacity(0.5),
              500: kIconColor.withOpacity(0.6),
              600: kIconColor.withOpacity(0.7),
              700: kIconColor.withOpacity(0.8),
              800: kIconColor.withOpacity(0.9),
              900: kIconColor,
            }),
            appBarTheme: AppBarTheme(
                iconTheme: const IconThemeData(
                  color: Colors.black,
                ),
                backgroundColor: Colors.transparent,
                toolbarTextStyle: TextTheme(
                  headline6:
                      GoogleFonts.basic(fontSize: 15, color: Colors.white),
                ).bodyText2,
                titleTextStyle: TextTheme(
                  headline6:
                      GoogleFonts.basic(fontSize: 15, color: Colors.white),
                ).headline6),
            textTheme: GoogleFonts.ibmPlexSansTextTheme()),
        home: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              return snapshot.hasData
                  ? const SplashScreen()
                  : const LoginPage();
            })

        // ignore: dead_code
        );
  }
}
