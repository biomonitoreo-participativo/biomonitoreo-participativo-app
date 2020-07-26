import 'package:flutter/foundation.dart';

class Taxon with ChangeNotifier {
  final String id;
  final String kingdom;
  final String phylum;
  final String class_;
  final String order;
  final String family;
  final String genus;
  final String specificEpithet;
  final String scientificName;
  final String scientificNameAuthorship;
  final String vernacularName;
  final String taxonRank;
  final String urlSpeciesPage;
  final String urlImage;

  Taxon({
    @required this.id,
    @required this.kingdom,
    this.phylum,
    this.class_,
    this.order,
    this.family,
    this.genus,
    this.specificEpithet,
    @required this.scientificName,
    this.scientificNameAuthorship,
    this.vernacularName,
    @required this.taxonRank,
    this.urlSpeciesPage,
    this.urlImage,
  });
}
