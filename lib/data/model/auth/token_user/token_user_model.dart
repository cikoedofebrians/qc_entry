import 'package:qc_entry/data/model/auth/token/token_model.dart';
import 'package:qc_entry/data/model/auth/user/user_model.dart';

class TokenUser {
  final Token token;
  final User user;

  TokenUser({
    required this.token,
    required this.user,
  });
}
