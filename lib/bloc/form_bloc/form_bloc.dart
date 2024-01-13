import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:snuggle_tales/bloc/form_bloc/form_event.dart';
import 'package:snuggle_tales/bloc/form_bloc/form_state.dart';

class FormBloc extends Bloc<FormEvent, FormState> {
  FormBloc() : super(FormState()) {
    on<EmailChanged>((event, emit) {
      emit(FormState(email: event.email, password: state.password));
    });
    on<PasswordChanged>((event, emit) {
      emit(FormState(email: state.email, password: event.password));
    });
  }
}
