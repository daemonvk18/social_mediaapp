class AppUser {
  final String uId;
  final String email;
  final String username;
  AppUser({required this.uId, required this.email, required this.username});

  //converting appuser--->json data
  Map<String, dynamic> toJson() {
    return {'uId': uId, 'email': email, 'name': username};
  }

  //converting json data----> appuser
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
        uId: jsonUser['uid'],
        email: jsonUser['email'],
        username: jsonUser['name']);
  }
}
