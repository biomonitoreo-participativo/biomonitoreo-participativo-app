import 'package:flutter/foundation.dart';

class EventTaxaCart with ChangeNotifier {
  Map<String, EventTaxaCartItem> _items = {};

  Map<String, EventTaxaCartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  void addItem(String taxonId, int individualCount, String occurrenceId) {
    print('addItem');
    if (_items.containsKey(taxonId)) {
      print('present');
      // change quantity...
      _items.update(
        taxonId,
        (existingCartItem) => EventTaxaCartItem(
          taxonId: existingCartItem.taxonId,
          individualCount: individualCount,
          occurrenceId: occurrenceId,
        ),
      );
    } else {
      print('absent');
      _items.putIfAbsent(
        taxonId,
        () => EventTaxaCartItem(
          taxonId: taxonId,
          individualCount: individualCount,
          occurrenceId: occurrenceId,
        ),
      );
    }
    //notifyListeners();
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
          (existingCartItem) => EventTaxaCartItem(
                taxonId: existingCartItem.taxonId,
                individualCount: existingCartItem.individualCount - 1,
                occurrenceId: existingCartItem.occurrenceId,
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

class EventTaxaCartItem {
  final String taxonId;
  final int individualCount;
  final String occurrenceId;

  EventTaxaCartItem({
    @required this.taxonId,
    @required this.individualCount,
    this.occurrenceId,
  });
}
