class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? role;
  String? parentContactNumber;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.role,
      this.parentContactNumber});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      role: map['role'],
      parentContactNumber: map[' parentContactNumber;'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'role': role,
      'parentContactNumber': parentContactNumber,
    };
  }
}
