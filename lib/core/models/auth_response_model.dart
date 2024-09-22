import 'package:interview_task/core/models/user_model.dart';

// auth repsonse model
class AuthResponseModel {
  final String message;
  final int code;
  final UserModel? user;

  AuthResponseModel(this.message, this.code, {this.user});
}
