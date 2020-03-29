import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ObservationsScreen extends StatefulWidget {
  static const String id = 'observations_screen';

  @override
  _ObservationsScreenState createState() => _ObservationsScreenState();
}

class _ObservationsScreenState extends State<ObservationsScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
        print(loggedInUser.email);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
