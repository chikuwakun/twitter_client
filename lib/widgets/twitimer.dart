import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';

class twitimer extends StatefulWidget {
  const twitimer({Key? key}) : super(key: key);

  @override
  State<twitimer> createState() => _twitimerState();
}

class _twitimerState extends State<twitimer> {

  late Timer _timer;
  late DateTime _time;


  @override
  void initState(){
    _time = DateTime.utc(0,0,0,0,0,10);
    _startTimer();
    super.initState(); //ちゃんと継承している
  }
  void _startTimer() {
    {
      _timer = Timer.periodic(Duration(seconds: 1),
              (Timer timer) => setState((){_time = _time.subtract(Duration(seconds: 1));
          if(_time.isAtSameMomentAs(DateTime.utc(0,0,0,0,0,0))){
            _timer.cancel();

            Navigator.of(context).pushReplacementNamed('/timer');
            //移動先のサービスをプッシュする。
          }
          })
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Text(DateFormat.ms().format(_time));
  }
}
