import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pandec_flutter_bloc/ui/login/login_view.dart';

class SplashScreenView extends StatefulWidget {
  static const String TAG = "SplashScreenView";

  const SplashScreenView({Key? key}) : super(key: key);

  @override
  State<SplashScreenView> createState() => _SplashScreenViewState();
}

class _SplashScreenViewState extends State<SplashScreenView> {
  var version = "";

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Builder(
        builder: (context) {
          startSplashScreen(context);
          return Container(
            width: width,
            height: height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: const [
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 40,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  startSplashScreen(BuildContext context) async {
    var duration = const Duration(seconds: 5);
    return Timer(duration, () async {
      Navigator.pushReplacementNamed(context, LoginView.TAG);
    });
  }
}
