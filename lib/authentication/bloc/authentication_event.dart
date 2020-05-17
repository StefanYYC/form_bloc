part of 'authentication_bloc.dart';

abstract class AuthenticationEvent extends Equatable {
  @override
  List<Object> get props => [];

  @override
  bool get stringify => true;
}

// Will update the user authentication status
//  unknown,
//  signedIn,
//  signedOut

class AuthenticationStatusChanged extends AuthenticationEvent {

   AuthenticationStatusChanged(this.authenticationStatus);

   final UserAuthenticationStatus authenticationStatus;

}

class LoggedOut extends AuthenticationEvent {}