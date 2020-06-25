import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'observation.dart';
import 'observation_data.dart';
import 'input_observation_quantity.dart';

class ObservationTileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final observation = Provider.of<Observation>(context);

    return ListTile(
      contentPadding: EdgeInsets.only(left: 10.0, right: 5.0),
      onTap: () {},
      leading: Text(
        observation.quantity > 0 ? '${observation.quantity}' : '',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 16,
          color: Colors.black,
        ),
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
                fontSize: 16,
                color: Colors.black,
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
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
