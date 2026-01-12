import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? displayName;
  final bool isPremium;
  final DateTime createdAt;

  const User({
    required this.id,
    this.email,
    this.displayName,
    required this.isPremium,
    required this.createdAt,
  });

  @override
  List<Object?> get props => [id];

  User copyWith({String? email, String? displayName, bool? isPremium}) {
    return User(
      id: id,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      isPremium: isPremium ?? this.isPremium,
      createdAt: createdAt,
    );
  }
}
