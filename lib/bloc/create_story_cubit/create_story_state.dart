part of 'create_story_cubit.dart';

class CreateStoryState extends Equatable {
  const CreateStoryState({
    this.prompt = "",
    this.genre = "Fairytale",
    this.status = FormzSubmissionStatus.initial,
  });

  final String prompt;
  final String genre;
  //Add status for story and image creation
  final FormzSubmissionStatus status;

  @override
  List<Object?> get props => [prompt, genre];

  CreateStoryState copyWith({String? prompt, String? genre}) {
    return CreateStoryState(
      prompt: prompt ?? this.prompt,
      genre: genre ?? this.genre,
      status: status,
    );
  }
}
