part of 'user_bloc.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserSuccess extends UserState {
  final User user;

  UserSuccess({required this.user});
}

class UserFailed extends UserState {
  final String error;

  UserFailed({required this.error});
}
