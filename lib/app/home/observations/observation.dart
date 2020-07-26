import 'package:flutter/foundation.dart';
import '../models/taxon.dart';

class Observation with ChangeNotifier {
  final String id;
  final Taxon taxon;
  int quantity;

  Observation({
    @required this.id,
    @required this.taxon,
    this.quantity = 0,
  });

  int getQuantity() {
    return this.quantity;
  }

  void setQuantity(int newQuantity) {
    this.quantity = newQuantity;
    notifyListeners();
  }

  void incrementQty() {
    this.quantity++;
    notifyListeners();
  }
}
