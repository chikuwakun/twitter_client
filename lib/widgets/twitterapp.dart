import 'package:flutter/material.dart';


class TwitterApp extends StatefulWidget {
  const TwitterApp({Key? key}) : super(key: key);

  @override
  State<TwitterApp> createState() => _TwitterAppState();
}

class _TwitterAppState extends State<TwitterApp> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('twitterApp'),
    );
  }
}
