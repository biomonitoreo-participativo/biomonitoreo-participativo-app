import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/email_sign_in_model.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/validators.dart';
import 'package:biomonitoreoparticipativoapp/services/auth.dart';

class EmailSignInChangeModel with EmailAndPasswordsValidators, ChangeNotifier {
  final AuthBase auth;
  String email;
  String password;
  String passwordConfirmation;
  EmailSignInFormType formType;
  bool isLoading;
  bool submitted;

  EmailSignInChangeModel({
    @required this.auth,
    this.email = '',
    this.password = '',
    this.passwordConfirmation = '',
    this.formType = EmailSignInFormType.signIn,
    this.isLoading = false,
    this.submitted = false,
  });

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);

    try {
      if (this.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(this.email, this.password);
      } else {
        await auth.createUserWithEmailAndPassword(this.email, this.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  String get primaryButtonText {
    return formType == EmailSignInFormType.signIn ? 'Ingresar' : 'Registrarse';
  }

  String get secondaryButtonText {
    return formType == EmailSignInFormType.signIn
        ? 'Si no tiene un usuario, regístrese aquí'
        : 'Si ya tiene un usuario, ingrese aquí';
  }

  bool get canSubmit {
    if (formType == EmailSignInFormType.signIn) {
      return emailValidator.isValid(email) &&
          passwordValidator.isValid(password) &&
          !isLoading;
    } else {
      return emailValidator.isValid(email) &&
          passwordValidator.isValid(password) &&
          passwordConfirmationValidator.areEqual(
              password, passwordConfirmation) &&
          !isLoading;
    }
  }

  String get emailErrorText {
    bool showErrorText = submitted && !emailValidator.isValid(email);
    return showErrorText ? invalidEmailErrorText : null;
  }

  String get passwordErrorText {
    bool showErrorText = submitted && !passwordValidator.isValid(password);
    return showErrorText ? invalidPasswordErrorText : null;
  }

  String get passwordConfirmationErrorText {
    bool showErrorText = submitted &&
        !passwordConfirmationValidator.areEqual(password, passwordConfirmation);
    return showErrorText ? invalidPasswordConfirmationErrorText : null;
  }

  void toggleFormType() {
    final formType = this.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      passwordConfirmation: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);
  void updatePassword(String password) => updateWith(password: password);
  void updatePasswordConfirmation(String passwordConfirmation) =>
      updateWith(passwordConfirmation: passwordConfirmation);

  void updateWith({
    String email,
    String password,
    String passwordConfirmation,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    this.email = email ?? this.email;
    this.password = password ?? this.password;
    this.passwordConfirmation =
        passwordConfirmation ?? this.passwordConfirmation;
    this.formType = formType ?? this.formType;
    this.isLoading = isLoading ?? this.isLoading;
    this.submitted = submitted ?? this.submitted;
    notifyListeners();
  }
}
