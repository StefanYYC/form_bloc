import 'package:flutter/material.dart';

final List<GlobalKey<FormState>> formKeys = [
  GlobalKey<FormState>(),
  GlobalKey<FormState>(),
  GlobalKey<FormState>()
];

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

enum NotificationOn { oui, non }

class _SignUpState extends State<SignUp> {
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _nomController = new TextEditingController();
  final TextEditingController _prenomController = new TextEditingController();
  final TextEditingController _confirmPasswordController =
      new TextEditingController();

  int currentStep = 0;
  bool complete = false;
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // -- To turn on the notification -- //
  NotificationOn _notificationOn = NotificationOn.oui;

  // -- Liste de tous les widgets utilisés dans les Step (Textfield etc) -- //

  // -- STEP 1 -- //
  Widget _buildNotification() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        ListTile(
          title: Text(
            'Oui j\'active les notifications',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
          ),
          leading: Radio(
            value: NotificationOn.oui,
            groupValue: _notificationOn,
            onChanged: (NotificationOn value) {
              setState(() {
                _notificationOn = value;
              });
            },
          ),
        ),
        ListTile(
          title: Text('Non merci'),
          leading: Radio(
            value: NotificationOn.non,
            groupValue: _notificationOn,
            onChanged: (NotificationOn value) {
              setState(() {
                _notificationOn = value;
              });
            },
          ),
        )
      ],
    );
  }

  Widget _buildTitleMail(){
    return Text(
      'MAIL',
      textAlign: TextAlign.start,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }

  Widget _buildTextFormFieldMail(){
    return TextFormField(
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
      controller: _emailController,
      autovalidate: true,
      validator: (String value) {
        int lengthMail = value.length;
        if (lengthMail > 0) {
          if (!RegExp(
              r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
              .hasMatch(value)) {
            return 'Entrez une adresse sous la forme "example@mail.com".';
          }
        } else if (lengthMail == 0) {
          return 'Ce champ ne peut pas être vide';
        }
        return null;
      },
      onSaved: (String value) {},
    );
  }

  Widget _buildTitleMdp(){
    return Text(
      'MOT DE PASSE'.toUpperCase(),
      textAlign: TextAlign.start,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
    );
  }

  Widget _buildTextFormFieldMdp(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Entrez votre mot de passe",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      style: TextStyle(fontSize: 17, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      controller: _passwordController,
      autovalidate: true, validator: (String value) {
      int lengthPwd = value.length;
      String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
      RegExp regExp = new RegExp(pattern);
      if (lengthPwd > 0) {
        if (!regExp.hasMatch(value)) {
          return 'Le mot de passe doit contenir au minimum 8caractères,\n 1chiffre, 1 caractère spécial & 1 majuscule.';
        }
      } else if (lengthPwd == 0) {
        return 'Ce champ ne peut pas être vide';
      }
      return null;
    },
      onSaved: (String value) {},
    );
  }

  Widget _buildTextFormFieldConfirmMdp(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Confirmation de votre mot de passe",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      style: TextStyle(fontSize: 17, color: Colors.black),
      cursorColor: Colors.black,
      obscureText: true,
      controller: _confirmPasswordController,
      autovalidate: true,
      validator: (String value) {
        int lengthConfirmPwd = value.length;
        if(lengthConfirmPwd == 0){
          return 'Ce champ est obligatoire.';
        }
        if (lengthConfirmPwd > 0) {
          if (_passwordController.text != value) {
            return 'Les mots de passes ne correspondent pas.';
          }
        } else if (lengthConfirmPwd == 0) {
          return 'Ce champ ne peut pas être vide';
        }
        return null;
      },
    );
  }

  // -- STEP 2 -- //
  Widget _buildTextFormFieldPrenom(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Prénom",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      autovalidate: true,
      controller: _prenomController,
      validator: (String value) {

        int lengthFirstName = value.length;
        if(lengthFirstName == 0){
          return 'Ce champ est obligatoire.';
        }
        if (lengthFirstName > 0) {
          if (RegExp('\\d+').hasMatch(value)) {
            return 'Votre prénom doit être uniquement composé de lettres';
          }
        }
        return null;
      },
    );
  }

  Widget _buildTextFormFieldNom(){
    return TextFormField(
      decoration: InputDecoration(
        hintText: "Nom",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      autovalidate: true,
      controller: _nomController,
      validator: (String value) {
        int lengthName = value.length;
        if(lengthName == 0){
          return 'Ce champ est obligatoire.';
        }
        if (lengthName > 0) {
          if (RegExp('\\d+').hasMatch(value)) {
            return 'Votre nom doit être uniquement composé de lettres';
          }
        }
        return null;
      },
    );
  }

  Widget _buildTextFormFieldCodePostal(){
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: "Code postal",
        hintStyle: TextStyle(fontSize: 14, color: Colors.blueGrey),
        fillColor: Color(0xffccf5ff),
        filled: true,
        border: InputBorder.none,
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent)),
      ),
      autovalidate: true,
      validator: (String value){
        int lengthCode = value.length;
        if(lengthCode == 0){
          return 'Ce champ est obligatoire.';
        }
        if(lengthCode is String){
          return 'Ce champ ne peut pas contenir de lettres.';
        }
        return null;
      },
    );
  }

  // -- STEP 3 -- //
  Widget _buildRichTextNotification(){
    return RichText(
      text: TextSpan(
        text: '           Recevez une alerte lors \n',
        style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w500,
            letterSpacing: 1),
        children: <TextSpan>[
          TextSpan(
              text: '  de la réservation de vos outils ou \n',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500)),
          TextSpan(
              text: 'la réception de nouveaux messages',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.w500))
        ],
      ),
    );
  }

  List<Step> steps() {
    return [
      // -- STEP 1 account info -- //
      Step(
        title: const Text('Compte'),
        isActive: currentStep >= 0,
        state: currentStep == 0 ? StepState.editing : StepState.complete,
        content: Container(
          width: 400,
          height: 316,
          child: Form(
            key: formKeys[0],
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                _buildTitleMail(),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormFieldMail(),
                SizedBox(
                  height: 10,
                ),
                _buildTitleMdp(),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormFieldMdp(),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormFieldConfirmMdp(),
              ],
            ),
          ),
        ),
      ),

      //-- STEP 2 pour les informations personnelles (Nom, prenom, code postal) --//
      Step(
        isActive: currentStep >= 1,
        state: (currentStep == 1)
            ? StepState.editing
            : (currentStep >= 1) ? StepState.complete : StepState.disabled,
        title: const Text('Informations'),
        content: Container(
          width: 400,
          height: 316,
          child: Form(
            key: formKeys[1],
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                _buildTextFormFieldPrenom(),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormFieldNom(),
                SizedBox(
                  height: 10,
                ),
                _buildTextFormFieldCodePostal(),
              ],
            ),
          ),
        ),
      ),

      //-- STEP 3 notification --//
      Step(
          state: (currentStep == 2)
              ? StepState.editing
              : (currentStep >= 2) ? StepState.complete : StepState.disabled,
          isActive: currentStep >= 2,
          title: Text('Notifications'),
          content: Form(
            key: formKeys[2],
            child: Container(
              width: 400,
              height: 316,
              padding: EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    'activer les notifications'.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    child: Center(
                      widthFactor: 20,
                      child: _buildRichTextNotification(),
                    ),
                  ),
                  _buildNotification(),
                ],
              ),
            ),
          )),
    ];
  }

  @override
  Widget build(BuildContext context) {

    void showSnackBarMessage(String message,
        [MaterialColor color = Colors.red]) {
      Scaffold.of(context).showSnackBar(SnackBar(content: Text(message)));
    }

    // -- Manage the global form and save if all the forms validated correctly -- //
    void _submitDetails() {
      final FormState formState = _formKey.currentState;

      if (!formState.validate()) {
        showSnackBarMessage('Please enter correct data');
      } else {
        formState.save();
        print('Saved');

        Navigator.pushNamed(context, '/home');
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Créer un compte'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Image.asset('assets/img/header_onbricole.png'),
          Form(
            key: _formKey,
            child: Expanded(
              child: Stepper(
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
                steps: steps(),
                currentStep: currentStep,
                onStepContinue: () {
                  setState(() {
                    if (formKeys[currentStep].currentState.validate()) {
                      if (currentStep < steps().length - 1) {
                        currentStep = currentStep + 1;
                      } else {
                        _submitDetails();
                      }
                    }
                  });
                },
                onStepTapped: (step) => (step) {
                  setState(() {
                    currentStep = step;
                  });
                },
                onStepCancel: () {
                  setState(() {
                    if (currentStep > 0) {
                      currentStep = currentStep - 1;
                    } else {
                      currentStep = 0;
                    }
                  });
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
