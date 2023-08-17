import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc_state_management/repo/items_repo.dart';
import '../models/item_model.dart';

part 'items_event.dart';
part 'items_state.dart';

class ItemsBloc extends Bloc<ItemsLoadedEvent, ItemsState> {
  final ItemsRepo itemRepo;

  ItemsBloc(this.itemRepo) : super(ItemsLoadingState()) {
    on<ItemsLoadedEvent>((event, emit) async {
      try {
        emit(ItemsLoadingState());
        var data = await itemRepo.getItems();
        emit(ItemsLoadedState(data));
      } catch (e) {
        emit(ItemsErrorState(e.toString()));
      }
    });
  }
}
