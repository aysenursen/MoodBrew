import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthFirebaseDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<UserModel> signInWithEmail(String email, String password);
  Future<UserModel> signUpWithEmail(String email, String password);
  Future<void> resetPassword(String email);
  Future<void> signOut();
  Stream<UserModel?> get authStateChanges;
}

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final firebase_auth.FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthFirebaseDataSourceImpl({required this.auth})
    : googleSignIn = GoogleSignIn();

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException('Sign in aborted by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final accessToken = googleAuth.accessToken;
      final idToken = googleAuth.idToken;

      if (accessToken == null || idToken == null) {
        throw const AuthException('Failed to get Google credentials');
      }

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw const AuthException('Failed to sign in');
      }

      return UserModel.fromFirebaseUser(userCredential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw AuthException('Firebase auth failed: ${e.message ?? e.code}');
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    throw const AuthException('Apple Sign In not implemented yet');
  }

  @override
  Future<UserModel> signInWithEmail(String email, String password) async {
    try {
      final userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const AuthException('Failed to sign in');
      }

      return UserModel.fromFirebaseUser(userCredential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      String message = 'Email sign in failed';

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'wrong-password':
          message = 'Wrong password';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'user-disabled':
          message = 'This account has been disabled';
          break;
      }

      throw AuthException(message);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Email sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signUpWithEmail(String email, String password) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (userCredential.user == null) {
        throw const AuthException('Failed to create account');
      }

      return UserModel.fromFirebaseUser(userCredential.user!);
    } on firebase_auth.FirebaseAuthException catch (e) {
      String message = 'Sign up failed';

      switch (e.code) {
        case 'email-already-in-use':
          message = 'An account already exists with this email';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
        case 'weak-password':
          message = 'Password is too weak';
          break;
      }

      throw AuthException(message);
    } catch (e) {
      if (e is AuthException) rethrow;
      throw AuthException('Sign up failed: ${e.toString()}');
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
    } on firebase_auth.FirebaseAuthException catch (e) {
      String message = 'Failed to send reset email';

      switch (e.code) {
        case 'user-not-found':
          message = 'No user found with this email';
          break;
        case 'invalid-email':
          message = 'Invalid email address';
          break;
      }

      throw AuthException(message);
    } catch (e) {
      throw AuthException('Failed to send reset email: ${e.toString()}');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await Future.wait([auth.signOut(), googleSignIn.signOut()]);
    } catch (e) {
      throw AuthException('Sign out failed: ${e.toString()}');
    }
  }

  @override
  Stream<UserModel?> get authStateChanges {
    return auth.authStateChanges().map(
      (user) => user != null ? UserModel.fromFirebaseUser(user) : null,
    );
  }
}
