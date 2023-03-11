import 'package:flutter/material.dart';
import 'package:pandec_flutter_bloc/ui/users/list/users_list_view.dart';

class LoginView extends StatelessWidget {
  static const String TAG = "LoginView";

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: _body(),
    );
  }

  //L2
  Widget _body() {
    return _content();
  }

  //L3
  Widget _content() {
    return Builder(
      builder: (context) {
        return _sections(context);
      }
    );
  }

  Widget _sections(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      height: height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          btnSubmit(context),
        ],
      ),
    );
  }

  OutlinedButton btnSubmit(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        Navigator.pushReplacementNamed(context, UsersListView.TAG);
      },
      child: const Text("Login"),
    );
  }
}