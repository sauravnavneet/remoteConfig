import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/core/models/user_model.dart';

// Current User Provider
class CurrentUserNotifier extends StateNotifier<UserModel?> {
  CurrentUserNotifier() : super(null);

  void addUser(UserModel user) {
    state = user;
  }

  void removeUser() {
    state = null;
  }
}

final currentUserProvider =
    StateNotifierProvider<CurrentUserNotifier, UserModel?>(
        (ref) => CurrentUserNotifier());
