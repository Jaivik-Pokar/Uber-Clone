import 'package:firebase_database/firebase_database.dart';

class UserProfile {
  String fullName;
  String email;
  String phone;
  String id;

  UserProfile({
    this.email,
    this.fullName,
    this.phone,
    this.id,
  });

  UserProfile.fromSnapshot(DataSnapshot snapshot) {
    id = snapshot.key;
    phone = snapshot.value['phone'];
    email = snapshot.value['email'];
    fullName = snapshot.value['fullName'];
  }
}
