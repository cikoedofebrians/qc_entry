// To parse this JSON data, do
//
//     final token = tokenFromJson(jsonString);
import 'dart:convert';

Token tokenFromJson(String str) => Token.fromJson(json.decode(str));

String tokenToJson(Token data) => json.encode(data.toJson());

class Token {
  final String accessToken;
  final String tokenType;
  final int expiresIn;

  Token({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
  });

  Token copyWith({
    String? accessToken,
    String? tokenType,
    int? expiresIn,
  }) =>
      Token(
        accessToken: accessToken ?? this.accessToken,
        tokenType: tokenType ?? this.tokenType,
        expiresIn: expiresIn ?? this.expiresIn,
      );

  factory Token.fromJson(Map<String, dynamic> json) => Token(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        expiresIn: json["expires_in"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "expires_in": expiresIn,
      };
}
