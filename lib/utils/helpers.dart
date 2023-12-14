import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Helpers {
  static void showNativeDialog(
    BuildContext context,
    Widget title,
    Widget content,
    List<Widget> Function(BuildContext) actions,
  ) {
    if (Platform.isIOS) {
      showCupertinoDialog(
        context: context,
        builder: (ctx) => CupertinoAlertDialog(
          title: title,
          content: content,
          actions: actions(ctx),
        ),
      );
      return;
    }
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: title,
        content: content,
        actions: actions(ctx),
      ),
    );
  }
}
