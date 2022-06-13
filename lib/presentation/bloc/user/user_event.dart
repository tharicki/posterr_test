part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class OnLoadUser extends UserEvent {
  final int id;
  OnLoadUser({required this.id});
}
