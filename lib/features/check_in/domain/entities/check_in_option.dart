import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class CheckInOption extends Equatable {
  final String id;
  final String label;
  final IconData icon;
  final Color color;

  const CheckInOption({
    required this.id,
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  List<Object?> get props => [id];
}
