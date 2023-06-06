import 'package:flutter/material.dart';
import 'package:pandec_flutter_bloc/ui/login/login_view.dart';
import 'package:pandec_flutter_bloc/ui/splashScreen/splash_screen_view.dart';
import 'package:pandec_flutter_bloc/ui/users/datails/users_details_view.dart';
import 'package:pandec_flutter_bloc/ui/users/list/users_list_view.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case SplashScreenView.TAG:
        return MaterialPageRoute(builder: (_) => const SplashScreenView());
      case LoginView.TAG:
        return MaterialPageRoute(builder: (_) => LoginView());
      case UsersListView.TAG:
        return MaterialPageRoute(builder: (_) => UsersListView());
      case UsersDetailView.TAG:
        final args = routeSettings.arguments as int;
        return MaterialPageRoute(builder: (_) => UsersDetailView(args));
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreenView());
    }
  }
}

/*
Navigator.pushNamed(
  context,
  ClaimView.TAG,
).then((value) {
  // BlocProvider.of<HomeBloc>(context).add(HomeInitEvent());
});
*/

void pushAndRemoveUntil(BuildContext context, String tag, Widget view) {
  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => view), ModalRoute.withName(tag));
}
