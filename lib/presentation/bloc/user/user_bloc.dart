import 'package:flutter/material.dart';
import 'package:strider/data/mock_data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:strider/data/models/user.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final MockData mockData = MockData();

  UserBloc() : super(UserInitial()) {
    on<UserEvent>((event, emit) async {
      if (event is OnLoadUser) {
        try {
          User myUser = await mockData.getUserById(event.id);

          emit(UserSuccess(user: myUser));
        } catch(e) {
          emit(UserFailed(error: "error on load posts"));
        }
      }
    });
  }
}
