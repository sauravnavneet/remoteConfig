import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/core/models/auth_response_model.dart';
import 'package:interview_task/core/providers/current_user_provider.dart';
import 'package:interview_task/features/auth/repository/auth_remote_repository.dart';

// provider for auth provider class
final authProviderNotifier =
    StateNotifierProvider<AuthProvider, AsyncValue<AuthResponseModel?>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final userNotifier = ref.watch(currentUserProvider.notifier);
  return AuthProvider(authRepository, userNotifier);
});

// Stream auth change status - if auth then update the current user else null
final authStateChangeProvider = StreamProvider((ref) async* {
  final auth = ref.watch(authProviderNotifier.notifier);
  yield auth;
});

// auth provider class
class AuthProvider extends StateNotifier<AsyncValue<AuthResponseModel?>> {
  final AuthRemoteRepository _authRepository;
  final CurrentUserNotifier _userNotifier;

  AuthProvider(this._authRepository, this._userNotifier)
      : super(const AsyncValue.data(null));

  Stream<User?> get authStateChange => _authRepository.authStateChange;

// signup
  Future<void> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    state = const AsyncValue.loading();
    final response = await _authRepository.signUp(
        email: email, password: password, name: name);
    state = AsyncValue.data(response);
  }

// signin
  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    state = const AsyncValue.loading();
    final response =
        await _authRepository.signIn(email: email, password: password);
    log('${response.code}', name: 'Sign in');
    if (response.code == 0) {
      await getUserDetails(response.user!.id);
    }
    state = AsyncValue.data(response);
  }

// signout
  Future<void> signOut() async {
    state = const AsyncValue.loading();
    final response = await _authRepository.signOut();
    if (response.code == 0) {
      _userNotifier.removeUser();
    }

    state = AsyncValue.data(response);
  }

// get user details
  Future<void> getUserDetails(String uid) async {
    log('trig');
    final response = await _authRepository.getUserDetails(uid);
    if (response.code == 0) {
      _userNotifier.addUser(response.user!);
    }
  }
}
