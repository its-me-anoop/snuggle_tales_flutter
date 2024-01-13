import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/home/bloc/bloc.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({Key? key}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Builder(builder: (context) {
        return BlocBuilder<PageToggleCubit, PageToggleState>(
          builder: (context, state) {
            return Text(
              state.pageIndex != 2 ? 'Snuggle Tales' : 'Settings',
              style: const TextStyle(fontWeight: FontWeight.bold),
            );
          },
        );
      }),
    );
  }
}
