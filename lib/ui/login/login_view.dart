import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  static const String TAG = "LoginView";

  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Builder(
      builder: (context) {
        return SingleChildScrollView(
          child: Column(
            children: [

            ],
          ),
        );
      }
    );
  }
}
