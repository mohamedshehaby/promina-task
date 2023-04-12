import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String name;
  final String email;
  final String token;

  const UserEntity({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
  });

  @override
  List<Object> get props => [id, email, name, token];
}
