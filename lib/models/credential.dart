import 'package:flutter/material.dart';
import 'package:twitter_client/widgets/loginCheck.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
class Credential extends ChangeNotifier{
  var login = false;
  late oauth1.Client userclient;

  void setUserClient(userclient){
    this.userclient = userclient;
    login = true;
    notifyListeners();
  }
}