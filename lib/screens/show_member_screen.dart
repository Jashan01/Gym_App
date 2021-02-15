import 'package:flutter/material.dart';
import 'package:gym/models/member_model.dart';

class ShowMemberScreen extends StatelessWidget {
  ShowMemberScreen(this.member);

  final MemberModel member;

  static void show(BuildContext context, {@required MemberModel member}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => ShowMemberScreen(member),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        elevation: 0,
        title: Text(
          member.name,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _createImage(),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name: ${member.name}',
                  style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Contact: ${member.phoneNumber}',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.0),
                Text(
                  'Membership Expiry Date: ${member.membershipExpiryDate}',
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    );
  }

  Widget _createImage() {
    if(member.image != null)
      {
        return Image(
          image: null,//insert image here with image provider
          height: 250,
        );
      }
    else{
      return Container();
    }
  }
}
