import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/email_sign_in_form_bloc_based.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/email_sign_in_form_change_notifier.dart';
import 'package:biomonitoreoparticipativoapp/app/sign_in/email_sign_in_form_stateful.dart';

class EmailSigInPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Ingreso con correo electrónico'),
        ),
        elevation: 2.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            child: EmailSignInFormChangeNotifier.create(
                context), //EmailSignInFormBlocBased.create(context)
          ),
        ),
      ),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget _buildContent() {
    return Container();
  }
}
