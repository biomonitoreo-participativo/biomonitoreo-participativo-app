import 'package:flutter/foundation.dart';

class InputObservationQuantity with ChangeNotifier {
  int quantity;

  InputObservationQuantity({
    this.quantity = 1,
  });

  void setQuantity(int newQuantity) {
    this.quantity = newQuantity;
    notifyListeners();
  }

  int getQuantity() {
    return this.quantity;
  }
}
