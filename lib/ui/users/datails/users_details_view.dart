import 'package:flutter/material.dart';
import 'package:pandec_flutter_bloc/base/base_ui.dart';

class UsersDetailView extends StatelessWidget {
  static const String TAG = "UsersDetailView";
  final int args;

  const UsersDetailView(
      this.args, {
        Key? key,
      }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsersItem"),
      ),
      //L1
      body: _sections(context),
    );
  }

  Widget _sections(BuildContext context) {
    return Builder(builder: (context) {
      return Container(
        height: double.infinity,
        color: Colors.red.withOpacity(0.5),
        child: SingleChildScrollView(
          child: ContainerParentStroke(
            child: Column(
              children: [
                Text('${args}'),
              ],
            ),
          ),
        ),
      );
    });
  }
}