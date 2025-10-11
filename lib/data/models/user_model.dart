class UserModel {
  final int id;
  final String name;
  final String surname;
  final String userName;
  final String emailAddress;
  final String? profilePictureUrl;
  final bool allowSetPassword;
  final int userType;
  final String userToken;
  final String? lastSeen;
  final String? title;
  final List<String> roles;

  const UserModel({
    this.id = 0,
    this.name = '',
    this.surname = '',
    this.userName = '',
    this.emailAddress = '',
    this.profilePictureUrl,
    this.allowSetPassword = false,
    this.userType = 0,
    this.userToken = '',
    this.lastSeen,
    this.title,
    this.roles = const [],
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String? ?? '',
      surname: json['surname'] as String? ?? '',
      userName: json['userName'] as String? ?? '',
      emailAddress: json['emailAddress'] as String? ?? '',
      profilePictureUrl: json['profilePictureUrl'] as String?,
      allowSetPassword: json['allowSetPassword'] as bool? ?? false,
      userType: json['userType'] as int? ?? 0,
      userToken: json['userToken'] as String? ?? '',
      lastSeen: json['lastSeen'] as String?,
      title: json['title'] as String?,
      roles: (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ?? [],
    );
  }
}
