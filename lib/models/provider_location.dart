import 'package:flutter/foundation.dart';

class ProviderLocation with ChangeNotifier {
  String name;

  ProviderLocation({
    this.name = "Siberia",
  });

  void setName(String newName) {
    this.name = newName;
    notifyListeners();
  }

  String getName() {
    return this.name;
  }
}
