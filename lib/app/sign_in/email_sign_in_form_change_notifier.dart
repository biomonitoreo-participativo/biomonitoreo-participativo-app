import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/email_sign_in_bloc.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/form_submit_button.dart';
import 'package:biomonitoreoparticipativoapp/common_widgets/platform_exception_alert_dialog.dart';
import 'package:biomonitoreoparticipativoapp/services/auth.dart';
import 'package:flutter/services.dart';
import 'email_sign_in_change_model.dart';
import 'email_sign_in_model.dart';
import 'package:biomonitoreoparticipativoapp/app/home/models/group.dart';

class EmailSignInFormChangeNotifier extends StatefulWidget {
  final EmailSignInChangeModel model;
  EmailSignInFormChangeNotifier({@required this.model});

  static Widget create(BuildContext context) {
    final AuthBase auth = Provider.of<AuthBase>(context);
    return ChangeNotifierProvider<EmailSignInChangeModel>(
      builder: (context) => EmailSignInChangeModel(auth: auth),
      child: Consumer<EmailSignInChangeModel>(
          builder: (context, model, _) =>
              EmailSignInFormChangeNotifier(model: model)),
    );
  }

  @override
  _EmailSignInFormChangeNotifierState createState() =>
      _EmailSignInFormChangeNotifierState();
}

class _EmailSignInFormChangeNotifierState
    extends State<EmailSignInFormChangeNotifier> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmationController =
      TextEditingController();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _passwordConfirmationFocusNode = FocusNode();

  EmailSignInChangeModel get model => widget.model;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmationController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _passwordConfirmationFocusNode.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    try {
      await model.submit();
      Navigator.of(context).pop();
    } on PlatformException catch (e) {
      PlatformExceptionAlertDialog(
        title: 'Error en el ingreso',
        exception: e,
      ).show(context);
    }
  }

  void _emailEditingComplete() {
    final newFocus = model.emailValidator.isValid(model.email)
        ? _passwordFocusNode
        : _emailFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordEditingComplete() {
    var newFocus;
    if (model.formType == EmailSignInFormType.signIn) {
      newFocus = model.passwordValidator.isValid(model.password)
          ? _emailFocusNode
          : _passwordFocusNode;
    } else {
      newFocus = model.passwordValidator.isValid(model.password)
          ? _passwordConfirmationFocusNode
          : _passwordFocusNode;
    }
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _passwordConfirmationEditingComplete() {
    final newFocus =
        model.passwordConfirmationValidator.isValid(model.passwordConfirmation)
            ? _emailFocusNode
            : _passwordConfirmationFocusNode;
    FocusScope.of(context).requestFocus(newFocus);
  }

  void _toggleFormType() {
    model.toggleFormType();
    _emailController.clear();
    _passwordController.clear();
    _passwordConfirmationController.clear();
  }

  List<Widget> _buildChildren() {
    return [
      _buildEmailTextField(),
      SizedBox(height: 8.0),
      _buildPasswordTextField(),
      SizedBox(height: 8.0),
      if (model.formType == EmailSignInFormType.register)
        _buildPasswordConfirmationTextField(),
      SizedBox(height: 8.0),
      _buildGroupDropdownButton(),
      SizedBox(height: 8.0),
      FormSubmitButton(
        text: model.primaryButtonText,
        onPressed: model.canSubmit ? _submit : null,
      ),
      FlatButton(
        child: Text(model.secondaryButtonText),
        onPressed: !model.isLoading ? _toggleFormType : null,
      ),
    ];
  }

  TextField _buildEmailTextField() {
    return TextField(
      controller: _emailController,
      focusNode: _emailFocusNode,
      decoration: InputDecoration(
        labelText: 'Dirección de correo',
        hintText: 'usuario@gmail.com',
        errorText: model.emailErrorText,
        enabled: model.isLoading == false,
      ),
      autocorrect: false,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      onChanged: model.updateEmail,
      onEditingComplete: () => _emailEditingComplete(),
    );
  }

  TextField _buildPasswordTextField() {
    return TextField(
      controller: _passwordController,
      focusNode: _passwordFocusNode,
      decoration: InputDecoration(
        labelText: 'Clave (6 caracteres como mínimo)',
        errorText: model.passwordErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.next,
      onChanged: model.updatePassword,
      onEditingComplete: () => _passwordEditingComplete(),
    );
  }

  String dropdownValue = 'ACLAP';
  DropdownButton _buildGroupDropdownButton() {
    Group group = Provider.of<Group>(context);

    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String newValue) {
        setState(() {
          dropdownValue = newValue;
        });
        group.setGroup(newValue);
      },
      items: <String>[
        'ACLAP',
        'ACOSA',
        'ACAHN',
        'ACAT',
        'ACC',
        'ACG',
        'ACLAC',
        'ACMC',
        'ACOPAC',
        'ACT',
        'ACTo'
      ].map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  TextField _buildPasswordConfirmationTextField() {
    return TextField(
      controller: _passwordConfirmationController,
      focusNode: _passwordConfirmationFocusNode,
      decoration: InputDecoration(
        labelText: 'Confirmación de la clave',
        errorText: model.passwordConfirmationErrorText,
        enabled: model.isLoading == false,
      ),
      obscureText: true,
      textInputAction: TextInputAction.next,
      onChanged: model.updatePasswordConfirmation,
      onEditingComplete: () => _passwordConfirmationEditingComplete(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: _buildChildren(),
      ),
    );
  }
}
