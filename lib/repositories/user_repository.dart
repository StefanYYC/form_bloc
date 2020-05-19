import 'package:fresh/fresh.dart';
import 'package:meta/meta.dart';
import 'package:onbricolemobile/api/drupalapi_client.dart';
import 'package:onbricolemobile/models/user/user.dart';
import 'package:onbricolemobile/sign_up/bloc/signup_bloc.dart';

enum UserAuthenticationStatus {
  unknown,
  signedIn,
  signedOut,
}

class UserRepository {
  UserRepository(DrupalApiClient drupalApiClient)
      : _drupalApiClient = drupalApiClient;

  final DrupalApiClient _drupalApiClient;

  Stream<UserAuthenticationStatus> get authenticationStatus {
    return _drupalApiClient.authenticationStatus.map((status) {
      switch (status) {
        case AuthenticationStatus.authenticated:
          return UserAuthenticationStatus.signedIn;
        case AuthenticationStatus.unauthenticated:
          return UserAuthenticationStatus.signedOut;
        case AuthenticationStatus.initial:
        default:
          return UserAuthenticationStatus.unknown;
      }
    });
  }

  Future<void> signIn({
    @required String username,
    @required String password,
  }) async {
    await _drupalApiClient.logIn(username, password);
  }

/*
  Future<void> signOut() async {
    await _drupalApiClient.unauthenticate();
  }

  */

  // Signup
  Future<void> signUp(
      {@required String username,
      @required String prenom,
      @required String nom,
      @required String pass,
      @required String email,
      @required String phoneNumber,
      @required String ville,
      @required String codePostal,
      @required SignupNotifications notifications}) async {
    await _drupalApiClient.signUp(username, email, prenom, nom, pass, ville,
        phoneNumber, codePostal, notifications);
  }

  // Get user anywhere
  // Make request to the api
  Future<User> getUser() async {
    return User().copyWith(
        prenom: "Stefan",
        notifications: SignupNotifications.on,
        pass: "admin",
        nom: "Speter",
        username: "stefan",
        email: "stefan@admin.fr",
        codePostal: "59000");
  }
}
