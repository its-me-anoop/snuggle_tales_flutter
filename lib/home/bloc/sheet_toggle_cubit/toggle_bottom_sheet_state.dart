part of 'toggle_bottom_sheet_cubit.dart';

//State for the toggle bottom sheet cubit
class SheetToggleState extends Equatable {
  const SheetToggleState(this.isSheetOpen);

  final bool isSheetOpen;

  @override
  List<Object?> get props => [isSheetOpen];
}
