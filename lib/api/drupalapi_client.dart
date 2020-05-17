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

    var uri = Uri.http(_urlPrepod, '/user/login', queryParameters);

    var response = await apiClient.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8'
        },
        body: json.encode(<String, String>{
          'name': name,
          'pass': pass
        })); // translate to JSON

    print('status code : ' + response.statusCode.toString());

    if (response.statusCode == 200) {
      // From JSON to dart object
      final body = json.decode(response.body);
      // Get the token
      final ApiToken token = ApiToken(csrfToken: body['csrf_token'], logoutToken: body['logout_token']);

      await apiClient.setToken(token);
    } else {
      throw Exception('Login failure');
    }
  }

  // -- Utilisation API pour s'inscrire -- //
  Future<void> signUp(String prenom, String nom, String codePostal, String pass, SignupNotifications notifications){

    return null;
  }

}
