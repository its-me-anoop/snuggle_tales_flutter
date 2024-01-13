import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/home/home.dart';
import 'package:snuggle_tales/utils/custom_button.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PageToggleCubit, PageToggleState>(
      builder: (context, state) {
        return state.pageIndex != 2
            ? BlocBuilder<SheetToggleCubit, SheetToggleState>(
                builder: (context, state) {
                  return CustomButton(
                    onPressed: () {
                      context.read<SheetToggleCubit>().toggleSheetOpen();
                    },
                    text: 'Create Story',
                  );
                },
              )
            : const SizedBox();
      },
    );
  }
}
