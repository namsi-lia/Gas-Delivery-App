import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Image.asset(
              'assets/images/okoa-gas-logo.png',
              fit: BoxFit.contain,
            ),
          ),
          Container(
            height: size.height,
            width: size.width,
            color: Colors.white.withOpacity(0.9),
            child: Center(
                child: SizedBox(
              height: 200,
              width: 200,
              child: Lottie.asset('assets/loading.json'),
            )),
          )
        ],
      ),
    );
  }
}
