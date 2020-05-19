import 'dart:convert';
import 'package:fresh/fresh.dart';
import 'package:onbricolemobile/api/api_client.dart';
import 'package:onbricolemobile/sign_up/bloc/signup_bloc.dart';

class DrupalApiClient {
  final ApiClient apiClient;

  // Give api client if you don't have one
  DrupalApiClient({ApiClient apiClient}) : apiClient = apiClient ?? ApiClient();

  // Private variable used to do ALL the API calls
  final _urlPrepod = "preprod.onbricole.fr";

  Stream<AuthenticationStatus> get authenticationStatus =>
      apiClient.authenticationStatus;

  // -- Utilisation de l'API pour se connecter -- //
  Future<void> logIn(String name, String pass) async {
    var queryParameters = {
      '_format': 'json',
    };

    var uriLogin = Uri.http(_urlPrepod, '/user/login', queryParameters);

    var response = await apiClient.post(uriLogin,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(
            <String, String>{'name': name, 'pass': pass})); // translate to JSON

    print('status code : ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      // From JSON to dart object
      final body = json.decode(response.body);
      // Get the token
      final ApiToken token = ApiToken(
          csrfToken: body['csrf_token'], logoutToken: body['logout_token']);

      await apiClient.setToken(token);
    } else {
      final body = json.decode(response.body);
      print(body);
      throw Exception('Login failure');
    }
  }

  // -- Utilisation API pour s'inscrire -- //
  Future<void> signUp(
      String username,
      String mail,
      String prenom,
      String nom,
      String pass,
      String ville,
      String phoneNumber,
      String codePostal,
      SignupNotifications notifications) async {
    var queryParameter = {
      '_format': 'json',
    };

    var uriRegister = Uri.http(_urlPrepod, '/user/register', queryParameter);

    var response = await apiClient.post(uriRegister,
        headers: <String, String>{'Content-Type': 'application/json;'},
        body: json.encode(<String, String>{
          'name': username,
          'mail': mail,
          'pass': pass,
          'field_telephone': phoneNumber,
          'field_prenom': prenom,
          'field_nom': nom,
          'field_ville': ville,
        }));

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      // Get the token
      final ApiToken token = ApiToken(
          csrfToken: body['csrf_token'], logoutToken: body['logout_token']);

      await apiClient.setToken(token);
    } else {
      final body = json.decode(response.body);
      print(body);
      throw Exception('Failed to register.');
    }
  }
}
