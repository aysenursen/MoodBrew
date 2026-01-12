import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../../domain/entities/user.dart';

class UserModel {
  final String id;
  final String? email;
  final String? displayName;
  final bool isPremium;
  final DateTime createdAt;

  UserModel({
    required this.id,
    this.email,
    this.displayName,
    required this.isPremium,
    required this.createdAt,
  });

  factory UserModel.fromFirebaseUser(firebase_auth.User user) {
    return UserModel(
      id: user.uid,
      email: user.email,
      displayName: user.displayName,
      isPremium: false, // Default olarak free
      createdAt: user.metadata.creationTime ?? DateTime.now(),
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      email: json['email'] as String?,
      displayName: json['displayName'] as String?,
      isPremium: json['isPremium'] as bool? ?? false,
      createdAt: DateTime.parse(json['createdAt'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'displayName': displayName,
      'isPremium': isPremium,
      'createdAt': createdAt.toIso8601String(),
    };
  }

  User toEntity() {
    return User(
      id: id,
      email: email,
      displayName: displayName,
      isPremium: isPremium,
      createdAt: createdAt,
    );
  }
}
