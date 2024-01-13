import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/app/my_app.dart';
import 'package:snuggle_tales/bloc_observer.dart';
import 'package:snuggle_tales/repositories/authentication_repository.dart';
import 'package:snuggle_tales/repositories/stories_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = const AppBlocObserver();

  await Firebase.initializeApp();

  final authenticationRepository = AuthenticationRepository();
  final storiesRepository = StoriesRepository();
  await authenticationRepository.user.first;

  runApp(MyApp(
      authenticationRepository: authenticationRepository,
      storiesRepository: storiesRepository));
}
