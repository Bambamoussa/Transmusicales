import 'package:flutter/cupertino.dart';

class Values {

  GlobalKey<FormState> getKey(String debug) {
    return GlobalKey<FormState>(debugLabel: debug);
  }

}