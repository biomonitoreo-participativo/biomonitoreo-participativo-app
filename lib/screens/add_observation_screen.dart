import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:biomonitoreoparticipativoapp/models/observation_data.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

/*String newObservationSciName;
int newObservationQty = 1;
String selectedTaxon;

List getSpecies(pattern) {
  List<String> taxa = [
    'Panthera onca',
    'Puma concolor',
    'Leopardus pardalis',
    'Puma yagouaroundi',
    'Leopardus tigrinus',
    'Leopardus wiedii',
    'Pecari tajacu',
    'Mazama temama',
    'Odoicoleus virginianus',
    'Tapirus bairdii',
    'Alouatta palliata',
    'Ateles geoffrogyi',
    'Cebus imitator',
    'Saimiri oerstedii',
    'Dasyprocta punctata',
    'Cuniculus paca',
    'Pharomachrus mocinno',
    'Trogon rufus',
    'Trogon bairdii',
    'Trogon caligatus',
    'Trogon massena',
    'Trogon collaris',
    'Procnias tricarunculata',
    'Myadestes melanops',
    'Tinamus major',
    'Nothocercus bonapartei',
    'Cryturellus soui',
    'Crax rubra',
    'Penelope purpurascens',
    'Ortalis cinereiceps',
    'Chamaepetes unicolor',
    'Atelopus varius',
  ];

  List<String> filteredTaxa = [];

  for (var i = 0; i < taxa.length; i++) {
    if (taxa[i].startsWith(pattern)) {
      filteredTaxa.add(taxa[i]);
    }
  }

  return filteredTaxa;
}

class AddObservationScreen extends StatefulWidget {
  @override
  _AddObservationScreenState createState() => _AddObservationScreenState();
}

class _AddObservationScreenState extends State<AddObservationScreen> {
  final TextEditingController _typeAheadController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff757575),
      child: Container(
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Añadir observación',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 30.0,
                color: Colors.lightBlueAccent,
              ),
            ),
            TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _typeAheadController,
                autofocus: true,
                style: DefaultTextStyle.of(context)
                    .style
                    .copyWith(fontStyle: FontStyle.italic),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
              suggestionsCallback: (pattern) {
                return getSpecies(pattern);
              },
              itemBuilder: (context, suggestion) {
                return ListTile(
                  title: Text(suggestion),
                );
              },
              onSuggestionSelected: (suggestion) {
                newObservationSciName = suggestion;
                this._typeAheadController.text = suggestion;
              },
            ),
            FlatButton(
              child: Text(
                'Añadir',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              color: Colors.lightBlueAccent,
              onPressed: () {
                Provider.of<ObservationData>(context, listen: false)
                    .addObservation(
                  newObservationSciName,
                  newObservationQty,
                );
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}*/
