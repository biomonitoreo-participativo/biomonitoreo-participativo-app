import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'taxon.dart';

class TaxonData extends ChangeNotifier {
  List<Taxon> _taxa = [
    Taxon(
      id: '000001',
      scientificName: 'Panthera onca',
      scientificNameAuthorship: '(Linnaeus, 1758)',
      vernacularName: 'jaguar',
      taxonRank: 'species',
      urlSpeciesPage: '',
      urlImage01: '',
    ),
    Taxon(
      id: '000002',
      scientificName: 'Puma concolor',
      scientificNameAuthorship: '(Linnaeus, 1771)',
      vernacularName: 'puma',
      taxonRank: 'species',
      urlSpeciesPage: '',
      urlImage01: '',
    ),
    Taxon(
      id: '000003',
      scientificName: 'Leopardus pardalis',
      scientificNameAuthorship: '(Linnaeus, 1758)',
      vernacularName: 'ocelote, manigordo',
      taxonRank: 'species',
      urlSpeciesPage: '',
      urlImage01: '',
    ),
    Taxon(
      id: '000004',
      scientificName: 'Puma yagouaroundi',
      scientificNameAuthorship: '(É.Geoffroy Saint-Hilaire, 1803)',
      vernacularName: 'yaguarundi, león breñero',
      taxonRank: 'species',
      urlSpeciesPage: '',
      urlImage01: '',
    ),
    Taxon(
      id: '000005',
      scientificName: 'Leopardus tigrinus',
      scientificNameAuthorship: '(É.Geoffroy Saint-Hilaire, 1803)',
      vernacularName: 'oncilla, caucel',
      taxonRank: 'species',
      urlSpeciesPage: '',
      urlImage01: '',
    ),
    Taxon(
      id: '000006',
      scientificName: 'Leopardus wiedii',
      scientificNameAuthorship: '(Schinz, 1821)',
      vernacularName: 'tigrillo',
      taxonRank: 'species',
    ),
/*    Taxon(
      scientificName: 'Pecari tajacu',
      vernacularName: 'pecarí de collar',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Mazama temama',
      vernacularName: 'cabro de monte',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Odoicoleus virginianus',
      vernacularName: 'venado cola blanca',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Tapirus bairdii',
      vernacularName: 'danta',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Alouatta palliata',
      vernacularName: 'mono congo',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Ateles geoffrogyi',
      vernacularName: 'mono araña',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Cebus imitator',
      vernacularName: 'mono cara blanca',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Saimiri oerstedii',
      vernacularName: 'mono tití',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Dasyprocta punctata',
      vernacularName: 'guatusa',
      taxonRank: 'species',
    ),
    Taxon(
      scientificName: 'Cuniculus paca',
      vernacularName: 'tepezcuintle',
      taxonRank: 'species',
    ),*/
  ];

  UnmodifiableListView<Taxon> get taxa {
    return UnmodifiableListView(_taxa);
  }

  int get taxaCount {
    return _taxa.length;
  }
}
