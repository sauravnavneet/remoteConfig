import 'package:firebase_auth/firebase_auth.dart';

// class to handle firebase exception and general error
class FirebaseExceptionHandler {
  static String handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return 'The email not valid. Please check and try again.';
      case 'user-disabled':
        return 'The user with this email has been disabled. Please contact support.';
      case 'user-not-found':
        return 'No user found with this email. Please check the email or sign up.';
      case 'wrong-password':
        return 'The password entered is incorrect. Please try again.';
      case 'too-many-requests':
        return 'Too many login attempts. Please wait a while before trying again.';
      case 'user-token-expired':
        return 'Your session has expired. Please log in again to continue.';
      case 'network-request-failed':
        return 'Network error. Please check your internet connection and try again.';
      case 'invalid-login-credentials':
        return 'Invalid login credentials. Please check your email and password.';
      case 'invalid-credential':
        return 'Invalid login credentials. Please check your email and password.';
      case 'operation-not-allowed':
        return 'Email/password accounts are not enabled. Please contact support or try a different login method.';
      case 'email-already-in-use':
        return 'This email address is already registered. Please log in or use a different email.';
      case 'weak-password':
        return 'The password provided is too weak. Please choose a stronger password.';
      default:
        return 'An unknown error occurred. Please try again later.';
    }
  }

  static String handleGenericError(dynamic error) {
    if (error is FirebaseAuthException) {
      return handleAuthException(error);
    } else {
      return 'An unexpected error occurred. Please try again.';
    }
  }
}
