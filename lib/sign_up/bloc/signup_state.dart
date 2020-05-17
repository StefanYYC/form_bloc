part of 'signup_bloc.dart';

enum StepStatus { empty, valid, invalid }
enum SignupStep { compte, informations, notifications }
enum SignupNotifications { empty, on, off}

@immutable
class SignupState {
  final StepStatus emailStatus;
  final StepStatus pwdStatus;
  final StepStatus pwdConfirmStatus;
  final User user;
  final SignupStep step;
  final StepStatus compteStatus;
  final StepStatus informationsStatus;
  final StepStatus notificationsStatus;
  final bool complete;
  final String password;
  final String confirmPassword;

  const SignupState({
    this.user = const User(),
    this.step = SignupStep.compte,
    this.compteStatus = StepStatus.empty,
    this.informationsStatus = StepStatus.empty,
    this.notificationsStatus = StepStatus.empty,
    this.emailStatus = StepStatus.empty,
    this.pwdConfirmStatus = StepStatus.empty,
    this.pwdStatus = StepStatus.empty,
    this.complete = false,
    this.password = "",
    this.confirmPassword = "",
  });

  bool get passwordMatching => password == confirmPassword;

  SignupState copyWith({
    User user,
    SignupStep step,
    StepStatus compteStatus,
    StepStatus emailStatus,
    StepStatus pwdStatus,
    StepStatus pwdConfirmStatus,
    StepStatus infomationsStatus,
    StepStatus notificationsStatus,
    bool complete,
    String password,
    String confirmPassword,
  }) {
    return SignupState(
      user: user ?? this.user,
      step: step ?? this.step,
      compteStatus: compteStatus ?? this.compteStatus,
      informationsStatus: infomationsStatus ?? this.informationsStatus,
      notificationsStatus: notificationsStatus ?? this.notificationsStatus,
      complete: complete ?? this.complete,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      emailStatus: emailStatus ?? this.emailStatus,
      pwdConfirmStatus: pwdConfirmStatus ?? this.pwdConfirmStatus,
      pwdStatus: pwdStatus ?? this.pwdStatus,
    );
  }
}
