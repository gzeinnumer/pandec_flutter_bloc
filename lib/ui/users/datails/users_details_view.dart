import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_ui.dart';
import 'package:pandec_flutter_bloc/ui/users/datails/users_details_bloc.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

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
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UsersRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UsersDetailBloc>(
              create: (context) => UsersDetailBloc(
                repo: context.read<UsersRepo>(),
                id: args,
              )..add(UsersDetailEventInit()),
            )
          ],
          child: _body(),
        ),
      ),
    );
  }

  //L2
  Widget _body() {
    return BlocListener<UsersDetailBloc, UsersDetailState>(
      listener: (context, state) {
        final status = state.status;
        if (status is UsersDetailStatusInitDone) {
          final c = state.status as UsersDetailStatusInitDone;
        } else if (status is UsersDetailStatusInfo) {
          final c = state.status as UsersDetailStatusInfo;
          String TITLE = c.title.toString();
          String MSG = c.msg.toString();
          int TYPE = c.type!;
          toDialog(context, TITLE, MSG, TYPE, null);
        }
      },
      child: _content(),
    );
  }

  //L3
  Widget _content() {
    return BlocBuilder<UsersDetailBloc, UsersDetailState>(
      builder: (context, state) {
        if (state.status is UsersDetailStatusLoading) {
          return const LoadingV1();
        }
        if (state.data == null) {
          return const NoData();
        }
        return _sections(context, state);
      },
    );
  }

  Widget _sections(BuildContext context, UsersDetailState state) {
    return Builder(builder: (context) {
      return Container(
        height: double.infinity,
        color: Colors.red.withOpacity(0.5),
        child: SingleChildScrollView(
          child: ContainerParentStroke(
            child: Column(
              children: [
                _section1(context, state),
              ],
            ),
          ),
        ),
      );
    });
  }

  _section1(BuildContext context, UsersDetailState state) {
    return Column(
      children: [
        Text('${state.data!.id}'),
        Text('${state.data!.name}'),
        Text('${state.data!.email}'),
        Text('${state.data!.emailVerifiedAt}'),
        Text('${state.data!.password}'),
        Text('${state.data!.rememberToken}'),
        Text('${state.data!.createdAt}'),
        Text('${state.data!.updatedAt}'),
      ],
    );
  }
}
