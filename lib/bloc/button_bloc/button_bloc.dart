import 'package:flutter_bloc/flutter_bloc.dart';
import 'button_event.dart';
import 'button_state.dart';

class ButtonBloc extends Bloc<ButtonEvent, ButtonState> {
  ButtonBloc() : super(ButtonState.idle) {
    on<ButtonEvent>((event, emit) async {
      switch (event) {
        case ButtonEvent.pressed:
          emit(ButtonState.pressed);
          await Future.delayed(const Duration(milliseconds: 100));
          emit(ButtonState.idle);
          break;
        case ButtonEvent.idle:
          emit(ButtonState.idle);
          break;
      }
    });
  }
}
