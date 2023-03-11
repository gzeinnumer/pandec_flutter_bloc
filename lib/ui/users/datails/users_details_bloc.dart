import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_constans.dart';
import 'package:pandec_flutter_bloc/model/user_details_response.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

//EVENT-------------------------------------------------------------------------
abstract class UsersDetailEvent {}

class UsersDetailEventInit extends UsersDetailEvent {}

class UsersDetailEventEd extends UsersDetailEvent {
  final String value;

  UsersDetailEventEd(this.value);
}

class UsersDetailEventSubmit extends UsersDetailEvent {}

//STATUS------------------------------------------------------------------------
abstract class UsersDetailStatus {
  const UsersDetailStatus();
}

class UsersDetailStatusInit extends UsersDetailStatus {
  const UsersDetailStatusInit();
}

class UsersDetailStatusLoading extends UsersDetailStatus {
  const UsersDetailStatusLoading();
}

class UsersDetailStatusInitDone extends UsersDetailStatus {
  const UsersDetailStatusInitDone();
}

class UsersDetailStatusOnInput extends UsersDetailStatus {
  const UsersDetailStatusOnInput();
}

class UsersDetailStatusInfo extends UsersDetailStatus {
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

  UsersDetailStatusInfo(this._title, this._msg, this._type);
}

//STATE-------------------------------------------------------------------------
class UsersDetailState {
  final String ed;

  String? get isValidEd => ed.toString().isNotEmpty ? null : "required";

  DataUsersDetail? data;

  final UsersDetailStatus status;

  UsersDetailState({
    this.ed = "",
    this.data,
    this.status = const UsersDetailStatusInit(),
  });

  UsersDetailState copyWith({
    String? ed,
    DataUsersDetail? data,
    UsersDetailStatus? status,
  }) {
    return UsersDetailState(
      ed: ed ?? this.ed,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}

//BLOC--------------------------------------------------------------------------
class UsersDetailBloc extends Bloc<UsersDetailEvent, UsersDetailState> {
  final UsersRepo repo;
  final int id;

  UsersDetailBloc({
    required this.repo,
    required this.id,
  }) : super(UsersDetailState());

  @override
  Stream<UsersDetailState> mapEventToState(UsersDetailEvent event) async* {
    if (event is UsersDetailEventInit) {
      //FOR DETAIL
      try {
        yield state.copyWith(status: const UsersDetailStatusLoading());

        final res = await repo.getUsersById(id);

        yield state.copyWith(status: const UsersDetailStatusInitDone());
        if (res.status == 1) {
          yield state.copyWith(
            data: res.data,
            status: UsersDetailStatusInfo(MSG_WARNING, "Success", 2),
          );
        } else {
          yield state.copyWith(
            data: null,
            status: UsersDetailStatusInfo(MSG_WARNING, res.message, 2),
          );
        }
        yield state.copyWith(status: const UsersDetailStatusOnInput());
      } on Error catch (e) {
        yield state.copyWith(status: UsersDetailStatusInfo(MSG_WARNING, e.toString(), 2));
        yield state.copyWith(status: const UsersDetailStatusOnInput());
      }
    } else if (event is UsersDetailEventEd) {
      yield state.copyWith(ed: event.value);
    } else if (event is UsersDetailEventSubmit) {}
  }
}
