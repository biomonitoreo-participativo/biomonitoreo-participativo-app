import 'package:biomonitoreoparticipativoapp/models/provider_observer.dart';
import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'package:biomonitoreoparticipativoapp/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'select_location_screen.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email;
  String password;

  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    ProviderObserver providerObserver = Provider.of<ProviderObserver>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Registro de usuario'),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
//            Container(
//              height: 200.0,
//              child: Image.asset('images/logo-paisajes-productivos.jpg'),
//            ),
//            SizedBox(
//              height: 48.0,
//            ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Correo electrónico del nuevo usuario'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                textAlign: TextAlign.center,
                obscureText: true,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Clave'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Registrar usuario',
                colour: Colors.blue,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    providerObserver.setName(email);

                    final newUser = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (newUser != null) {
                      Navigator.pushNamed(context, SelectLocationScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
