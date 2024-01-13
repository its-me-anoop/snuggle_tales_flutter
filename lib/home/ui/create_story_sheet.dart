import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/app/app.dart';
import 'package:snuggle_tales/bloc/login_cubit/login_cubit.dart';
import 'package:snuggle_tales/repositories/repositories.dart';
import 'package:snuggle_tales/ui/pages/create_story_page.dart';
import 'package:snuggle_tales/ui/pages/login_page.dart';

class CreateStorySheet extends StatelessWidget {
  const CreateStorySheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (BuildContext context) {
        return ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          child: FlowBuilder<AppStatus>(
            state: context.select((AppBloc bloc) => bloc.state.status),
            onGeneratePages: (status, pages) {
              switch (status) {
                case AppStatus.authenticated:
                  return [
                    MaterialPage(
                      child: BlocProvider(
                        create: (context) => LoginCubit(
                            context.read<AuthenticationRepository>()),
                        child: CreateStoryPage(),
                      ),
                    ),
                  ];
                case AppStatus.unauthenticated:
                  return [
                    MaterialPage(
                      child: BlocProvider(
                        create: (context) => LoginCubit(
                            context.read<AuthenticationRepository>()),
                        child: LoginPage(),
                      ),
                    ),
                  ];
                default:
                  return [
                    MaterialPage(
                      child: LoginPage(),
                    ),
                  ];
              }
            },
          ),
        );
      },
    );
  }
}
