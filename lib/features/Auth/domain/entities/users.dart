class UserEntity {
  final String id;
  final String email;
  final String name;
  final String photoUrl;
  final DateTime lastLogin;

  UserEntity(
      {required this.id,
      required this.email,
      required this.name,
      required this.photoUrl,
      required this.lastLogin});
  
  
}
