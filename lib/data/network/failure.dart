import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final int? code;
  final String message;

  const Failure({
    this.code,
    required this.message,
  });

  @override
  List<Object?> get props => [code, message];
}
