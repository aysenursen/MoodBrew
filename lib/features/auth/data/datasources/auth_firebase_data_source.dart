import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import '../../../../core/error/exceptions.dart';
import '../models/user_model.dart';

/*
abstract class AuthFirebaseDataSource {
  Future<UserModel> signInWithGoogle();
  Future<UserModel> signInWithApple();
  Future<UserModel> signInWithEmail(String email, String password);
  Future<void> signOut();
  Stream<UserModel?> get authStateChanges;
}

class AuthFirebaseDataSourceImpl implements AuthFirebaseDataSource {
  final firebase_auth.FirebaseAuth auth;
  final GoogleSignIn googleSignIn;

  AuthFirebaseDataSourceImpl({required this.auth, GoogleSignIn? googleSignIn})
    : googleSignIn = googleSignIn ?? GoogleSignIn();

  @override
  Future<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();

      if (googleUser == null) {
        throw const AuthException('Sign in aborted by user');
      }

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user == null) {
        throw const AuthException('Failed to sign in');
      }

      return UserModel.fromFirebaseUser(userCredential.user!);
    } catch (e) {
      throw AuthException('Google sign in failed: ${e.toString()}');
    }
  }

  @override
  Future<UserModel> signInWithApple() async {
    // TODO: Implement Apple Sign In
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
    } catch (e) {
      throw AuthException('Email sign in failed: ${e.toString()}');
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
}*/
