part of 'items_bloc.dart';

sealed class ItemsState extends Equatable {
  const ItemsState();

  @override
  List<Object> get props => [];
}

class ItemsLoadingState extends ItemsState {}

class ItemsLoadedState extends ItemsState {
  final List<ItemModel> itemsList;

  const ItemsLoadedState(this.itemsList);
  @override
  List<Object> get props => [itemsList];
}

class ItemsErrorState extends ItemsState {
  final String errorMSG;

  const ItemsErrorState(this.errorMSG);

  @override
  List<Object> get props => [errorMSG];
}
