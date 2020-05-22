import 'package:biomonitoreoparticipativoapp/models/provider_datetime.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:biomonitoreoparticipativoapp/widgets/rounded_button.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'observations_screen.dart';

class SelectDateTimeScreen extends StatefulWidget {
  static const String id = 'select_datetime_screen';

  @override
  _SelectDateTimeScreenState createState() => _SelectDateTimeScreenState();
}

class _SelectDateTimeScreenState extends State<SelectDateTimeScreen> {
  // String _date = "Fecha no seleccionada";
  // String _time = "Hora no seleccionada";

  DateTime now;

  String _date = "Fecha no seleccionada";
  String _time = "Hora no seleccionada";

  @override
  void initState() {
    super.initState();

    now = new DateTime.now();

    var dateFormatter = new DateFormat('yyyy-MM-dd');
    _date = dateFormatter.format(now);

    var timeFormatter = new DateFormat('HH:mm:ss');
    _time = timeFormatter.format(now);
  }

  @override
  Widget build(BuildContext context) {
    ProviderDateTime providerDateTime = Provider.of<ProviderDateTime>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Selección de fecha y hora'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showDatePicker(
                  context,
                  locale: LocaleType.es,
                  theme: DatePickerTheme(
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true,
                  currentTime: DateTime.now(),
                  minTime: DateTime(2000, 1, 1),
                  maxTime: DateTime(2022, 12, 31),
                  onConfirm: (date) {
                    print('confirm $date');
                    _date = '${date.year} - ${date.month} - ${date.day}';
                    setState(() {});
                  },
                );
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.date_range,
                                size: 18.0,
                                color: Colors.blue,
                              ),
                              Text(
                                " $_date",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Seleccionar",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0)),
              elevation: 4.0,
              onPressed: () {
                DatePicker.showTimePicker(
                  context,
                  locale: LocaleType.es,
                  theme: DatePickerTheme(
                    containerHeight: 210.0,
                  ),
                  showTitleActions: true,
                  onConfirm: (time) {
                    print('confirm $time');
                    _time = '${time.hour} : ${time.minute} : ${time.second}';
                    setState(() {});
                  },
                  currentTime: DateTime.now(),
                );
                setState(() {});
              },
              child: Container(
                alignment: Alignment.center,
                height: 50.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.access_time,
                                size: 18.0,
                                color: Colors.blue,
                              ),
                              Text(
                                " $_time",
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18.0),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Text(
                      "  Seleccionar",
                      style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                  ],
                ),
              ),
              color: Colors.white,
            ),
            SizedBox(
              height: 80.0,
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: RoundedButton(
                  title: 'Ingreso de observaciones',
                  colour: Colors.blue,
                  onPressed: () {
                    providerDateTime.setLabel('$_date-$_time');
                    Navigator.pushNamed(context, ObservationsScreen.id);
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
