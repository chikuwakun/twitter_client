import './user.dart';

class Tweet {
  Tweet({
    required this.id,
    required this.user,
    required this.text,
    required this.createdAt,
    required this.retweetCount,
    required this.favoriteCount,
    required this.favorited,
    required this.retweeted,
  });

  final int id;
  final User user;
  final String text;
  final DateTime createdAt;
  final int retweetCount;
  final int favoriteCount;
  final bool favorited;
  final bool retweeted;
}