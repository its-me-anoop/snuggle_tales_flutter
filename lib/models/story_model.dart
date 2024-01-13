import 'package:cloud_firestore/cloud_firestore.dart';

class Story {
  final String title;
  final String userPrompt;
  final String story;
  final String genre;
  final DateTime createdTime;
  final String userName;
  final String coverImage;

  Story({
    required this.title,
    required this.userPrompt,
    required this.story,
    required this.genre,
    required this.createdTime,
    required this.userName,
    required this.coverImage,
  });

  factory Story.fromMap(Map<String, dynamic> map) {
    // Implementation of the 'fromMap' method...
    return Story(
      title: map['title'],
      userPrompt: map['userPrompt'],
      story: map['story'],
      genre: map['genre'],
      createdTime: (map['createdTime'] as Timestamp).toDate(),
      userName: map['userName'],
      coverImage: map['coverImage'],
    );
  }
  // Implementation of the 'fromMap' method...
}
