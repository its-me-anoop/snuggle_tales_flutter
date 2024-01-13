import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:formz/formz.dart';
import 'package:snuggle_tales/models/story_model.dart';
import 'package:snuggle_tales/repositories/stories_repository.dart';

part 'create_story_state.dart';

class CreateStoryCubit extends Cubit<CreateStoryState> {
  CreateStoryCubit(this._storiesRepository) : super(const CreateStoryState());

  final StoriesRepository _storiesRepository;

  void promptChanged(String value) {
    emit(
      state.copyWith(prompt: value),
    );
  }

  void genreChanged(String value) {
    emit(
      state.copyWith(genre: value),
    );
  }

  Future<void> generateStory(String userId) async {
    final story = await _storiesRepository.generateStory(
      "${state.prompt} genre: ${state.genre}",
    );
    final coverImage = await _storiesRepository.generateCoverImage(
      story.split('\n')[0],
    );

    final Story newStory = Story(
        title: story.split('\n')[0],
        userPrompt: state.prompt,
        genre: state.genre,
        story: story.split('\n').sublist(2).join('\n'),
        coverImage: coverImage,
        userName: userId,
        createdTime: DateTime.now());

    try {
      await _storiesRepository.uploadStory(newStory);
    } catch (_) {
      if (kDebugMode) {
        print(_);
      }
    }
  }
}
