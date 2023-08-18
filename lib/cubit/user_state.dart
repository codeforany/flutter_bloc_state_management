part of 'user_cubit.dart';

sealed class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

final class UserLoadingState extends UserState {}
final class UserLoadedState extends UserState {
  final UserModel userObj;

  const UserLoadedState(this.userObj);

  @override
  List<Object> get props => [userObj];


}
final class UserErrorState extends UserState {
  final String errorMSG;

  const UserErrorState(this.errorMSG);

  @override
  List<Object> get props => [errorMSG];


}
