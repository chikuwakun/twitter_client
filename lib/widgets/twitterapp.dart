import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import '../credentials.dart' as credentials;
import 'package:url_launcher/url_launcher.dart';




class TwitterApp extends StatefulWidget {
  const TwitterApp({Key? key}) : super(key: key);

  @override
  State<TwitterApp> createState() => _TwitterAppState();
}

class _TwitterAppState extends State<TwitterApp> {
  final controller = TextEditingController();
  final platform =oauth1.Platform(
    'https://api.twitter.com/oauth/request_token',
    'https://api.twitter.com/oauth/authorize',
    'https://api.twitter.com/oauth/access_token',
    oauth1.SignatureMethods.hmacSha1,
  );
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            TextFormField(
              controller:controller
            ),
            ElevatedButton(
              onPressed: () async {
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
                final apiResponse = await client.get(
                  Uri.parse(
                      'https://api.twitter.com/1.1/statuses/home_timeline.json?count=1'),
                );
                print(apiResponse.body);
              },
              child: Text('認証2'),
            ),
          ]
        ),
      ),
    );
  }
}
