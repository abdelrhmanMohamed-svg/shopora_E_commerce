class UserDataModel {
  final String uid;
  final String email;
  final String username;
  final String createdDate;

  UserDataModel({
    required this.uid,
    required this.email,
    required this.username,
    required this.createdDate,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'email': email,
      'username': username,
      'createdDate': createdDate,
    };
  }

  factory UserDataModel.fromMap(Map<String, dynamic> map) {
    return UserDataModel(
      uid: map['uid'] as String,
      email: map['email'] as String,
      username: map['username'] as String,
      createdDate: map['createdDate'] as String,
    );
  }

  
}
