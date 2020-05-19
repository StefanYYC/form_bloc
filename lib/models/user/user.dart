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
  final String ville;
  final String phoneNumber;
  final String pass;
  final SignupNotifications notifications;

  const User([
    this.username,
    this.nom,
    this.prenom,
    this.ville,
    this.phoneNumber,
    this.email,
    this.codePostal,
    this.pass,
    this.notifications,
  ]);

  @override
  String toString() => 'User ($username, $nom, $prenom)';

  User copyWith({
    final String username,
    final String nom,
    final String prenom,
    final String email,
    final String phoneNumber,
    final String ville,
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
      ville ?? this.ville,
      phoneNumber ?? this.phoneNumber,
      codePostal ?? this.codePostal,
      notifications ?? this.notifications,
    );
  }
}
