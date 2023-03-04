import 'package:flutter/material.dart';
import 'package:pandec_flutter_bloc/app_router.dart';
import 'package:pandec_flutter_bloc/ui/splashScreen/splash_screen_view.dart';

void main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: SplashScreenView.TAG,
        theme: ThemeData(
          primarySwatch: Colors.red,
        )
    );
  }
}
