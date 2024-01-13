import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'page_toggle_state.dart';

class PageToggleCubit extends Cubit<PageToggleState> {
  PageToggleCubit() : super(const PageToggleState(0));

  void setPageIndex(int index) {
    emit(PageToggleState(index));
  }
}
