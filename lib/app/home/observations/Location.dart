import 'package:flutter/foundation.dart';

class Location {
  @required
  final String id;
  @required
  final String name;
  @required
  final String description;
  @required
  final double decimalLongitude;
  @required
  final double decimalLatitude;

  Location({
    this.id,
    this.name,
    this.description,
    this.decimalLongitude,
    this.decimalLatitude,
  });
}
