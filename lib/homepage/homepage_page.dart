import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbricolemobile/authentication/bloc/authentication_bloc.dart';

class HomePage extends StatelessWidget {

  static Route route(){
    return MaterialPageRoute(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final user = context.bloc<AuthenticationBloc>().state.user;
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Bienvenue sur onbricole ${user.prenom}'),
        ),
      ),
    );
  }
}
