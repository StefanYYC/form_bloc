import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:onbricolemobile/login/login_page.dart';
import 'package:onbricolemobile/models/user/user.dart';
import 'package:onbricolemobile/sign_up/bloc/signup_bloc.dart';

class SignupPage extends StatefulWidget {
  // Route to call this page from anywhere
  // Navigator.pushAndRemoveUntil(context, SignUpPage.route(), (_) => false);
  static Route<User> route() {
    return MaterialPageRoute<User>(
      builder: (_) => BlocProvider(
        create: (_) => SignupBloc(),
        child: const SignupPage._(),
      ),
    );
  }

  const SignupPage._();

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  SignupNotifications _notifications = SignupNotifications.off;

  @override
  Widget build(BuildContext context) {
    bool _canContinue() {
      final state = context.bloc<SignupBloc>().state;
      switch (state.step) {
        case SignupStep.compte:
          return state.passwordMatching &&
              state.compteStatus == StepStatus.valid;
        case SignupStep.informations:
          return state.informationsStatus == StepStatus.valid;
        case SignupStep.notifications:
          return state.notificationsStatus == StepStatus.valid;
        default:
          return false;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Créer un compte'),
        centerTitle: true,
      ),
      body: BlocConsumer<SignupBloc, SignupState>(listener: (context, state) {
        if (state.complete) {
          Navigator.of(context).pop(state.user);
        }
      }, builder: (context, state) {
        return Column(
          children: <Widget>[
            Image.asset('assets/img/header_onbricole.png'),
            Expanded(
              child: Stepper(
                currentStep: state.step.index,
                onStepContinue: _canContinue()
                    ? () =>
                        context.bloc<SignupBloc>().add(SignupStepCompleted())
                    : null,
                onStepCancel: () => state.step.index > 0
                    ? context.bloc<SignupBloc>().add(SignupStepCancelled())
                    : Navigator.pushAndRemoveUntil(
                        context, LoginPage.route(), (_) => false),
                controlsBuilder: (BuildContext context,
                    {VoidCallback onStepContinue, VoidCallback onStepCancel}) {
                  return Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      FlatButton(
                        color: Colors.orange,
                        textColor: Colors.white,
                        splashColor: Colors.orangeAccent,
                        onPressed: onStepContinue,
                        child: Text('Suivant', style: TextStyle(fontSize: 16)),
                      ),
                      FlatButton(
                        onPressed: onStepCancel,
                        child: Text('Annuler', style: TextStyle(fontSize: 16)),
                      ),
                    ],
                  );
                },
                type: StepperType.horizontal,
                steps: [
                  // Step 1
                  // -- STEP 1 account info -- //
                  Step(
                    title: const Text('Compte'),
                    isActive: state.step.index == 0,
                    state: state.step.index == 0
                        ? StepState.editing
                        : StepState.complete,
                    content: Container(
                      width: 400,
                      height: 316,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'MAIL',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Entrez votre mail",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                              fillColor: Color(0xffccf5ff),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            keyboardType: TextInputType.emailAddress,
                            style: TextStyle(fontSize: 17, color: Colors.black),
                            cursorColor: Colors.black,
                            autovalidate: true,
                            validator: (_) => state.compteStatus ==
                                    StepStatus.invalid
                                ? 'Entrez une adresse sous la forme "example@mail.com".'
                                : null,
                            onChanged: (mail) {
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupMailChanged(mail));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'MOT DE PASSE'.toUpperCase(),
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Entrez votre mot de passe",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                              fillColor: Color(0xffccf5ff),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                            cursorColor: Colors.black,
                            obscureText: true,
                            autovalidate: true,
                            validator: (_) => state.compteStatus ==
                                    StepStatus.invalid
                                ? 'Le mot de passe doit contenir au minimum 8caractères,\n 1chiffre, 1 caractère spécial & 1 majuscule.'
                                : null,
                            onChanged: (mdp) {
                              print('On change mdp : ' + mdp);
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupMdpChanged(mdp));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Confirmation de votre mot de passe",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                              fillColor: Color(0xffccf5ff),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            style: TextStyle(fontSize: 17, color: Colors.black),
                            cursorColor: Colors.black,
                            obscureText: true,
                            autovalidate: true,
                            validator: (_) => state.compteStatus ==
                                    StepStatus.invalid
                                ? 'Les mots de passes ne sont pas identiques.'
                                : null,
                            onChanged: (mdpConfirm) {
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupMdpConfirmChanged(mdpConfirm));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),

                  //-- STEP 2 pour les informations personnelles (Nom, prenom, code postal) --//
                  Step(
                    isActive: state.step.index == 1,
                    state: (state.step.index == 1)
                        ? StepState.editing
                        : (state.step.index >= 1)
                            ? StepState.complete
                            : StepState.disabled,
                    title: const Text('Informations'),
                    content: Container(
                      width: 400,
                      height: 316,
                      child: Column(
                        children: <Widget>[
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Prénom",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                              fillColor: Color(0xffccf5ff),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            autovalidate: true,
                            validator: (_) =>
                                state.informationsStatus == StepStatus.invalid
                                    ? 'Entrez un prénom valide.'
                                    : null,
                            onChanged: (prenom) {
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupPrenomChanged(prenom));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                              hintText: "Nom",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                              fillColor: Color(0xffccf5ff),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            autovalidate: true,
                            key: Key("name"),
                            validator: (_) =>
                                state.informationsStatus == StepStatus.invalid
                                    ? 'Entrez un nom valide.'
                                    : null,
                            onChanged: (nom) {
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupNomChanged(nom));
                            },
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: "Code postal",
                              hintStyle: TextStyle(
                                  fontSize: 14, color: Colors.blueGrey),
                              fillColor: Color(0xffccf5ff),
                              filled: true,
                              border: InputBorder.none,
                              enabledBorder: OutlineInputBorder(
                                  borderSide:
                                      BorderSide(color: Colors.transparent)),
                            ),
                            autovalidate: true,
                            validator: (_) =>
                                state.informationsStatus == StepStatus.invalid
                                    ? 'Rentrez un code postal valide'
                                    : null,
                            onChanged: (codePostal) {
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupCodePostalChanged(codePostal));
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  //-- STEP 3 notifications --//
                  Step(
                    state: (state.step.index == 2)
                        ? StepState.editing
                        : (state.step.index >= 2)
                            ? StepState.complete
                            : StepState.disabled,
                    isActive: state.step.index >= 2,
                    title: Text('Notifications'),
                    content: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text('ACTIVER LES NOTIFICATIONS'.toUpperCase(),
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text('Recevez une alerte lors ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text('de la réservation de vos outils ou ',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                                Text('la réception de nouveaux messages',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ],
                            ),
                          ],
                        ),
                        ListTile(
                          title: const Text('Oui'),
                          leading: Radio(
                            value: SignupNotifications.on,
                            groupValue: _notifications,
                            onChanged: (SignupNotifications value) {
                              print(value);
                              setState(() {
                                _notifications = value;
                              });
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupActivateNotifications(value));
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Non'),
                          leading: Radio(
                            value: SignupNotifications.off,
                            groupValue: _notifications,
                            onChanged: (SignupNotifications value) {
                              print(value);
                              setState(() {
                                _notifications = value;
                              });
                              context
                                  .bloc<SignupBloc>()
                                  .add(SignupActivateNotifications(value));
                            },
                          ),
                        ),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}

//class TextFieldName extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    return BlocBuilder<SignupBloc, SignupState>(builder: (context, state) {
//      return
//    });
//  }
//}
