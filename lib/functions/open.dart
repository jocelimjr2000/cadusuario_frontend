import 'package:flutter/material.dart';

void open(BuildContext context, Widget screen) async {
  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => screen));
}

void openAndExecute(BuildContext context, Widget screen, Function funcTrue, Function funcFalse) async {
  await Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => screen)).then(
    (execute) {
      if (execute ?? false) {
        if (funcTrue != null) {
          funcTrue();
        }
      } else {
        if (funcFalse != null) {
          funcFalse();
        }
      }
    },
  );
}
