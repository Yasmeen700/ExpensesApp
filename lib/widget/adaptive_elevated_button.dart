import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_io/io.dart';

class AdaptiveElevatedButton extends StatelessWidget {
  final Function function;
  final String text;

  AdaptiveElevatedButton(this.function,this.text);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            child:  Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onPressed: function)
        : TextButton(
            onPressed: function,
            child:  Text(
              text,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          );
  }
}
