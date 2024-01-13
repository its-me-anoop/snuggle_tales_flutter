import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/home/bloc/bloc.dart';
import 'package:snuggle_tales/home/ui/create_story_sheet.dart';
import 'package:snuggle_tales/home/ui/custom_app_bar.dart';
import 'package:snuggle_tales/home/ui/custom_body.dart';
import 'package:snuggle_tales/home/ui/custom_bottom_navigation_bar.dart';
import 'package:snuggle_tales/home/ui/custom_floating_action_button.dart';
import 'package:snuggle_tales/ui/pages/my_stories_page.dart';
import 'package:snuggle_tales/ui/pages/stories_page.dart';
import 'package:snuggle_tales/ui/pages/settings_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static const List pages = [
    Stories(),
    MyStories(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<SheetToggleCubit, SheetToggleState>(
      listener: (context, state) {
        if (state.isSheetOpen) {
          showModalBottomSheet(
            enableDrag: false,
            isDismissible: true,
            context: context,
            builder: (context) => const CreateStorySheet(),
          ).then((_) {
            context.read<SheetToggleCubit>().toggleSheetClosed();
          });
        } else {
          Navigator.popUntil(context, (route) => route.isFirst);
        }
      },
      child: const Scaffold(
        appBar: CustomAppBar(),
        body: CustomBody(),
        floatingActionButton: CustomFloatingActionButton(),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }
}
