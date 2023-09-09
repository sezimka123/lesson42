import 'package:dio/dio.dart';
import 'package:lesson42/features/random_user/bloc/random_user_repository.dart';
import 'package:lesson42/features/random_user/models/random_user_model.dart';
import 'package:lesson42/internal/helpers/api_requester.dart';
import 'package:lesson42/internal/helpers/catch_exception.dart';

class RandomUserRepositoryImpl implements RandomUserRepository {
  ApiRequester apiRequester = ApiRequester();

  @override
  Future<RandomUserModel> getRandomUserInfo({required String value}) async {
    try {
      Response response = await apiRequester.toGet(url: "");

      print('statusCode == ${response.statusCode}');
      print('response.data == ${response.data}');

      if (response.statusCode == 200) {
        return RandomUserModel.fromJson(response.data);
      }

      throw response;
    } catch (e) {
      print('getRandomUserInfo error: $e');

      throw CatchException.convertException(e);
    }
  }
}
