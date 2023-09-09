// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:lesson42/features/random_user/models/random_user_model.dart';
import 'package:lesson42/features/random_user/use_cases/random_user_use_case.dart';
import 'package:lesson42/internal/helpers/catch_exception.dart';

part 'random_user_event.dart';
part 'random_user_state.dart';

class RandomUserBloc extends Bloc<RandomUserEvent, RandomUserState> {
  final RandomUserUseCase randomUserUseCase;

  RandomUserBloc(this.randomUserUseCase) : super(RandomUserInitial()) {
    on<RandomUserEvent>((event, emit) async {
      try {
        emit(RandomUserInfoLoadingState());

        final data = await randomUserUseCase.getRandomUserInfo(value: event.value);

        emit(RandomUserInfoLoadedState(randomUserModel: data));
      } catch (e) {
        emit(RandomUserInfoErrorState(
            error: CatchException.convertException(e)));
      }
    });
  }
}
