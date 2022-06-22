class UserClasses {
  int? id;
  String username;
  String? pass;
  String phoneNo;
  String email;
  String role;
  bool? isActive;

  UserClasses({
    this.id,
    required this.username,
    this.pass,
    required this.phoneNo,
    required this.email,
    required this.role,
    this.isActive,
  });
}