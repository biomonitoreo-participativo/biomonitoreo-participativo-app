import 'package:flutter/foundation.dart';

class Group with ChangeNotifier {
  String group = "ACLAP";

  String getGroup() {
    return this.group;
  }

  void setGroup(String group) {
    this.group = group;
  }
}
