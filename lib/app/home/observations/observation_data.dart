import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'observation.dart';
import '../models/taxon.dart';

class ObservationData with ChangeNotifier {
  List<Observation> _observations = [
    Observation(
      id: '000000001',
      taxon: Taxon(
        id: '000001',
        scientificName: 'Panthera onca',
        scientificNameAuthorship: '(Linnaeus, 1758)',
        vernacularName: 'Jaguar',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Panthera_onca',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F64711000%2Foriginal.jpg%3F1585324584',
      ),
    ),
    Observation(
      id: '000000002',
      taxon: Taxon(
        id: '000002',
        scientificName: 'Puma concolor',
        scientificNameAuthorship: '(Linnaeus, 1771)',
        vernacularName: 'Puma',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Puma_concolor',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F63212145%2Foriginal.jpg%3F1583882817',
      ),
    ),
    Observation(
      id: '000000003',
      taxon: Taxon(
        id: '000003',
        scientificName: 'Leopardus pardalis',
        scientificNameAuthorship: '(Linnaeus, 1758)',
        vernacularName: 'Ocelote, manigordo',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Leopardus_pardalis',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F34789556%2Foriginal.jpg%3F1555244136',
      ),
    ),
    Observation(
      id: '000000004',
      taxon: Taxon(
        id: '000004',
        scientificName: 'Puma yagouaroundi',
        scientificNameAuthorship: '',
        vernacularName: 'Yaguarundi, león breñero',
        taxonRank: 'species',
        urlSpeciesPage:
            'https://es.wikipedia.org/wiki/Herpailurus_yagouaroundi',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F68117291%2Foriginal.jpg%3F1587593109',
      ),
    ),
    Observation(
      id: '000000005',
      taxon: Taxon(
        id: '000005',
        scientificName: 'Leopardus tigrinus',
        scientificNameAuthorship: '',
        vernacularName: 'Oncilla, caucel',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Leopardus_tigrinus',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F47937315%2Foriginal.jpeg%3F1565606591',
      ),
    ),
    Observation(
      id: '000000006',
      taxon: Taxon(
        id: '000006',
        scientificName: 'Leopardus wiedii',
        scientificNameAuthorship: '',
        vernacularName: 'Tigrillo',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Leopardus_wiedii',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F31429483%2Foriginal.jpeg%3F1550191898',
      ),
    ),
    Observation(
      id: '000000007',
      taxon: Taxon(
        id: '000007',
        scientificName: 'Pecari tajacu',
        scientificNameAuthorship: '',
        vernacularName: 'Saíno, pecarí de collar',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Pecari_tajacu',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F58955913%2Foriginal.jpg%3F1578016416',
      ),
    ),
    Observation(
      id: '000000008',
      taxon: Taxon(
        id: '000008',
        scientificName: 'Mazama temama',
        scientificNameAuthorship: '',
        vernacularName: 'Cabro de monte',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Mazama_temama',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F61813810%2Foriginal.jpeg%3F1582166980',
      ),
    ),
    Observation(
      id: '000000009',
      taxon: Taxon(
        id: '000009',
        scientificName: 'Odocoileus virginianus',
        scientificNameAuthorship: '',
        vernacularName: 'Venado cola blanca',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Odocoileus_virginianus',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F58894262%2Foriginal.jpg%3F1577928114',
      ),
    ),
    Observation(
      id: '000000010',
      taxon: Taxon(
        id: '000010',
        scientificName: 'Tapirus bairdii',
        scientificNameAuthorship: '',
        vernacularName: 'Danta',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Tapirus_bairdii',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F44830400%2Foriginal.jpeg%3F1563043028',
      ),
    ),
    Observation(
      id: '000000011',
      taxon: Taxon(
        id: '000011',
        scientificName: 'Alouatta palliata',
        scientificNameAuthorship: '',
        vernacularName: 'Mono congo',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Alouatta_palliata',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F60523695%2Foriginal.jpeg%3F1580359578',
      ),
    ),
    Observation(
      id: '000000012',
      taxon: Taxon(
        id: '000012',
        scientificName: 'Ateles geoffroyi',
        scientificNameAuthorship: '',
        vernacularName: 'Mono araña',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Ateles_geoffroyi',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F60166181%2Foriginal.jpg%3F1579843415',
      ),
    ),
    Observation(
      id: '000000013',
      taxon: Taxon(
        id: '000013',
        scientificName: 'Cebus imitator',
        scientificNameAuthorship: '',
        vernacularName: 'Mono cara blanca',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Cebus_capucinus',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F59897225%2Foriginal.jpg%3F1579441981',
      ),
    ),
    Observation(
      id: '000000014',
      taxon: Taxon(
        id: '000014',
        scientificName: 'Saimiri oerstedii',
        scientificNameAuthorship: '',
        vernacularName: 'Mono tití',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Saimiri_oerstedii',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F68525666%2Foriginal.jpeg%3F1587761459',
      ),
    ),
    Observation(
      id: '000000015',
      taxon: Taxon(
        id: '000015',
        scientificName: 'Dasyprocta punctata',
        scientificNameAuthorship: '',
        vernacularName: 'Cherenga, guatusa',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Dasyprocta_punctata',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F59785668%2Foriginal.jpg%3F1579273133',
      ),
    ),
    Observation(
      id: '000000016',
      taxon: Taxon(
        id: '000016',
        scientificName: 'Cuniculus paca',
        scientificNameAuthorship: '',
        vernacularName: 'Tepezcuintle',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Cuniculus_paca',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F13451022%2Foriginal.jpg%3F1518377789',
      ),
    ),
    Observation(
      id: '000000017',
      taxon: Taxon(
        id: '000017',
        scientificName: 'Pharomachrus mocinno',
        scientificNameAuthorship: '',
        vernacularName: 'Quetzal',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Pharomachrus_mocinno',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F63369148%2Foriginal.jpeg%3F1584069503',
      ),
    ),
    Observation(
      id: '000000018',
      taxon: Taxon(
        id: '000018',
        scientificName: 'Trogon rufus',
        scientificNameAuthorship: '',
        vernacularName: 'Trogón cabeciverde',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Trogon_rufus',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F59930517%2Foriginal.jpg%3F1579479742',
      ),
    ),
    Observation(
      id: '000000019',
      taxon: Taxon(
        id: '000019',
        scientificName: 'Trogon bairdii',
        scientificNameAuthorship: '',
        vernacularName: 'Trogón vientribermejo',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Trogon_bairdii',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F32168215%2Foriginal.jpg%3F1551451811',
      ),
    ),
    Observation(
      id: '000000020',
      taxon: Taxon(
        id: '000020',
        scientificName: 'Trogon caligatus',
        scientificNameAuthorship: '',
        vernacularName: 'Trogón cabecimorado',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Trogon_caligatus',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F60401052%2Foriginal.jpg%3F1580165340',
      ),
    ),
    Observation(
      id: '000000021',
      taxon: Taxon(
        id: '000021',
        scientificName: 'Trogon massena',
        scientificNameAuthorship: '',
        vernacularName: 'Trogón coliplomizo',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Trogon_massena',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F30868699%2Foriginal.jpg%3F1548983795',
      ),
    ),
    Observation(
      id: '000000022',
      taxon: Taxon(
        id: '000022',
        scientificName: 'Trogon collaris',
        scientificNameAuthorship: '',
        vernacularName: 'Trogón collarejo',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Trogon_collaris',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F59834192%2Foriginal.jpg%3F1579355667',
      ),
    ),
    Observation(
      id: '000000023',
      taxon: Taxon(
        id: '000023',
        scientificName: 'Procnias tricarunculata',
        scientificNameAuthorship: '',
        vernacularName: 'Pájaro campana',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Panthera_onca',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F64711000%2Foriginal.jpg%3F1585324584',
      ),
    ),
    Observation(
      id: '000000024',
      taxon: Taxon(
        id: '000024',
        scientificName: 'Myadestes melanops',
        scientificNameAuthorship: '',
        vernacularName: 'Jilguero',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Myadestes_melanops',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F7746636%2Foriginal.jpg%3F1494538489',
      ),
    ),
    Observation(
      id: '000000025',
      taxon: Taxon(
        id: '000025',
        scientificName: 'Tinamus major',
        scientificNameAuthorship: '',
        vernacularName: 'Gallina de monte, tinamú grande',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Tinamus_major',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F60447455%2Foriginal.jpg%3F1580242920',
      ),
    ),
    Observation(
      id: '000000026',
      taxon: Taxon(
        id: '000026',
        scientificName: 'Nothocercus bonapartei',
        scientificNameAuthorship: '',
        vernacularName: 'Gallina de monte, tinamú serrano',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Nothocercus_bonapartei',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F65542442%2Foriginal.jpeg%3F1585950161',
      ),
    ),
    Observation(
      id: '000000027',
      taxon: Taxon(
        id: '000027',
        scientificName: 'Crypturellus soui',
        scientificNameAuthorship: '',
        vernacularName: 'Gallina de monte, tinamú chico',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Crypturellus_soui',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F67850151%2Foriginal.jpeg%3F1587433888',
      ),
    ),
    Observation(
      id: '000000028',
      taxon: Taxon(
        id: '000028',
        scientificName: 'Crax rubra',
        scientificNameAuthorship: '',
        vernacularName: 'Pavón grande',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Crax_rubra',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F69042485%2Foriginal.jpg%3F1587866282',
      ),
    ),
    Observation(
      id: '000000029',
      taxon: Taxon(
        id: '000029',
        scientificName: 'Penelope purpurascens',
        scientificNameAuthorship: '',
        vernacularName: 'Pava granadera',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Penelope_purpurascens',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F46470599%2Foriginal.jpeg%3F1564372526',
      ),
    ),
    Observation(
      id: '000000030',
      taxon: Taxon(
        id: '000030',
        scientificName: 'Ortalis cinereiceps',
        scientificNameAuthorship: '',
        vernacularName: 'Pajuila, chachalaca cabecigrís',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Ortalis_cinereiceps',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F59991177%2Foriginal.jpeg%3F1579561479',
      ),
    ),
    Observation(
      id: '000000031',
      taxon: Taxon(
        id: '000031',
        scientificName: 'Chamaepetes unicolor',
        scientificNameAuthorship: '',
        vernacularName: 'Pava negra',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Chamaepetes_unicolor',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F32180207%2Foriginal.jpeg%3F1551471923',
      ),
    ),
    Observation(
      id: '000000032',
      taxon: Taxon(
        id: '000032',
        scientificName: 'Atelopus varius',
        scientificNameAuthorship: '',
        vernacularName: 'Rana arlequín',
        taxonRank: 'species',
        urlSpeciesPage: 'https://es.wikipedia.org/wiki/Atelopus_varius',
        urlImage:
            'https://api.gbif.org/v1/image/unsafe/https%3A%2F%2Fstatic.inaturalist.org%2Fphotos%2F47826514%2Foriginal.jpeg%3F1565529455',
      ),
    ),
  ];

