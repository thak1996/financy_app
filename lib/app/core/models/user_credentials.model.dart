import 'dart:convert';

class UserCredentials {
  final int? id;
  final String? name;
  final String? password;
  final String? email;
  final String? token;

  UserCredentials({
    this.id,
    this.name,
    this.password,
    this.email,
    this.token,
  });

  UserCredentials copyWith({
    int? id,
    String? name,
    String? password,
    String? email,
    String? token,
  }) {
    return UserCredentials(
      id: id ?? this.id,
      name: name ?? this.name,
      password: password ?? this.password,
      email: email ?? this.email,
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'password': password,
      'email': email,
      'token': token,
    };
  }

  factory UserCredentials.fromMap(Map<String, dynamic> map) {
    return UserCredentials(
      id: map['id'] != null ? map['id'] as int : null,
      name: map['name'] != null ? map['name'] as String : null,
      password: map['password'] != null ? map['password'] as String : null,
      email: map['email'] != null ? map['email'] as String : null,
      token: map['token'] != null ? map['token'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserCredentials.fromJson(String source) => UserCredentials.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserCredentials(id: $id, name: $name, password: $password, email: $email, token: $token)';
  }

  @override
  bool operator ==(covariant UserCredentials other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.password == password &&
      other.email == email &&
      other.token == token;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      name.hashCode ^
      password.hashCode ^
      email.hashCode ^
      token.hashCode;
  }
}
