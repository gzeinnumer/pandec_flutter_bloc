import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_ui.dart';
import 'package:pandec_flutter_bloc/ui/login/login_bloc.dart';
import 'package:pandec_flutter_bloc/ui/users/list/users_list_view.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

class LoginView extends StatelessWidget {
  static const String TAG = "LoginView";

  LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      //L1
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UsersRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<LoginBloc>(
              create: (context) => LoginBloc(
                repo: context.read<UsersRepo>(),
              )..add(LoginEventInit()),
            )
          ],
          child: _body(),
        ),
      ),
    );
  }

  //L2
  Widget _body() {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        final status = state.status;
        if (status is LoginStatusInitDone) {
          final c = state.status as LoginStatusInitDone;
        } else if (status is LoginStatusInfo) {
          final c = state.status as LoginStatusInfo;
          String TITLE = c.title.toString();
          String MSG = c.msg.toString();
          int TYPE = c.type!;
          toDialog(context, TITLE, MSG, TYPE, () {
            Navigator.pop(context);
            Navigator.pushReplacementNamed(context, UsersListView.TAG);
          });
        }
      },
      child: _content(),
    );
  }

  //L3
  Widget _content() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        if (state.status is LoginStatusLoading) {
          return const LoadingV1();
        }
        return _sections(context, state);
      },
    );
  }

  final _formKey = GlobalKey<FormState>();

  Widget _sections(BuildContext context, LoginState state) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(8),
      width: width,
      height: height,
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            edUsername(context, state),
            const SizedBox(height: 8),
            edPassword(context, state),
            const SizedBox(height: 8),
            edId(context, state),
            btnSubmit(context, state),
          ],
        ),
      ),
    );
  }

  final _edUsernameController = TextEditingController();

  Widget edUsername(BuildContext context, LoginState state) {
    return TextFormField(
      controller: _edUsernameController,
      validator: (value) => state.isValidEdUsername,
      onChanged: (value) => context.read<LoginBloc>().add(LoginEventEdUsername(value)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Username',
      ),
    );
  }

  final _edPasswordController = TextEditingController();

  Widget edPassword(BuildContext context, LoginState state) {
    return TextFormField(
      controller: _edPasswordController,
      validator: (value) => state.isValidEdPassword,
      onChanged: (value) => context.read<LoginBloc>().add(LoginEventEdPassword(value)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Password',
      ),
    );
  }

  final _edIdController = TextEditingController();

  Widget edId(BuildContext context, LoginState state) {
    return TextFormField(
      controller: _edIdController,
      validator: (value) => state.isValidEdId,
      onChanged: (value) => context.read<LoginBloc>().add(LoginEventEdId(value)),
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        hintText: 'Id',
      ),
    );
  }

  OutlinedButton btnSubmit(BuildContext context, LoginState state) {
    return OutlinedButton(
      onPressed: () {
        FocusManager.instance.primaryFocus?.unfocus();
        if (_formKey.currentState!.validate()) {
          context.read<LoginBloc>().add(LoginEventSubmit());
        }
      },
      child: const Text("Login"),
    );
  }
}
