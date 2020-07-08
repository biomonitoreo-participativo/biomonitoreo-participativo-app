import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'observation.dart';
import 'observation_data.dart';
import 'input_observation_quantity.dart';

class ObservationTile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final observation = Provider.of<Observation>(context);
    final observationData = Provider.of<ObservationData>(context);
    final inputObservationQuantity =
        Provider.of<InputObservationQuantity>(context);

    _launchURL(url) async {
      // const url = 'https://flutter.dev';
      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    return ListTile(
      contentPadding: EdgeInsets.only(left: 10.0, right: 5.0),
      onTap: () {
/*        observation.setQuantity(
            observation.getQuantity() + inputObservationQuantity.getQuantity());
        inputObservationQuantity.setQuantity(1);
        observationData.sortObservations();*/
      },
      onLongPress: () {
        _launchURL(observation.taxon.urlSpeciesPage);
      },
      leading: Wrap(
        spacing: 8,
        children: <Widget>[
          CircleAvatar(
            backgroundImage: NetworkImage(observation.taxon.urlImage01),
          ),
          Text(
            observation.quantity > 0 ? '${observation.quantity}' : '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: observation.quantity > 0 ? 16 : 16,
              color: observation.quantity > 0 ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
      title: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: observation.taxon.scientificName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: observation.quantity > 0 ? 16 : 16,
                color: observation.quantity > 0 ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
      subtitle: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: <TextSpan>[
            TextSpan(
              text: observation.taxon.vernacularName,
              style: TextStyle(
                color: observation.quantity > 0 ? Colors.green : Colors.black,
              ),
            ),
          ],
        ),
      ),
      trailing: Wrap(
        spacing: 1,
        children: <Widget>[
          observation.quantity > 0
              ? IconButton(
                  icon: Icon(Icons.remove, color: Colors.green),
                  color: Theme.of(context).accentColor,
                  onPressed: () {
                    observation.setQuantity(observation.getQuantity() - 1);
                    inputObservationQuantity.setQuantity(1);
                    observationData.sortObservations();
                  },
                )
              : Text(''),
          IconButton(
            icon: Icon(
              Icons.add,
              color: observation.quantity > 0 ? Colors.green : Colors.black,
            ),
            color: Theme.of(context).accentColor,
            onPressed: () {
              observation.setQuantity(observation.getQuantity() + 1);
              inputObservationQuantity.setQuantity(1);
              observationData.sortObservations();
            },
          ),
        ],
      ),
    );
  }
}
