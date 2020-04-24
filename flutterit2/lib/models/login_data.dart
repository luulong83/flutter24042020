//part of 'api_response.dart';

class LoginData {
  final String token;
  LoginData({this.token});

  factory LoginData.fromJson(Map<String, dynamic> json) => LoginData(
        token: json['Token'] as String,
      );
  Map<String, dynamic> toJson() => <String, dynamic>{
        'Token': this.token,
      };
}
