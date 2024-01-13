import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:snuggle_tales/models/story_model.dart';
import 'package:snuggle_tales/secrets/open_ai_api_key.dart';

class StoriesRepository {
  final FirebaseFirestore _firestore;
  final FirebaseStorage _storage;

  StoriesRepository({FirebaseFirestore? firestore, FirebaseStorage? storage})
      : _firestore = firestore ?? FirebaseFirestore.instance,
        _storage = storage ?? FirebaseStorage.instance;

  static const String openApiBaseUrl = 'https://api.openai.com/v1/';
  static const Map<String, String> openApiHeaders = {
    'Content-Type': 'application/json',
    'Authorization': 'Bearer $apiKey',
  };

  Future<String> generateStory(String prompt) async {
    // Call OpenAI API to generate a story
    // Replace with your actual OpenAI API endpoint and key

    try {
      final response = await http.post(
        Uri.parse('${openApiBaseUrl}completions'),
        headers: openApiHeaders,
        body: jsonEncode(
          {
            "model": 'gpt-3.5-turbo-instruct',
            "prompt":
                "Write a short children's story. no index. use paragraphs. add a title, but don't use the text Title:.The story should be in this format : \n\n Title \n\n story. Here is additional information. $prompt. ",
            'max_tokens': 1000,
          },
        ),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print(response.body);
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        final String story = data['choices'][0]['text'];
        return story.trim();
      } else {
        // Handle failure to load response (non-200 status code)
        if (kDebugMode) {
          print(
              'Failed to load ChatGPT response. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to load ChatGPT response');
      }
    } catch (e) {
      // Handle general errors
      if (kDebugMode) {
        print('Error getting ChatGPT response: $e');
      }
      rethrow; // Re-throw the exception for further handling if needed
    }
  }

  Future<String> generateCoverImage(String prompt) async {
    // Call DALL-E API to generate a cover image
    // Replace with your actual DALL-E API endpoint and key
    try {
      final response = await http.post(
        Uri.parse('${openApiBaseUrl}images/generations'),
        headers: openApiHeaders,
        body: jsonEncode({
          'model': 'dall-e-3',
          'n': 1,
          'style': 'vivid',
          'response_format': 'b64_json',
          'prompt': prompt,
        }),
      );

      // Check if the request was successful (status code 200)
      if (response.statusCode == 200) {
        if (kDebugMode) {
          print("image generated successfully");
        }
        final Map<String, dynamic> data = jsonDecode(response.body);
        return data['data'][0]['b64_json'];
      } else {
        // Handle failure to load response (non-200 status code)
        if (kDebugMode) {
          print('Failed to create image. Status code: ${response.statusCode}');
        }
        if (kDebugMode) {
          print('Response body: ${response.body}');
        }
        throw Exception('Failed to create image');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error getting Dall-e response: $e');
      }
      rethrow;
    }
  }

  Future<void> uploadStory(Story story) async {
    try {
      // Convert base64 image to bytes
      Uint8List imageBytes = base64Decode(story.coverImage);

      // Create a unique file name for the image
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.png';

      // Upload the image to Firebase Storage
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('story_covers/$fileName')
          .putData(imageBytes);

      if (snapshot.state == TaskState.success) {
        // Get the download URL of the image
        final String downloadUrl = await snapshot.ref.getDownloadURL();

        // Upload the story to Firestore with the download URL of the image
        await _firestore.collection('stories').add({
          'title': story.title,
          'userPrompt': story.userPrompt,
          'genre': story.genre,
          'story': story.story,
          'createdTime': story.createdTime,
          'userName': story.userName,
          'coverImage': downloadUrl,
        });
      } else {
        if (kDebugMode) {
          print('Failed to upload image to Firebase Storage');
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error uploading story: $e');
      }
    }
  }
}
