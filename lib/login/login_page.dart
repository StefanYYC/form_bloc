import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onbricolemobile/login/bloc/login_bloc.dart';
import 'package:onbricolemobile/repositories/user_repository.dart';
import 'package:onbricolemobile/sign_up/signup_page.dart';

class LoginPage extends StatelessWidget {
  // Give le paramètre route pour appeler cette page de n'importe où en utilisant
  //
  //    _navigator.pushAndRemoveUntil(
  //                LoginPage.route(),
  //                    (_) => false,
  //                );
  //
  static Route route() {
    return MaterialPageRoute(builder: (_) => LoginPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => LoginBloc(context.repository<UserRepository>()),
        child: Login(),
      ),
    );
  }
}

class Login extends StatelessWidget {
  bool passwordVisible;

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if (state.status == LoginStatus.submissionFailure) {
          Scaffold.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(SnackBar(
              content: const Text(
                'L\'identifiant ou le mot de passe est invalide.',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.orange,
            ));
        }
      },
      child: FormTextFields(),
    );
  }
}

class FormTextFields extends StatefulWidget {
  @override
  _FormTextFieldsState createState() => _FormTextFieldsState();
}

class _FormTextFieldsState extends State<FormTextFields> {
  // Afficher ou cacher le mdp
  bool passwordVisible;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  // -- Input email --
  Widget _buildEmailField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Entrez votre mail",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      keyboardType: TextInputType.emailAddress,
      style: TextStyle(fontSize: 17, color: Colors.black),
      cursorColor: Colors.black,
      onChanged: (value) {
        context.bloc<LoginBloc>().add(LoginUsernameChanged(value));
      },
    );
  }

  // -- Input password --
  Widget _buildPasswordField() {
    return TextField(
      decoration: InputDecoration(
        hintText: "Entrez votre mot de passe",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
        suffixIcon: IconButton(
          icon: Icon(
            // Based on passwordVisible state choose the icon
            passwordVisible ? Icons.visibility : Icons.visibility_off,
            color: Colors.black,
          ),
          onPressed: () {
            // Update the state i.e. toogle the state of passwordVisible variable
            setState(() {
              passwordVisible = !passwordVisible;
            });
          },
        ),
      ),
      style: TextStyle(fontSize: 17, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: passwordVisible,
      onChanged: (value) {
        context.bloc<LoginBloc>().add(LoginPasswordChanged(value));
      },
    );
  }

  // -- Email title --
  @override
  Widget build(BuildContext context) {
    final titreMail = Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              "Mail/Username".toUpperCase(),
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );

    // -- Password title --
    final titreMdp = Column(
      children: <Widget>[
        Align(
          alignment: Alignment.centerLeft,
          child: Container(
            child: Text(
              "Mot de passe".toUpperCase(),
              style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );

    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(
          height: MediaQuery.of(context).size.height,
        ),
        decoration: BoxDecoration(color: Colors.white),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(32, 96, 32, 0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage('assets/img/header_onbricole.png'),
                ),
                SizedBox(height: 40),
                titreMail,
                SizedBox(
                  height: 10,
                ),
                _buildEmailField(),
                SizedBox(
                  height: 10,
                ),
                titreMdp,
                SizedBox(
                  height: 10,
                ),
                _buildPasswordField(),
                SizedBox(height: 32),
                BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) {
                    return ButtonTheme(
                      minWidth: 200,
                      buttonColor: Colors.orange,
                      child: RaisedButton(
                        padding: EdgeInsets.fromLTRB(70, 10, 70, 10),
                        child: state.status == LoginStatus.submissionInProgress
                            ? const CircularProgressIndicator()
                            : const Text(
                                'SE CONNECTER',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                        onPressed: state.submissionEnabled
                            ? () =>
                                context.bloc<LoginBloc>().add(LoginSubmitted())
                            : null,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 10,
                ),
                ButtonTheme(
                  minWidth: 200,
                  buttonColor: Colors.orange,
                  child: RaisedButton(
                    padding: EdgeInsets.fromLTRB(90, 10, 90, 10),
                    child: Text(
                      'S\'inscrire'.toUpperCase(),
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.push(context, SignupPage.route());
                    },
                    ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
