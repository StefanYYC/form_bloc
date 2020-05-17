import 'package:flutter/material.dart';
import 'package:onbricolemobile/api/drupalapi_client.dart';
import 'package:onbricolemobile/repositories/user_repository.dart';
import 'app/app.dart';

void main() {
  final drupalapiClient = DrupalApiClient();
  final userRepository = UserRepository(drupalapiClient);

  runApp(App(
    userRepository: userRepository,
  ));
}