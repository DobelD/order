import 'package:flutter/material.dart';

class Size {
  static void height(BuildContext context) {
    MediaQuery.of(context).size.height;
  }

  static void width(BuildContext context) {
    MediaQuery.of(context).size.width;
  }

  static void top(BuildContext context) {
    MediaQuery.of(context).padding.top;
  }
}
