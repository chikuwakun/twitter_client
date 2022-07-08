import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './widgets/timerwidget.dart';
import './widgets/twitterapp.dart';

void main() {
  runApp(MaterialApp(home: TimerTwitter(),
    routes: <String ,WidgetBuilder>{
      '/timer': (BuildContext context) => TimerTwitter(),
      '/twitter': (BuildContext context) => TwitterApp(),
    },
  ));
}
class TimerTwitter extends StatelessWidget {
  String service = '/twitter';//移動先サービスの名前

  @override
  Widget build(BuildContext context) {
    return Timerwidget(service: service);
  }
}

