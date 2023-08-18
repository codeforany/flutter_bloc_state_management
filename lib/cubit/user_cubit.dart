import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../models/user_model.dart';
import '../repo/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo userRepo;
  UserCubit(this.userRepo) : super(UserLoadingState());

  void dataLoad() async {
    try {
      emit(UserLoadingState());
      var data = await userRepo.getUsers();
      emit(UserLoadedState(data));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
