part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {

  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

// Va vérifier la saisie du nom d'utilisateur en continue
class LoginUsernameChanged extends LoginEvent{

  LoginUsernameChanged(this.username);

  final String username;

  @override
  List<Object> get props => [username];
}

// Pareil pour le mot de passe
class LoginPasswordChanged extends LoginEvent {
  LoginPasswordChanged(this.password);

  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitted extends LoginEvent {}