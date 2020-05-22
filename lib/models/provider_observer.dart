import 'package:flutter/foundation.dart';

class ProviderObserver with ChangeNotifier {
  String name;

  ProviderObserver({
    this.name = "Observador",
  });

  void setName(String newName) {
    this.name = newName;
    notifyListeners();
  }

  String getName() {
    return this.name;
  }
}
