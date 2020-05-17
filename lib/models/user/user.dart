//import 'package:json_annotation/json_annotation.dart';

//@JsonSerializable()
import 'package:onbricolemobile/sign_up/bloc/signup_bloc.dart';

class User {
  //final int id;
  final String username;
  final String nom;
  final String prenom;
  final String email;
  final String codePostal;
  final String pass;
  final SignupNotifications notifications;

  const User([
    this.username,
    this.nom,
    this.prenom,
    this.email,
    this.codePostal,
    this.pass,
    this.notifications,
  ]);

  @override
  String toString() => 'User ($username, $nom, $prenom)';

  //User({this.id, this.nom, this.pass, this.codePostal, this.email, this.prenom, this.notifications, this.name});
  /*
  // Factory indique que cette fonctionne retourne une valeur venant d'une fonction (ici UserFromJson)
  factory User.fromJson(Map<String, dynamic> json) =>
     _$UserFromJson(json);   
  */

  User copyWith({
    final String username,
    final String nom,
    final String prenom,
    final String email,
    final String codePostal,
    final String pass,
    final SignupNotifications notifications,
  }) {
    return User(
      username ?? this.username,
      nom ?? this.nom,
      prenom ?? this.prenom,
      email ?? this.email,
      pass ?? this.pass,
      codePostal ?? this.codePostal,
      notifications ?? this.notifications,
    );
  }
}
