import 'package:lesson42/features/random_user/models/random_user_model.dart';

abstract class RandomUserRepository {
  Future<RandomUserModel> getRandomUserInfo({required String value});
}