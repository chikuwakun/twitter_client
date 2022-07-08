import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:twitter_client/widgets/loginCheck.dart';
import '../models/credential.dart';
import '/widgets/twitterapp.dart';
import '/widgets/twitterLogin.dart';
import '/widgets/loginCheck.dart';

class Twitter extends StatelessWidget {
  const Twitter({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Credential>(create: (ctx) => Credential(),
      child: loginCheck()
    );
  }
}
