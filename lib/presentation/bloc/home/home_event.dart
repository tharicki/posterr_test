part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class OnLoadHome extends HomeEvent {
  OnLoadHome();
}

class OnLoadProfile extends HomeEvent {
  int userId;
  OnLoadProfile({required this.userId});
}
