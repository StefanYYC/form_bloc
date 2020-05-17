import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbricolemobile/authentication/bloc/authentication_bloc.dart';
import 'package:onbricolemobile/homepage/homepage_page.dart';
import 'package:onbricolemobile/login/login_page.dart';
import 'package:onbricolemobile/repositories/user_repository.dart';
import 'package:onbricolemobile/splash/splash_page.dart';

class App extends StatefulWidget {
  const App({
    Key key,
    @required this.userRepository,
  }) : super(key: key);

  final UserRepository userRepository;

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: widget.userRepository),
      ],
      child: BlocProvider(
        create: (context) {
          return AuthenticationBloc(context.repository<UserRepository>());
        },
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              listener: (context, state) {
                if (state is AuthenticationAuthenticated) {
                  _navigator.pushAndRemoveUntil(
                    HomePage.route(),
                    (_) => false,
                  );
                } else if (state is AuthenticationUnauthenticated) {
                  _navigator.pushAndRemoveUntil(
                    LoginPage.route(),
                    (_) => false,
                  );
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (settings) {
            if (settings.name == Navigator.defaultRouteName) {
              return SplashPage.route();
            }
            return null;
          },
        ),
      ),
    );
  }
}
