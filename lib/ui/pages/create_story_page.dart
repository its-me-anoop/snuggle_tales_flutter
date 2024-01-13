import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/app/app.dart';
import 'package:snuggle_tales/bloc/create_story_cubit/create_story_cubit.dart';
import 'package:snuggle_tales/home/home.dart';
import 'package:snuggle_tales/utils/custom_button.dart';
import 'package:snuggle_tales/utils/sheet_title.dart';

class CreateStoryPage extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  CreateStoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange[50],
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const SheetTitle(title: 'Create Story'),
                BlocBuilder<CreateStoryCubit, CreateStoryState>(
                  builder: (context, state) {
                    return TextFormField(
                      decoration: const InputDecoration(
                          labelText: 'Describe your story here...'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter a story description.';
                        }
                        return null;
                      },
                      onChanged: (value) =>
                          context.read<CreateStoryCubit>().promptChanged(value),
                      maxLines: null,
                      keyboardType: TextInputType.multiline,
                    );
                  },
                ),
                const SizedBox(height: 20),
                BlocBuilder<CreateStoryCubit, CreateStoryState>(
                    builder: (context, state) {
                  return DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Genre',
                    ),
                    value: state.genre,
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a genre.';
                      }
                      return null;
                    },
                    onChanged: (value) =>
                        context.read<CreateStoryCubit>().genreChanged(value!),
                    items: <String>[
                      'Fairytale',
                      'Adventure',
                      'Fantasy',
                      'Historical Fiction',
                      'Horror',
                      'Magical Realism',
                      'Mystery',
                      'Science Fiction',
                      'Educational',
                      'Mythology',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  );
                }),
                const SizedBox(height: 20),
                BlocBuilder<AppBloc, AppState>(
                  builder: (context, state) {
                    return CustomButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<SheetToggleCubit>().toggleSheetClosed();
                          ScaffoldMessenger.of(context)
                            ..hideCurrentSnackBar()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Creating Story...'),
                              ),
                            );
                          context
                              .read<CreateStoryCubit>()
                              .generateStory(state.user.id)
                              .whenComplete(() {
                            ScaffoldMessenger.of(context)
                              ..hideCurrentSnackBar()
                              ..showSnackBar(
                                const SnackBar(
                                  content: Text('Story Created!'),
                                ),
                              );
                          });
                        }
                      },
                      text: 'Create Story',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
