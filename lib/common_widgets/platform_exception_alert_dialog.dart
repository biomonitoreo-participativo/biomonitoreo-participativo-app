import 'package:meta/meta.dart';
import 'package:flutter/services.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_alert_dialog.dart';

class PlatformExceptionAlertDialog extends PlatformAlertDialog {
  PlatformExceptionAlertDialog({
    @required String title,
    @required PlatformException exception,
  }) : super(
          title: title,
          content: _message(exception),
          defaultActionText: 'OK',
        );

  static String _message(PlatformException exception) {
    print('ExceptionCode: ${exception.code}');
    print('ExceptionMessage: ${exception.message}');
    if (exception.message ==
        'PERMISSION_DENIED: Missing or insufficient permissions.') {
      if (exception.code == 'Error performing setData') {
        return 'PERMISO DENEGADO: Permisos faltantes o insuficientes.';
      }
    }
    return _errors[exception.code] ?? exception.message;
  }

  static Map<String, String> _errors = {
    /// createUserWithEmailAndPassword
    ///  * `ERROR_WEAK_PASSWORD` - If the password is not strong enough.
    ///  * `ERROR_INVALID_EMAIL` - If the email address is malformed.
    ///  * `ERROR_EMAIL_ALREADY_IN_USE` - If the email is already in use by a different account.
    /// signInWithEmailAndPassword
    'ERROR_INVALID_EMAIL': 'La dirección de correo electrónico es inválida.',
    'ERROR_WRONG_PASSWORD': 'La clave es inválida.',
    'ERROR_USER_NOT_FOUND':
        'No existe un usuario registrado con la dirección de correo electrónico especificada. El usuario pudo hacer sido borrado.',

    ///  * `ERROR_USER_DISABLED` - If the user has been disabled (for example, in the Firebase console)
    ///  * `ERROR_TOO_MANY_REQUESTS` - If there was too many attempts to sign in as this user.
    ///  * `ERROR_OPERATION_NOT_ALLOWED` - Indicates that Email & Password accounts are not enabled.
  };
}
