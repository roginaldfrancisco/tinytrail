import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String userId;
  final String name;
  final String email;
  final String profilePicture;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    required this.profilePicture,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return UserModel(
      userId: doc.id,
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      profilePicture: data['profile_picture'] ?? '',
    );
  }
}