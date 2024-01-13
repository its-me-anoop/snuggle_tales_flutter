import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/bloc/button_bloc/button_bloc.dart';
import 'package:snuggle_tales/bloc/button_bloc/button_event.dart';
import 'package:snuggle_tales/bloc/button_bloc/button_state.dart';

class CustomButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;
  final IconData? icon;
  const CustomButton(
      {Key? key, required this.onPressed, required this.text, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ButtonBloc, ButtonState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTapDown: (details) =>
                context.read<ButtonBloc>().add(ButtonEvent.pressed),
            onTapUp: (details) =>
                context.read<ButtonBloc>().add(ButtonEvent.idle),
            onTap: onPressed,
            child: Transform.scale(
              scale: state == ButtonState.pressed ? 0.90 : 1.0,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  gradient: const LinearGradient(
                    colors: [Colors.orange, Colors.deepOrange],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      offset: const Offset(5, 5),
                      blurRadius: 15,
                    ),
                  ],
                ),
                child: IntrinsicWidth(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      if (icon != null) Icon(icon, color: Colors.white),
                      SizedBox(width: icon != null ? 8.0 : 0),
                      Text(
                        text,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