  UnmodifiableListView<Observation> get observations {
    _observations = _getSortedObservations(_observations);
    return UnmodifiableListView(
      _observations,
    );
  }

  UnmodifiableListView<Observation> getObservationsQtyGt0() {
    return UnmodifiableListView(
      _observations.where((obs) => obs.quantity > 0).toList(),
    );
  }

  int getCountObservationsQtyGt0() {
    return (_observations.where((obs) => obs.quantity > 0).toList()).length;
  }

  UnmodifiableListView<Observation> get observedSpecies {
    _observations = _getSortedObservations(_observations);
    return UnmodifiableListView(
      _observations.where((obs) => obs.quantity > 0).toList(),
    );
  }

  Observation get firstObservation {
    _observations = _getSortedObservations(_observations);
    var l = UnmodifiableListView(
      _observations.where((obs) => obs.quantity > 0).toList(),
    );

    return l[0];
  }

  int get observationsCount {
    return _observations.length;
  }

  void sortObservations() {
    _observations.sort(
      (a, b) => a.taxon.scientificName.compareTo(b.taxon.scientificName),
    );
    _observations = _observations.reversed.toList();

    _observations.sort(
      (a, b) => a.quantity.compareTo(b.quantity),
    );
    _observations = _observations.reversed.toList();

    notifyListeners();
  }

