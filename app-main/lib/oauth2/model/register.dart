import 'package:json_annotation/json_annotation.dart';

part 'register.g.dart';

@JsonSerializable()
class Register {
  final String? userName;
  final String? email;
  final String? password;

  factory Register.fromJson(Map<String, dynamic> json) =>
      _$RegisterFromJson(json);

  Map<String, dynamic> toJson() => _$RegisterToJson(this);

  const Register({
    this.userName,
    this.email,
    this.password,
  });

  Register copyWith({
    String? userName,
    String? email,
    String? password,
  }) {
    return Register(
      userName: userName ?? this.userName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }
}
