import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/credential.dart';
import '/widgets/twitterapp.dart';
import '/widgets/twitterLogin.dart';
import '../models/credential.dart';

class loginCheck extends StatelessWidget {
  const loginCheck({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Provider.of<Credential>(context).login ? TwitterApp() : twitterLogin();
  }
}
