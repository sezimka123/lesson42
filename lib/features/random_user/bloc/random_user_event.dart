// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'random_user_bloc.dart';

abstract class RandomUserEvent {
  get value => null;
}

class GetRandomUserInfoEvent extends RandomUserEvent {
  final String title;
  final String value;

  GetRandomUserInfoEvent({
    required this.title,
    required this.value,
  });
}
