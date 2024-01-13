import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/home/home.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  const CustomBottomNavigationBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageToggleCubit, PageToggleState>(
      builder: (context, state) {
        return BottomNavigationBar(
          currentIndex:
              context.select((PageToggleCubit cubit) => cubit.state.pageIndex),
          onTap: (index) {
            context.read<PageToggleCubit>().setPageIndex(index);
          },
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book_fill),
              label: 'Stories',
            ),
            BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.book_fill),
              label: 'My Stories',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        );
      },
    );
  }
}
