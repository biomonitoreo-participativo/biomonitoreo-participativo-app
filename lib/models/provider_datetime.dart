import 'package:flutter/foundation.dart';

class ProviderDateTime with ChangeNotifier {
  String label;

  ProviderDateTime({
    this.label = "2020-05-22-09-00-00",
  });

  void setLabel(String newLabel) {
    this.label = newLabel;
    notifyListeners();
  }

  String getLabel() {
    return this.label;
  }
}
