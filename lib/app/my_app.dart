import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/app/bloc/app_bloc.dart';
import 'package:snuggle_tales/bloc/button_bloc/button_bloc.dart';
import 'package:snuggle_tales/bloc/create_story_cubit/create_story_cubit.dart';
import 'package:snuggle_tales/bloc/form_bloc/form_bloc.dart';
import 'package:snuggle_tales/bloc/login_cubit/login_cubit.dart';
import 'package:snuggle_tales/bloc/sign_up_cubit/sign_up_cubit.dart';
import 'package:snuggle_tales/home/home.dart';
import 'package:snuggle_tales/repositories/repositories.dart';

class MyApp extends StatelessWidget {
  const MyApp(
      {required AuthenticationRepository authenticationRepository,
      required StoriesRepository storiesRepository,
      super.key})
      : _authenticationRepository = authenticationRepository,
        _storiesRepository = storiesRepository;

  final AuthenticationRepository _authenticationRepository;
  final StoriesRepository _storiesRepository;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AppBloc(
              authenticationRepository: _authenticationRepository,
            ),
          ),
          BlocProvider(
            create: (context) => ButtonBloc(),
          ),
          BlocProvider(
            create: (context) => FormBloc(),
          ),
          BlocProvider(
            create: (context) => LoginCubit(AuthenticationRepository()),
          ),
          BlocProvider(
            create: (context) => PageToggleCubit(),
          ),
          BlocProvider(
              create: (context) => SignUpCubit(_authenticationRepository)),
          BlocProvider(
              create: (context) => CreateStoryCubit(_storiesRepository)),
          BlocProvider(create: (context) => SheetToggleCubit())
        ],
        child: MaterialApp(
          title: 'Snuggle Tales',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
            textTheme: ThemeData.light().textTheme.copyWith(
                  titleLarge: const TextStyle(
                      fontFamily: 'Amita',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
