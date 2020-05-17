import 'package:fresh/fresh.dart';
import 'package:onbricolemobile/api/api_client.dart';

class InMemoryTokenStorage implements TokenStorage<ApiToken> {
  ApiToken _token;

  @override
  Future<void> delete() async {
    _token = null;
  }

  @override
  Future<ApiToken> read() async {
    return _token;
  }

  @override
  Future<void> write(ApiToken token) async {
    _token = token;
  }
}