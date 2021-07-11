import 'package:blood_bank/models/donor.dart';

class User {
  final int? id;
  final String? name;
  final String? email;
  final int? phone;
  final String? createdAt;
  final String? updatedAt;
  final Donor? donor;
  final String? accessToken;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.createdAt,
    this.updatedAt,
    this.donor,
    this.accessToken,
  });
}
