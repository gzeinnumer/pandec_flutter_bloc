import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pandec_flutter_bloc/base/base_ui.dart';
import 'package:pandec_flutter_bloc/ui/users/datails/users_details_view.dart';
import 'package:pandec_flutter_bloc/ui/users/list/users_list_bloc.dart';
import 'package:pandec_flutter_bloc/ui/users/users_repo.dart';

class UsersListView extends StatelessWidget {
  static const String TAG = "UsersListView";

  UsersListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("UsersList"),
      ),
      //L1
      body: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(create: (context) => UsersRepo()),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<UsersListBloc>(
              create: (context) => UsersListBloc(
                repo: context.read<UsersRepo>(),
              )..add(UsersListEventInit()),
            )
          ],
          child: _body(),
        ),
      ),
    );
  }

  //L2
  Widget _body() {
    return BlocListener<UsersListBloc, UsersListState>(
      listener: (context, state) {
        final status = state.status;
        if (status is UsersListStatusInitDone) {
          final c = state.status as UsersListStatusInitDone;
        } else if (status is UsersListStatusInfo) {
          final c = state.status as UsersListStatusInfo;
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
    return BlocBuilder<UsersListBloc, UsersListState>(
      builder: (context, state) {
        if (state.status is UsersListStatusLoading) {
          return const LoadingV1();
        }
        if (state.data == null) {
          return const NoData();
        }
        return _sectionsList(context, state);
      },
    );
  }

  Widget _sectionsList(BuildContext context, UsersListState state) {
    return ContainerParentList(
      child: Column(
        children: [
          // Text('${state.data!.length}'),
          edSearch(context, state),
          Expanded(
            // child: state.data!.isEmpty
            child: state.dataFilter!.isEmpty
                ? const NoData()
                : ListView.builder(
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            UsersDetailView.TAG,
                            // arguments: state.data![index].id,
                            arguments: state.dataFilter![index].id,
                          ).then((value) {
                            BlocProvider.of<UsersListBloc>(context).add(UsersListEventInit());
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          margin: const EdgeInsets.all(8),
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(16.0)),
                          ),
                          // child: Text(state.data![index].toJsonCustom()),
                          child: Text(state.dataFilter![index].toJsonCustom()),
                        ),
                      );
                    },
                    // itemCount: state.data!.length,
                    itemCount: state.dataFilter!.length,
                  ),
          ),
        ],
      ),
    );
  }

  final _edSearch = TextEditingController();

  Widget edSearch(BuildContext context, UsersListState state) {
    return Container(
      margin: EdgeInsets.all(6),
      child: TextFormField(
        controller: _edSearch,
        // validator: (value) => state.isValidEdSearch,
        onChanged: (value) => context.read<UsersListBloc>().add(UsersListEventEdSearch(value)),
        decoration: const InputDecoration(
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16.0))),
          hintText: 'Username',
          filled: true, //<-- SEE HERE
          fillColor: Colors.white, //<-- SEE HERE
        ),
      ),
    );
  }
}
