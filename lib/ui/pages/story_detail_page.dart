//Story Detail Page
// Path: lib/ui/pages/story_detail_page.dart

import 'package:flutter/material.dart';
import 'package:snuggle_tales/models/story_model.dart';

class StoryDetail extends StatelessWidget {
  final Story story;
  const StoryDetail({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          story.title,
          overflow: TextOverflow.ellipsis,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        top: false,
        bottom: false,
        child: Stack(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: Hero(
                tag: story.coverImage,
                child: Image.network(
                  story.coverImage,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                  ),
                  Container(
                    height: 50,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ])),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        story.story,
                        style: const TextStyle(fontSize: 18),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
