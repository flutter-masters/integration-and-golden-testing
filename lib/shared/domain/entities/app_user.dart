class AppUser {
  final String id;
  final String email;
  final String name;

  AppUser({
    required this.id,
    required this.email,
    required this.name,
  });
}

extension AppUserX on AppUser {
  AppUser copyWith({
    String? email,
    String? name,
  }) {
    return AppUser(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }
}
