import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_constans.dart';
import 'package:pandec_flutter_bloc/model/user_response.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

//EVENT-------------------------------------------------------------------------
abstract class UsersListEvent {}

class UsersListEventInit extends UsersListEvent {}

class UsersListEventEd extends UsersListEvent {
  final String value;

  UsersListEventEd(this.value);
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
  final String ed;

  String? get isValidEd => ed.toString().isNotEmpty ? null : "required";

  List<DataUsers>? data;

  final UsersListStatus status;

  UsersListState({
    this.ed = "",
    this.data = const [],
    this.status = const UsersListStatusInit(),
  });

  UsersListState copyWith({
    String? ed,
    List<DataUsers>? data,
    UsersListStatus? status,
  }) {
    return UsersListState(
      ed: ed ?? this.ed,
      data: data ?? this.data,
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

        yield state.copyWith(status: const UsersListStatusInitDone());
        if (res.status == 1) {
          yield state.copyWith(
            data: res.data,
            status: UsersListStatusInfo(MSG_WARNING, "Success", 2),
          );
        } else {
          yield state.copyWith(
            data: [],
            status: UsersListStatusInfo(MSG_WARNING, res.message, 2),
          );
        }
        yield state.copyWith(status: const UsersListStatusOnInput());
      } on Error catch (e) {
        yield state.copyWith(status: UsersListStatusInfo(MSG_WARNING, e.toString(), 2));
        yield state.copyWith(status: const UsersListStatusOnInput());
      }
    } else if (event is UsersListEventEd) {
      yield state.copyWith(ed: event.value);
    } else if (event is UsersListEventSubmit) {}
  }
}
