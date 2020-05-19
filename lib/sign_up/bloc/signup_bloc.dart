import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:onbricolemobile/models/user/user.dart';
import 'package:onbricolemobile/repositories/user_repository.dart';

part 'signup_event.dart';

part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {

  final UserRepository _userRepository;

  SignupBloc(UserRepository userRepository)
      : assert(userRepository != null),
        _userRepository = userRepository;

  @override
  SignupState get initialState => SignupState();

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is SignupMailChanged) {
      yield _mapSignupMailChangedToState(event, state);
    } else if (event is SignupMdpChanged) {
      yield _mapPasswordChangedToState(event, state);
    } else if (event is SignupMdpConfirmChanged) {
      yield _mapPasswordConfirmChangedToState(event, state);
    } else if (event is SignupPrenomChanged) {
      yield _mapSignupPrenomChangedToState(event, state);
    } else if (event is SignupNomChanged) {
      yield _mapSignupNomChangedToState(event, state);
    } else if (event is SignupCodePostalChanged) {
      yield _mapCodePostalChangedToState(event, state);
    } else if (event is SignupStepCompleted) {
      yield _mapSignupStepCompletedToState(event, state);
    } else if (event is SignupStepCancelled) {
      yield _mapSignupCancelStepToState(event, state);
    } else if (event is SignupActivateNotifications) {
      yield _mapSignupNotificationsChangedToState(event, state);
    }
  }

  // -- Vérification des textfields -- //


  // Notifications
  SignupState _mapSignupNotificationsChangedToState(
      SignupActivateNotifications event, SignupState state) {
    return state.copyWith(
      notificationsStatus: StepStatus.valid,
      user: state.user.copyWith(notifications: event.activatedNotifications),
    );
  }

  // Mail
  SignupState _mapSignupMailChangedToState(SignupMailChanged event,
      SignupState state,) {
    final validMail = _isMailValid(event.mail);
    return state.copyWith(
      compteStatus: validMail ? StepStatus.valid : StepStatus.invalid,
      user: state.user.copyWith(email: event.mail),
    );
  }

  // Mdp
  SignupState _mapPasswordChangedToState(SignupMdpChanged event,
      SignupState state,) {
    final validMdp = _isPasswordValid(event.mdp);
    return state.copyWith(
      compteStatus: validMdp ? StepStatus.valid : StepStatus.invalid,
      password: event.mdp,
      user: state.user.copyWith(pass: event.mdp),
    );
  }

  SignupState _mapPasswordConfirmChangedToState(SignupMdpConfirmChanged event,
      SignupState state,) {
    final validMdp = _isPasswordValid(event.mdpConfirm);
    return state.copyWith(
      confirmPassword: event.mdpConfirm,
      compteStatus: validMdp ? StepStatus.valid : StepStatus.invalid,
      user: state.user.copyWith(pass: event.mdpConfirm),
    );
  }

  // Prenom
  SignupState _mapSignupPrenomChangedToState(SignupPrenomChanged event,
      SignupState state,) {
    final validPrenom = _areNamesValid(event.prenom);
    return state.copyWith(
      infomationsStatus: validPrenom ? StepStatus.valid : StepStatus.invalid,
      user: state.user.copyWith(prenom: event.prenom),
    );
  }

  // Nom
  SignupState _mapSignupNomChangedToState(SignupNomChanged event,
      SignupState state,) {
    final validNom = _areNamesValid(event.nom);
    return state.copyWith(
      infomationsStatus: validNom ? StepStatus.valid : StepStatus.invalid,
      user: state.user.copyWith(nom: event.nom),
    );
  }

  // Code postal
  SignupState _mapCodePostalChangedToState(SignupCodePostalChanged event,
      SignupState state,) {
    final validCodePostal = _isPostalCodeValid(event.codePostal);
    return state.copyWith(
      infomationsStatus:
      validCodePostal ? StepStatus.valid : StepStatus.invalid,
      user: state.user.copyWith(codePostal: event.codePostal),
    );
  }

  // Do the redirections between the steps and set it to complete
  SignupState _mapSignupStepCompletedToState(SignupStepCompleted event,
      SignupState state) {
    switch (state.step) {
      case SignupStep.compte:
        return state.copyWith(step: SignupStep.informations);
        break;
      case SignupStep.informations:
        return state.copyWith(step: SignupStep.notifications);
        break;
      case SignupStep.notifications:
        return state.copyWith(complete: true);
    // Should never happens
      default:
        return state;
    }
  }

  // In case user press cancel to go back to the previous page
  SignupState _mapSignupCancelStepToState(SignupStepCancelled event,
      SignupState state) {
    switch (state.step) {
      case SignupStep.compte:
        return state.copyWith();
        break;
      case SignupStep.informations:
        return state.copyWith(step: SignupStep.compte);
        break;
      case SignupStep.notifications:
        return state.copyWith(step: SignupStep.informations);
        break;
      default:
        return state;
    }
  }

  //////////////////////////////////////////////////////////////////////////////////////////
  //
  //      Controllers for the differents fields
  //
  // Controller for mail
  bool _isMailValid(String mail) {
    if (mail.isNotEmpty &&
        !RegExp(
            r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
            .hasMatch(mail)) {
      return false;
    }
    return true;
  }

  // Controller for password
  bool _isPasswordValid(String pass) {
    if (pass.isNotEmpty &&
        !RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$')
            .hasMatch(pass)) {
      return false;
    }
    return true;
  }

  // Controller for field first name and last name (no digits)
  bool _areNamesValid(String value) {
    // RegExp test if there is digit in it
    if (value.isNotEmpty &&
        !RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value)) {
      return true;
    }
    return false;
  }

  // Check if postal code is not empty
  bool _isPostalCodeValid(String postalCode) => postalCode.isNotEmpty == true;
}
