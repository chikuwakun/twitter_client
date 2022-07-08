import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:oauth1/oauth1.dart' as oauth1;
import 'package:provider/provider.dart';
import '../credentials.dart' as credentials;
import 'package:url_launcher/url_launcher.dart';
import '../models/tweet.dart';
import '../models/user.dart';

import 'package:intl/intl.dart';
import '../models/credential.dart';


class TwitterApp extends StatefulWidget {
  const TwitterApp({Key? key}) : super(key: key);

  @override
  State<TwitterApp> createState() => _TwitterAppState();
}

class _TwitterAppState extends State<TwitterApp> {
  static final _dateFormatter = DateFormat('E MMM dd HH:mm:ss yyyy');
  Future<List<Tweet>> getTimeline() async {
    print("getTimeline");

    final client = context.read<Credential>().userclient;
    final apiResponse = await client.get(
      Uri.parse(
          'https://api.twitter.com/1.1/statuses/home_timeline.json?count=20'),
    );
    var _timelines = <Tweet>[];
    //model 作成部分
    for (var tweet in jsonDecode(apiResponse.body)) {
      final Tweet t = Tweet(user: User(),
        text: tweet['text'],
        favoriteCount: tweet['favorite_count'],
        id: tweet['id'],
        //Dartがタイムゾーンに対応してないからこんなことせなあかんのや
        createdAt: _dateFormatter.parseStrict(
            tweet['created_at'].replaceAll(RegExp(r'\+.... '),
                '')),
        retweetCount: tweet['retweet_count'],
        retweeted: tweet['retweeted'],
        favorited: tweet['favorited'],
      );
      _timelines.add(t);
      print(_timelines);

    }
    return Future.value(_timelines);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Twitter'),
      ),
      body: Center(
        child:
            FutureBuilder(
              future: getTimeline(),
              builder: (context, AsyncSnapshot<List<Tweet>> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      final tweet = snapshot.data![index];
                      return ListTile(
                        title: Text(tweet.text),
                        subtitle: Text(
                          _dateFormatter.format(tweet.createdAt),
                        ),
                      );
                    },
                  );
                } else {
                  return CircularProgressIndicator();
                }
              },
            ),
        ),
    );
  }
}
