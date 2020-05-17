part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {

  final User user;

  AuthenticationState(this.user);

  @override
  List<Object> get props => [user];

  @override
  bool get stringify => true;
}

class AuthenticationUnknown extends AuthenticationState {
  AuthenticationUnknown():super(null);
}

class AuthenticationAuthenticated extends AuthenticationState {
  // Allow to access the current user anywhere logged in
  AuthenticationAuthenticated(User user):super(user);

}

class AuthenticationUnauthenticated extends AuthenticationState {
  AuthenticationUnauthenticated():super(null);

}