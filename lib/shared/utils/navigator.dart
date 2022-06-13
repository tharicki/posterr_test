import 'package:flutter/material.dart';

class Nav {
  static Future push(BuildContext? context, Widget page,
      {bool replace = false}) {
    if (replace) {
      return Navigator.pushReplacement(
          context!, MaterialPageRoute(builder: (BuildContext context) => page));
    }

    return Navigator.push(context!,
        MaterialPageRoute(builder: (BuildContext context) {
      return page;
    }));
  }

  static bool pop<T extends Object>(BuildContext context, [T? result]) {
    if (Navigator.canPop(context)) {
      Navigator.pop(context, result);
      return true;
    }
    return false;
  }
}
