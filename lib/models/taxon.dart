import 'package:flutter/foundation.dart';

class Taxon {
  @required
  final String id;
  @required
  final String scientificName;
  @required
  final scientificNameAuthorship;
  @required
  final String vernacularName;
  @required
  final String taxonRank;

  Taxon({
    this.id,
    this.scientificName,
    this.scientificNameAuthorship,
    this.vernacularName,
    this.taxonRank,
  });
}
