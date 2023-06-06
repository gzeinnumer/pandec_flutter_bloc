import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_constans.dart';
import 'package:pandec_flutter_bloc/model/user_response.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

//EVENT-------------------------------------------------------------------------
abstract class UsersListEvent {}

class UsersListEventInit extends UsersListEvent {}

//Custom Edit
class UsersListEventEdSearch extends UsersListEvent {
  final String value;

  UsersListEventEdSearch(this.value);
}

class UsersListEventSubmit extends UsersListEvent {}

//STATUS------------------------------------------------------------------------
abstract class UsersListStatus {
  const UsersListStatus();
}

class UsersListStatusInit extends UsersListStatus {
  const UsersListStatusInit();
}

class UsersListStatusLoading extends UsersListStatus {
  const UsersListStatusLoading();
}

class UsersListStatusInitDone extends UsersListStatus {
  const UsersListStatusInitDone();
}

class UsersListStatusOnInput extends UsersListStatus {
  const UsersListStatusOnInput();
}

class UsersListStatusInfo extends UsersListStatus {
  final String? _title;
  final String? _msg;
  final int? _type;

  //type 1 = success->back
  //type 2 = info->stay
  //type 3 = info->back
  //type 4 = confirm
  //type 5 = snackbar
  //type 6 = action

  String? get title => _title;

  String? get msg => _msg;

  int? get type => _type;

  UsersListStatusInfo(this._title, this._msg, this._type);
}

//STATE-------------------------------------------------------------------------
class UsersListState {
  final String edSearch;

  String? get isValidEdSearch => edSearch.toString().isNotEmpty ? null : "required";

  List<DataUsers>? data;
  List<DataUsers>? dataFilter;

  final UsersListStatus status;

  UsersListState({
    this.edSearch = "",
    this.data = const [],
    this.dataFilter = const [],
    this.status = const UsersListStatusInit(),
  });

  UsersListState copyWith({
    String? edSearch,
    List<DataUsers>? data,
    List<DataUsers>? dataFilter,
    UsersListStatus? status,
  }) {
    return UsersListState(
      edSearch: edSearch ?? this.edSearch,
      data: data ?? this.data,
      dataFilter: dataFilter ?? this.dataFilter,
      status: status ?? this.status,
    );
  }
}

//BLOC--------------------------------------------------------------------------
class UsersListBloc extends Bloc<UsersListEvent, UsersListState> {
  final UsersRepo repo;

  UsersListBloc({
    required this.repo,
  }) : super(UsersListState());

  @override
  Stream<UsersListState> mapEventToState(UsersListEvent event) async* {
    if (event is UsersListEventInit) {
      //FOR LIST
      try {
        yield state.copyWith(status: const UsersListStatusLoading());

        final res = await repo.getUsers();
        //
        yield state.copyWith(status: const UsersListStatusInitDone());
        if (res.status == 1) {
          yield state.copyWith(
            data: res.data,
            dataFilter: res.data,
            status: UsersListStatusInfo(MSG_WARNING, "Success Get Data", 2),
          );
        } else {
          yield state.copyWith(
            data: [],
            dataFilter: [],
            status: UsersListStatusInfo(MSG_WARNING, res.message, 2),
          );
        }
        yield state.copyWith(status: const UsersListStatusOnInput());
      } on Error catch (e) {
        yield state.copyWith(status: UsersListStatusInfo(MSG_WARNING, e.toString(), 2));
        yield state.copyWith(status: const UsersListStatusOnInput());
      }
    } else if (event is UsersListEventEdSearch) {
      yield state.copyWith(edSearch: event.value);

      // print("zein_${state.data!.length}");
      // print("zein_${state.dataFilter!.length}");
      List<DataUsers>? realData = state.data!.map((v) => v).toList();
      List<DataUsers>? res = [];
      if (realData.isNotEmpty) {
        for (var i = 0; i < realData.length; i++) {
          if (realData[i].name!.contains(event.value)) {
            // print("zein_"+realData[i].name.toString());
            // print("zein_"+event.value);
            res.add(realData[i]);
          }
        }
      }

      if (event.value.isNotEmpty) {
        // print("zein_1_${res.length}");
        yield state.copyWith(
          dataFilter: res,
        );
      } else {
        // print("zein_2_${res.length}");
        yield state.copyWith(
          dataFilter: realData,
        );
      }
      yield state.copyWith(status: const UsersListStatusInitDone());
      yield state.copyWith(status: const UsersListStatusOnInput());
    } else if (event is UsersListEventSubmit) {}
  }
}