  UnmodifiableListView<Observation> _getSortedObservations(
      List<Observation> l) {
    l.sort(
      (a, b) => a.taxon.scientificName.compareTo(b.taxon.scientificName),
    );
    l = l.reversed.toList();

    l.sort(
      (a, b) => a.quantity.compareTo(b.quantity),
    );
    l = l.reversed.toList();

    return UnmodifiableListView(
      l,
    );
  }

  UnmodifiableListView<Observation> findByFilter(String filter) {
    if (filter == '*') {
      _observations = _getSortedObservations(_observations);
      return UnmodifiableListView(
        _observations.toList(),
      );
    }

    List<Observation> filteredObservations = _observations
        .where(
          (o) => (o.taxon.scientificName.toLowerCase().contains(
                    filter.toLowerCase(),
                  ) ||
              o.taxon.vernacularName.toLowerCase().contains(
                    filter.toLowerCase(),
                  )),
        )
        .toList();
    filteredObservations = _getSortedObservations(filteredObservations);

    return UnmodifiableListView(filteredObservations);
  }

  Observation findByScientificName(String scientificName) {
    return _observations
        .firstWhere((obs) => obs.taxon.scientificName == scientificName);
  }

  void addObservation(String newObservationId, Taxon newObservationTaxon,
      int newObservationQty) {
    final observation = Observation(
      id: newObservationId,
      taxon: newObservationTaxon,
      quantity: newObservationQty,
    );
    _observations.add(observation);
    notifyListeners();
  }

  void deleteObservation(Observation observation) {
    _observations.remove(observation);
    notifyListeners();
  }
}
