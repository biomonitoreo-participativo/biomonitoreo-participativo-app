import 'package:biomonitoreoparticipativoapp/models/provider_observer.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:biomonitoreoparticipativoapp/constants.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'package:provider/provider.dart';
import 'select_location_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
        title: Text('Ingreso a la aplicación'),
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
//              child: Image.asset('images/logo.png'),
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
                    hintText: 'Correo electrónico del usuario'),
              ),
              SizedBox(
                height: 8.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(hintText: 'Clave'),
              ),
              SizedBox(
                height: 24.0,
              ),
              RoundedButton(
                title: 'Ingresar con correo eletrónico y clave',
                colour: Colors.blue,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    providerObserver.setName(email);

                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.pushNamed(context, SelectLocationScreen.id);
                    }
                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    print(e);
                  }
                },
              ),
              RoundedButton(
                title: 'Ingresar de manera anónima',
                colour: Colors.blue,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    providerObserver.setName(email);

                    final user = await _auth.signInAnonymously();
                    if (user != null) {
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
