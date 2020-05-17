import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:onbricolemobile/models/user/user.dart';
import 'package:onbricolemobile/repositories/user_repository.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {

  final UserRepository _userRepository;
  StreamSubscription _subscription;

  AuthenticationBloc(UserRepository userRepository)
      : assert(userRepository != null),
        _userRepository = userRepository {
    _subscription = _userRepository.authenticationStatus.listen((status) {
      add(AuthenticationStatusChanged(status));
    });
  }

  @override
  AuthenticationState get initialState => AuthenticationUnknown();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event,) async* {
    if (event is AuthenticationStatusChanged) {
      yield await _mapAuthenticationStatusChangedToState(event);
    } else if (event is LoggedOut) {
     // yield _mapLoggedOutToState();
    }
  }

  // Match the current user status
  Future<AuthenticationState> _mapAuthenticationStatusChangedToState(
      AuthenticationStatusChanged event,) async {
    switch (event.authenticationStatus) {
      case UserAuthenticationStatus.signedIn:
        final user = await _userRepository.getUser();
        return AuthenticationAuthenticated(user);
      case UserAuthenticationStatus.signedOut:
        return AuthenticationUnauthenticated();
      case UserAuthenticationStatus.unknown:
      default:
        return AuthenticationUnknown();
    }
  }

  /*
  // When you Sign out
  AuthenticationState _mapLoggedOutToState() {
    _userRepository.signOut();
    return AuthenticationUnauthenticated();
  }
   */


  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }

}