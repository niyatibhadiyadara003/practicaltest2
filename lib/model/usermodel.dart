class Usermodel {
  String? id;
  String? username;
  String? password;
  String? email;
  String? role;

  Usermodel(
      {required this.username,
      required this.password,
      required this.role,
      required this.email,
      this.id});
}
