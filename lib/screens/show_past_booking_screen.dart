import 'package:flutter/material.dart';
import 'package:gym/models/member_model.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/member_list_tile.dart';

class ShowPastBookingScreen extends StatelessWidget {
  ShowPastBookingScreen(this.slot);

  final SlotModel slot;

  static void show(BuildContext context, {@required SlotModel slot}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => ShowPastBookingScreen(slot),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          '${slot.startTime} - ${slot.endTime}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 30),
          child: Container(
            padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Date :',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  slot.date,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: _buildContent(context),
    );

  }

  Widget _buildContent(BuildContext context) {
    //final database = Provider.of<Database>(context, listen: false); [ Define database here ]
    return StreamBuilder<List<MemberModel>>(
      stream:
      membersStream(), // define stream coming from database , make sure it's type is List<SlotModel>
      builder: (context, snapshot) {
        return ListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, member) => MemberListTile(
            member: member,
          ),
        );
      },
    );
  }

  Stream<List<MemberModel>> membersStream() {
    return Stream.value([
      MemberModel(
          name: 'Jashanjot Singh',
          phoneNumber: '9123847568',
          membershipExpiryDate: '21/08/2020'),
      MemberModel(
          name: 'Mihip Verna',
          phoneNumber: '9746583726',
          membershipExpiryDate: '22/10/2020'),
      MemberModel(
          name: 'Vishal Sharma',
          phoneNumber: '9782674635',
          membershipExpiryDate: '10/11/2020'),
      MemberModel(
          name: 'Tarun Madan',
          phoneNumber: '9835467823',
          membershipExpiryDate: '10/04/2020'),
    ]);
  }
}
