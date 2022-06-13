part of 'home_bloc.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSucess extends HomeState {
  final List<Post> posts;

  HomeSucess({required this.posts});
}

class HomeProfileSucess extends HomeState {
  final List<Post> posts;

  HomeProfileSucess({required this.posts});
}

class HomeFailed extends HomeState {
  final String error;

  HomeFailed({required this.error});
}
