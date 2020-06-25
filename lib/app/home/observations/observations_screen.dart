import 'package:biomonitoreoparticipativoapp/app/home/observations/rounded_button.dart';
import 'package:biomonitoreoparticipativoapp/app/home/observations/summary_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'input_observation_quantity.dart';
import 'observations_list.dart';

enum FilterOptions {
  Observed,
  All,
}

class ObservationsScreen extends StatefulWidget {
  static const String id = 'observations_screen';

  @override
  _ObservationsScreenState createState() => _ObservationsScreenState();
}

class _ObservationsScreenState extends State<ObservationsScreen> {
  final _auth = FirebaseAuth.instance;
  FirebaseUser loggedInUser;

  var _showOnlyObserved = false;
  var _filter = '';
  var _qty = 1;

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
    InputObservationQuantity quantityModel =
        Provider.of<InputObservationQuantity>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          PopupMenuButton(
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.Observed) {
                  _showOnlyObserved = true;
                } else {
                  _showOnlyObserved = false;
                }
              });
            },
            icon: Icon(Icons.more_vert),
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Solo especies observadas'),
                value: FilterOptions.Observed,
              ),
              PopupMenuItem(
                child: Text('Todas'),
                value: FilterOptions.All,
              ),
            ],
          ),
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //_auth.signOut();
              //Navigator.pop(context);
              // Navigator.pushNamed(context, SummaryScreen.id);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SummaryScreen()),
              );
            },
          ),
        ],
        title: Text('Observaciones'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                top: 30.0, left: 30.0, right: 30.0, bottom: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(5.0),
                    hintText: 'nombre científico/nombre común',
                  ),
                  onChanged: (string) {
                    String pattern;
                    int indexOfFirstSpace = string.indexOf(' ');
                    print('Índice del primer espacio: ' +
                        indexOfFirstSpace.toString());

                    if (indexOfFirstSpace != -1) {
                      _qty = int.parse(string.substring(0, indexOfFirstSpace));
                      quantityModel.setQuantity(_qty);
                      pattern = string.substring(indexOfFirstSpace + 1);
                    } else {
                      pattern = string;
                    }

                    print('qty: $_qty pattern: $pattern');

                    setState(
                      () {
                        setState(() {
                          _filter = pattern;
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white30,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ObservationsList(_showOnlyObserved, _filter),
            ),
          ),
          Container(
            // alignment: Alignment(0.0, 0.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 100.0),
              child: RoundedButton(
                title: 'Resumen',
                colour: Colors.blue,
                onPressed: () {
                  Navigator.pushNamed(context, SummaryScreen.id);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
