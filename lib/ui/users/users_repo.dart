import 'package:pandec_flutter_bloc/data/network.dart';
import 'package:pandec_flutter_bloc/model/user_details_response.dart';
import 'package:pandec_flutter_bloc/model/user_response.dart';

class UsersRepo{
  final network = Network();

  //gzn_dart_future_fun
  Future<UsersResponse> getUsers() async {
   final res = await network.getUsers();
   return res;
  }

  Future<UsersDetailResponse> getUsersById(int id) async {
   final res = await network.getUsersById(id);
   return res;
  }

  Future<UsersDetailResponse> getUsersByEmailPass(String email, String password, int id) async {
   final res = await network.getUsersByEmailPass(email, password, id);
   return res;
  }
}