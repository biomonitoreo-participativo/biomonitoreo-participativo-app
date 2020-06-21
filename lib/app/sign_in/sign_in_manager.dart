import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:biomonitoreoparticipativoapp/services/auth.dart';

class SignInManager {
  final AuthBase auth;
  final ValueNotifier<bool> isLoading;

  SignInManager({@required this.auth, @required this.isLoading});

  // isLoading

  // auth
  Future<User> _signIn(Future<User> Function() sigInMethod) async {
    try {
      isLoading.value = true;
      return await sigInMethod();
    } catch (e) {
      isLoading.value = false;
      rethrow;
    }
  }

  Future<User> signInAnonymously() async =>
      await _signIn(auth.signInAnonymously);
  Future<User> signInWithGoogle() async => await _signIn(auth.signInWithGoogle);
}
