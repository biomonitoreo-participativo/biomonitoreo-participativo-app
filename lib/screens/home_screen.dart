import 'package:flutter/material.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'registration_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Biomonitoreo participativo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(vertical: 40.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Image.asset('images/logo-paisajes-productivos.jpg'),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: Text(
                  'Biomonitoreo participativo\nEspecies indicadoras',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: RoundedButton(
                  title: 'Ingreso',
                  colour: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 40.0),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: RoundedButton(
                  title: 'Registro',
                  colour: Colors.blue,
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.id);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
