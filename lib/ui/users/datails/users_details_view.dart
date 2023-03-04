import 'package:flutter/material.dart';

class UsersDetailView extends StatelessWidget {
  static const String TAG = "UsersDetailView";

  const UsersDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsersDetail"),
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
