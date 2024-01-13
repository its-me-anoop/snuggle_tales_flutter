part of 'page_toggle_cubit.dart';

class PageToggleState extends Equatable {
  final int pageIndex;

  const PageToggleState(this.pageIndex);

  @override
  List<Object> get props => [pageIndex];
}
