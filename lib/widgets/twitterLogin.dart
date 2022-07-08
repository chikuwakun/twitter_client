import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:provider/provider.dart';
import '../credentials.dart' as credentials;
import 'package:url_launcher/url_launcher.dart';
import '../models/tweet.dart';
import '../models/user.dart';
import '../models/credential.dart';

import 'package:provider/provider.dart';

import 'package:intl/intl.dart';

class twitterLogin extends StatefulWidget {
  const twitterLogin({Key? key}) : super(key: key);

  @override
  State<twitterLogin> createState() => _twitterLoginState();
}

class _twitterLoginState extends State<twitterLogin> {
  final controller = TextEditingController();
  final platform =oauth1.Platform(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/authorize',
    'https://api.twitter.com/oauth/access_token',
    oauth1.SignatureMethods.hmacSha1,
  );

  late final userclient ;

  final clientCredentials = oauth1.ClientCredentials(
    credentials.apikey,
    credentials.keysecret,
  );

  late final auth = oauth1.Authorization(clientCredentials,platform);
  oauth1.Credentials? tokenCredentials;

  @override
  void initState() {
    super.initState();

    auth.requestTemporaryCredentials('oob').then((res){
      tokenCredentials = res.credentials;
      launch(auth.getResourceOwnerAuthorizationURI(tokenCredentials!.token));//TODO ここ新しい関数にする
    });
  }

  void getCredentials(credential) async{
    print('getCredentials');
    // 入力されたPINを元に Access Token を取得
    final pin = controller.text;
    final verifier = pin;
    final res = await auth.requestTokenCredentials(
      tokenCredentials!,
      verifier,
    );
    // 取得した Access Token を使ってAPIにリクエストできる
    final client = oauth1.Client(
      platform.signatureMethod,
      clientCredentials,
      res.credentials,
    );
    credential.setUserClient(client);
  }


  @override
  Widget build(BuildContext context) {
    final credential = Provider.of<Credential>(context);
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[TextFormField(
            controller:controller
        ),
          ElevatedButton(
            onPressed: () =>{
              getCredentials(credential)
            },
            child: Text('認証'),
          )
        ]
      ),
    );
  }
}
