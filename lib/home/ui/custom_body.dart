import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/home/home.dart';

class CustomBody extends StatelessWidget {
  const CustomBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageToggleCubit, PageToggleState>(
      builder: (context, state) {
        return HomePage.pages[state.pageIndex];
      },
    );
  }
}
