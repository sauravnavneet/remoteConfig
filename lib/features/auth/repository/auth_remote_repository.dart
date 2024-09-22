import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:interview_task/constants/firebase_constants.dart';
import 'package:interview_task/core/models/auth_response_model.dart';
import 'package:interview_task/core/models/user_model.dart';
import 'package:interview_task/core/providers/firebase_providers.dart';
import 'package:interview_task/utils/exception_handler.dart';

// provider for AuthRepository class
final authRepositoryProvider = Provider((ref) {
  final firestore = ref.watch(firestoreProvider);
  final auth = ref.watch(authProvider);
  return AuthRemoteRepository(firestore: firestore, auth: auth);
});

// Auth repository class
class AuthRemoteRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  AuthRemoteRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
  })  : _auth = auth,
        _firestore = firestore;

  CollectionReference get users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<User?> get authStateChange => _auth.authStateChanges();

// signup
  Future<AuthResponseModel> signUp({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      // Create a new user with email and password
      final UserCredential credential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Get the newly created user
      final User? user = credential.user;

      // Store user information in Firestore
      await users.doc(user!.uid).set({
        'uid': user.uid,
        'email': email,
        'name': name,
        'createdAt': FieldValue.serverTimestamp(),
      });

      return AuthResponseModel(
        'Account created! Please Login',
        0,
      );
    } on FirebaseAuthException catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    } catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    }
  }

// Signs in an existing user using Firebase Authentication.
  Future<AuthResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final UserCredential credential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final User? user = credential.user;

      final userModel = UserModel(email: user!.email!, id: user.uid);

      return AuthResponseModel(
        'Sign in successful',
        0,
        user: userModel,
      );
    } on FirebaseAuthException catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    } catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    }
  }

// signout
  Future<AuthResponseModel> signOut() async {
    try {
      await _auth.signOut();
      return AuthResponseModel(
        'Logged Out..',
        0,
      );
    } on FirebaseAuthException catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    } catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    }
  }

// get user details
  Future<AuthResponseModel> getUserDetails(String uid) async {
    try {
      DocumentSnapshot documentSnapshot = await users.doc(uid).get();

      Map<String, dynamic>? userData =
          documentSnapshot.data() as Map<String, dynamic>?;

      final userModel = UserModel.fromMap(
        userData!,
      );

      return AuthResponseModel(
        'User exists',
        0,
        user: userModel,
      );
    } on FirebaseAuthException catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    } catch (e) {
      final error = FirebaseExceptionHandler.handleGenericError(e);
      return AuthResponseModel(error, 1);
    }
  }
}
