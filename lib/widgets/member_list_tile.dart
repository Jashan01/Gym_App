import 'package:flutter/material.dart';
import 'package:gym/models/member_model.dart';
import 'package:gym/utils/constants.dart';

class MemberListTile extends StatelessWidget {
  MemberListTile({@required this.member, this.onTap});

  final MemberModel member;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      trailing: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
          color: Colors.blueGrey[700],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.all(Radius.circular(4)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              '${member.name.substring(0, 1).toUpperCase()}',
              style: TextStyle(color: Colors.black, fontSize: 25),
            ),
          ],
        ),
      ),
      title: Text(
        member.name,
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        '${member.phoneNumber}\nMembership Expiry Date: ${member.membershipExpiryDate}',
        style: TextStyle(color: Colors.grey),
      ),
      isThreeLine: true,
      onTap: onTap,
    );
  }
}
