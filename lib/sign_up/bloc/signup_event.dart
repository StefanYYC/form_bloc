part of 'signup_bloc.dart';

@immutable
abstract class SignupEvent{
  const SignupEvent();
}

// Toutes les textfields du signup vont se trouver ici
// pour pouvoir ensuite les tester

// Adresse mail
class SignupMailChanged extends SignupEvent{
  final String mail;

  const SignupMailChanged(this.mail);
}

// Username
class SignupUsernameChanged extends SignupEvent{
  final String username;

  const SignupUsernameChanged(this.username);
}

// Mot de passe 1
class SignupMdpChanged extends SignupEvent{
  final String mdp;

  const SignupMdpChanged(this.mdp);
}
// Mot de passe confirm
class SignupMdpConfirmChanged extends SignupEvent{
  final String mdpConfirm;

  const SignupMdpConfirmChanged(this.mdpConfirm);
}

// Prénom
class SignupPrenomChanged extends SignupEvent{
  final String prenom;

  const SignupPrenomChanged(this.prenom);
}

// Nom
class SignupNomChanged extends SignupEvent{
  final String nom;

  const SignupNomChanged(this.nom);
}

// Ville
class SignupVilleChanged extends SignupEvent{
  final String ville;

  const SignupVilleChanged(this.ville);

}
// Phone number
class SignupPhoneNumberChanged extends SignupEvent{
  final String phoneNumber;

  const SignupPhoneNumberChanged(this.phoneNumber);
}

// Code postal
class SignupCodePostalChanged extends SignupEvent{
  final String codePostal;

  const SignupCodePostalChanged(this.codePostal);
}

// Choose to get notifications or not
class SignupActivateNotifications extends SignupEvent{
  final SignupNotifications activatedNotifications;

  const SignupActivateNotifications(this.activatedNotifications);
}

// When the sign up form is being submitted
class SignupStepCompleted extends SignupEvent{}

// To come back during the sign up process
class SignupStepCancelled extends SignupEvent{}

// When we submit the form
class SignupStepSubmitted extends SignupEvent{}