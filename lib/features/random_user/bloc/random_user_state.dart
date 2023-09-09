// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'random_user_bloc.dart';

abstract class RandomUserState {}

final class RandomUserInitial extends RandomUserState {}

class RandomUserInfoLoadingState extends RandomUserState {}

class RandomUserInfoLoadedState extends RandomUserState {
  final RandomUserModel randomUserModel;

  RandomUserInfoLoadedState({
    required this.randomUserModel,
  });
}

class RandomUserInfoErrorState extends RandomUserState {
  final CatchException error;

  RandomUserInfoErrorState({required this.error});
}
