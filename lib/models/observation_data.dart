import 'package:flutter/foundation.dart';
import 'dart:collection';
import 'observation.dart';
import 'taxon.dart';

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
      ),
    ),
    Observation(
      id: '000000009',
      taxon: Taxon(
        id: '000009',
        scientificName: 'Odoicoleus virginianus',
        scientificNameAuthorship: '',
        vernacularName: 'Venado cola blanca',
        taxonRank: 'species',
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
      ),
    ),
    Observation(
      id: '000000012',
      taxon: Taxon(
        id: '000012',
        scientificName: 'Ateles geoffrogyi',
        scientificNameAuthorship: '',
        vernacularName: 'Mono araña',
        taxonRank: 'species',
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
      ),
    ),
    Observation(
      id: '000000027',
      taxon: Taxon(
        id: '000027',
        scientificName: 'Cryturellus soui',
        scientificNameAuthorship: '',
        vernacularName: 'Gallina de monte, tinamú chico',
        taxonRank: 'species',
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
      ),
    ),
  ];

  UnmodifiableListView<Observation> get observations {
    // sortObservations();
    _observations = _getSortedObservations(_observations);
    return UnmodifiableListView(
      _observations,
    );
  }

  UnmodifiableListView<Observation> get observedSpecies {
    // sortObservations();
    _observations = _getSortedObservations(_observations);
    return UnmodifiableListView(
      _observations.where((obs) => obs.quantity > 0).toList(),
    );
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
