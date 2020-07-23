abstract class StringValidator {
  bool isValid(String value);
  bool areEqual(String value1, String value2);
}

class CommonStringValidator implements StringValidator {
  @override
  bool isValid(String value) {
    return value.isNotEmpty;
  }

  @override
  bool areEqual(String value1, String value2) {
    return value1 == value2;
  }
}

class EmailAndPasswordsValidators {
  final StringValidator emailValidator = CommonStringValidator();
  final StringValidator passwordValidator = CommonStringValidator();
  final StringValidator passwordConfirmationValidator = CommonStringValidator();

  final String invalidEmailErrorText =
      'La dirección de correo no puede estar vacía';
  final String invalidPasswordErrorText = 'La clave no puede estar vacía';
  final String invalidPasswordConfirmationErrorText =
      'Las claves deben coincidir';
}
