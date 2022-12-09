// 인증관련된 것 = auth로 많이 사용함
class JoinReqDto {
  final String username;
  final String password;
  final String email;

  JoinReqDto({
    required this.username,
    required this.password,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
      "email": email,
    };
  }
}

class LoginReqDto {
  final String username;
  final String password;

  LoginReqDto({required this.username, required this.password, r});

  Map<String, dynamic> toJson() {
    return {
      "username": username,
      "password": password,
    };
  }
}
