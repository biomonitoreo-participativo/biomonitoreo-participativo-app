import 'package:flutter/foundation.dart';

class OpportunisticObservationTaxonCart with ChangeNotifier {
  Map<String, OpportunisticObservationTaxonCartItem> _items = {};

  Map<String, OpportunisticObservationTaxonCartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String taxonId, int individualCount) {
    if (_items.containsKey(taxonId)) {
      // change quantity...
      _items.update(
        taxonId,
        (existingCartItem) => OpportunisticObservationTaxonCartItem(
          taxonId: existingCartItem.taxonId,
          individualCount: existingCartItem.individualCount + individualCount,
        ),
      );
    } else {
      _items.putIfAbsent(
        taxonId,
        () => OpportunisticObservationTaxonCartItem(
          taxonId: taxonId,
          individualCount: individualCount,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String taxonId) {
    _items.remove(taxonId);
    notifyListeners();
  }

  void removeSingleItem(String taxonId) {
    if (!_items.containsKey(taxonId)) {
      return;
    }
    if (_items[taxonId].individualCount > 1) {
      _items.update(
          taxonId,
          (existingCartItem) => OpportunisticObservationTaxonCartItem(
                taxonId: existingCartItem.taxonId,
                individualCount: existingCartItem.individualCount - 1,
              ));
    } else {
      _items.remove(taxonId);
    }
    notifyListeners();
  }

  void clear() {
    _items = {};
    notifyListeners();
  }
}

class OpportunisticObservationTaxonCartItem {
  final String taxonId;
  final int individualCount;

  OpportunisticObservationTaxonCartItem({
    @required this.taxonId,
    @required this.individualCount,
  });
}
