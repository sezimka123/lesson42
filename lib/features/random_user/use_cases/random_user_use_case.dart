// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:lesson42/features/random_user/bloc/random_user_repository.dart';
import 'package:lesson42/features/random_user/models/random_user_model.dart';

class RandomUserUseCase {
  final RandomUserRepository randomUserRepository;

  RandomUserUseCase({required this.randomUserRepository});

  Future<RandomUserModel> getRandomUserInfo({required String value}) {
    return randomUserRepository.getRandomUserInfo(value: value);
  }
}
