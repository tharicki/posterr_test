part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class OnLoadHome extends HomeEvent {
  OnLoadHome();
}

class OnLoadProfile extends HomeEvent {
  final int userId;
  OnLoadProfile({required this.userId});
}

class OnNewPost extends HomeEvent {
  final Post post;
  OnNewPost({required this.post});
}
