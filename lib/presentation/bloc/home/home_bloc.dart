import 'package:flutter/material.dart';
import 'package:strider/data/mock_data.dart';
import 'package:strider/data/models/post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final MockData mockData = MockData();

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) async {
      if (event is OnLoadHome) {
        try {
          List<Post> posts = await mockData.getPosts();

          emit(HomeSucess(posts: posts));
        } catch(e) {
          emit(HomeFailed(error: "error on load posts"));
        }
      }
      if (event is OnLoadProfile) {
        try {
          List<Post> posts = await mockData.getPostsByUser(1);

          emit(HomeProfileSucess(posts: posts));
        } catch(e) {
          emit(HomeFailed(error: "error on load posts"));
        }
      }
    });
  }
}
