import 'package:flutter/material.dart';

class MemberModel {
  MemberModel({
    @required this.name,
    @required this.phoneNumber,
    @required this.membershipExpiryDate,
    this.image,
  });
  final String name;
  final String phoneNumber;
  final String membershipExpiryDate;
  final Image image;

  static Map<String, dynamic> getMember(MemberModel member) {
    return {
      'name': member.name,
      'phoneNumber': member.phoneNumber,
      'membershipExpiryDate': member.membershipExpiryDate,
      'image': member.image,
    };
  }
}
