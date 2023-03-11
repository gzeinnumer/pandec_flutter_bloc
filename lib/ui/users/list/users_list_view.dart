import 'package:flutter/material.dart';
import 'package:pandec_flutter_bloc/ui/users/datails/users_details_view.dart';

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
        double width = MediaQuery.of(context).size.width;
        double height = MediaQuery.of(context).size.height;
        return Container(
          height: double.infinity,
          color: Colors.red.withOpacity(0.5),
          child: SingleChildScrollView(
            child: Column(

              children: [
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      UsersDetailView.TAG,
                      arguments: 1
                    );
                  },
                  child: Container(
                    width: width,
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(16.0)),
                    ),
                    child: Text("Data 1"),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
