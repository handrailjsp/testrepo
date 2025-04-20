class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? profilePicture;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.profilePicture,
  });

  String get initials {
    if (name.isEmpty) return '';

    final nameParts = name.split(' ');
    if (nameParts.length > 1) {
      return '${nameParts[0][0]}${nameParts[1][0]}'.toUpperCase();
    }

    return name[0].toUpperCase();
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? profilePicture,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      profilePicture: profilePicture ?? this.profilePicture,
    );
  }
}