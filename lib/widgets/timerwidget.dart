import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Timerwidget extends StatefulWidget {
  final String service;

  Timerwidget({Key? key,required this.service}) : super(key: key);

  @override
  State<Timerwidget> createState() => _TimerwidgetState();
}

class _TimerwidgetState extends State<Timerwidget> {
  late Timer _timer;
  late DateTime _time;

  bool timerRunning = false;



  @override
  void initState(){
    _time = DateTime.utc(0,0,0,0,0,1);
    super.initState(); //ちゃんと継承している
  }

  void _startTimer() {
    if (timerRunning) {
      _timer.cancel();
      setState(() {
        timerRunning = false;
      });
    } else {
      _timer = Timer.periodic(Duration(seconds: 1),
              (Timer timer) => setState((){_time = _time.subtract(Duration(seconds: 1));
          if(_time.isAtSameMomentAs(DateTime.utc(0,0,0,0,0,0))){
            _timer.cancel();
            setState(() {
              timerRunning = false;
            });

            Navigator.of(context).pushNamed(widget.service);
            //移動先のサービスをプッシュする。
          }
          })
      );
      setState(() {
        timerRunning = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        _startTimer();
      },
      child: Scaffold(
          body: Column(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                DateFormat.ms().format(_time),
                style: !timerRunning?  Theme.of(context).textTheme.headline2: Theme.of(context).textTheme.headline2?.copyWith(color: Colors.white),
                textAlign: TextAlign.center,
              ),

            ],),
          backgroundColor: !timerRunning? Theme.of(context).secondaryHeaderColor:Theme.of(context).primaryColor
      ),
    );
  }
}