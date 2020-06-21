import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/email_sign_in_model.dart';
import 'package:biomonitoreoparticipativoapp/services/auth.dart';

class EmailSignInBloc {
  final AuthBase auth;

  EmailSignInBloc({@required this.auth});

  // Model
  final StreamController<EmailSignInModel> _modelController =
      StreamController();
  Stream<EmailSignInModel> get modelStream => _modelController.stream;
  EmailSignInModel _model = EmailSignInModel();

  void updateWith({
    String email,
    String password,
    EmailSignInFormType formType,
    bool isLoading,
    bool submitted,
  }) {
    // update model
    _model = _model.copyWith(
      email: email,
      password: password,
      formType: formType,
      isLoading: isLoading,
      submitted: submitted,
    );

    // add updated model to model controller
    _modelController.add(_model);
  }

  void toggleFormType() {
    final formType = _model.formType == EmailSignInFormType.signIn
        ? EmailSignInFormType.register
        : EmailSignInFormType.signIn;

    updateWith(
      email: '',
      password: '',
      formType: formType,
      isLoading: false,
      submitted: false,
    );
  }

  void updateEmail(String email) => updateWith(email: email);

  void updatePassword(String password) => updateWith(password: password);

  Future<void> submit() async {
    updateWith(isLoading: true, submitted: true);

    try {
      if (_model.formType == EmailSignInFormType.signIn) {
        await auth.signInWithEmailAndPassword(_model.email, _model.password);
      } else {
        await auth.createUserWithEmailAndPassword(
            _model.email, _model.password);
      }
    } catch (e) {
      updateWith(isLoading: false);
      rethrow;
    }
  }

  void dispose() {
    _modelController.close();
  }
}
