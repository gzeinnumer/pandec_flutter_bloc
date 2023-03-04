import 'package:flutter/material.dart';

class UsersListView extends StatelessWidget {
  static const String TAG = "UsersListView";

  const UsersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsersList"),
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
