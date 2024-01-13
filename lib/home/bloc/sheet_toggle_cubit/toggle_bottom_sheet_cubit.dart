import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'toggle_bottom_sheet_state.dart';

class SheetToggleCubit extends Cubit<SheetToggleState> {
  SheetToggleCubit() : super(const SheetToggleState(false));

  void toggleSheetOpen() {
    emit(const SheetToggleState(true));
  }

  void toggleSheetClosed() {
    emit(const SheetToggleState(false));
  }
}
