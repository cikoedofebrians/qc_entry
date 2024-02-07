class User {
  final int id;
  final String name;
  final String email;
  final List<Role> roles;
  final UserCredential? userCredential;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.roles,
    required this.userCredential,
  });

  User copyWith({
    int? id,
    String? name,
    String? email,
    List<Role>? roles,
    UserCredential? userCredential,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        roles: roles ?? this.roles,
        userCredential: userCredential ?? this.userCredential,
      );

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        roles: List<Role>.from(json["roles"].map((x) => Role.fromJson(x))),
        userCredential: json['user_credential'] != null
            ? UserCredential.fromJson(json["user_credential"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "roles": List<dynamic>.from(roles.map((x) => x.toJson())),
        "user_credential": userCredential?.toJson(),
      };
}

class Role {
  final int id;
  final String name;

  Role({
    required this.id,
    required this.name,
  });

  Role copyWith({
    int? id,
    String? name,
  }) =>
      Role(
        id: id ?? this.id,
        name: name ?? this.name,
      );

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}

class UserCredential {
  final int id;
  final int userId;
  final String phoneNumber;

  UserCredential({
    required this.id,
    required this.userId,
    required this.phoneNumber,
  });

  UserCredential copyWith({
    int? id,
    int? userId,
    String? phoneNumber,
  }) =>
      UserCredential(
        id: id ?? this.id,
        userId: userId ?? this.userId,
        phoneNumber: phoneNumber ?? this.phoneNumber,
      );

  factory UserCredential.fromJson(Map<String, dynamic> json) => UserCredential(
        id: json["id"],
        userId: json["user_id"],
        phoneNumber: "0${json["phone_number"]}",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "user_id": userId,
        "phone_number": phoneNumber,
      };
}
