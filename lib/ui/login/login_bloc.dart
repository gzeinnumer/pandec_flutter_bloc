import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_constans.dart';
import 'package:pandec_flutter_bloc/model/user_details_response.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

//EVENT-------------------------------------------------------------------------
abstract class LoginEvent {}

class LoginEventInit extends LoginEvent {}

class LoginEventEdUsername extends LoginEvent {
  final String value;

  LoginEventEdUsername(this.value);
}

class LoginEventEdPassword extends LoginEvent {
  final String value;

  LoginEventEdPassword(this.value);
}

class LoginEventEdId extends LoginEvent {
  final String value;

  LoginEventEdId(this.value);
}

class LoginEventSubmit extends LoginEvent {}

//STATUS------------------------------------------------------------------------
abstract class LoginStatus {
  const LoginStatus();
}

class LoginStatusInit extends LoginStatus {
  const LoginStatusInit();
}

class LoginStatusInitDone extends LoginStatus {
  const LoginStatusInitDone();
}

class LoginStatusOnInput extends LoginStatus {
  const LoginStatusOnInput();
}

class LoginStatusLoading extends LoginStatus {
  const LoginStatusLoading();
}

class LoginStatusInfo extends LoginStatus {
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

  LoginStatusInfo(this._title, this._msg, this._type);
}

//STATE-------------------------------------------------------------------------
class LoginState {
  final String edUsername;

  String? get isValidEdUsername => edUsername.toString().isNotEmpty ? null : "required";

  final String edPassword;

  String? get isValidEdPassword => edPassword.toString().isNotEmpty ? null : "required";

  final String edId;

  String? get isValidEdId => edId.toString().isNotEmpty ? null : "required";

  DataUsersDetail? data;

  final LoginStatus status;

  LoginState({
    this.edUsername = "",
    this.edPassword = "",
    this.edId = "",
    this.data,
    this.status = const LoginStatusInit(),
  });

  LoginState copyWith({
    String? edUsername,
    String? edPassword,
    String? edId,
    DataUsersDetail? data,
    LoginStatus? status,
  }) {
    return LoginState(
      edUsername: edUsername ?? this.edUsername,
      edPassword: edPassword ?? this.edPassword,
      edId: edId ?? this.edId,
      data: data ?? this.data,
      status: status ?? this.status,
    );
  }
}

//BLOC--------------------------------------------------------------------------
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UsersRepo repo;

  LoginBloc({
    required this.repo,
  }) : super(LoginState());

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginEventInit) {
      yield state.copyWith(status: const LoginStatusLoading());
      yield state.copyWith(data: null);

      yield state.copyWith(status: const LoginStatusInitDone());
    } else if (event is LoginEventEdUsername) {
      yield state.copyWith(edUsername: event.value);
    } else if (event is LoginEventEdPassword) {
      yield state.copyWith(edPassword: event.value);
    } else if (event is LoginEventEdId) {
      yield state.copyWith(edId: event.value);
    } else if (event is LoginEventSubmit) {
      yield state.copyWith(status: const LoginStatusLoading());

      try {
        final res = await repo.getUsersByEmailPass(state.edUsername, state.edPassword, int.parse(state.edId));
        //FOR FORM
        yield state.copyWith(status: const LoginStatusInitDone());
        if (res.status == 1) {
          yield state.copyWith(data: res.data, status: LoginStatusInfo(MSG_WARNING, "Success", 6));
        } else {
          yield state.copyWith(data: null, status: LoginStatusInfo(MSG_WARNING, res.message, 2));
        }
        yield state.copyWith(status: const LoginStatusOnInput());
      } on Error catch (e) {
        yield state.copyWith(status: LoginStatusInfo(MSG_WARNING, e.toString(), 2));
        yield state.copyWith(status: const LoginStatusOnInput());
      }
    }
  }
}
