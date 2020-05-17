import 'package:fresh/fresh.dart';

import 'in_memory_token_storage.dart';

// Get tokens
class ApiToken implements Token{
  final String csrfToken;
  final String logoutToken;

  ApiToken({this.csrfToken,this.logoutToken});
}

// To refresh token
class ApiClient extends FreshClient<ApiToken> {
  ApiClient() : super(InMemoryTokenStorage());

  @override
  Future<ApiToken> refreshToken(ApiToken token, Client httpClient) async {
    print('refreshing token');
    return token;
  }

  @override
  bool shouldRefresh(Response response) {
    return false;
  }

}