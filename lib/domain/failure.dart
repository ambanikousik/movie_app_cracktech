import 'dart:convert';

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String context;
  final String message;
  const Failure({
    required this.context,
    required this.message,
  });

  Failure copyWith({
    String? context,
    String? message,
  }) {
    return Failure(
      context: context ?? this.context,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'context': context,
      'message': message,
    };
  }

  factory Failure.fromMap(Map<String, dynamic> map) {
    return Failure(
      context: map['context'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Failure.fromJson(String source) =>
      Failure.fromMap(json.decode(source));

  @override
  String toString() => 'Failure(context: $context, message: $message)';

  @override
  List<Object> get props => [context, message];
}
