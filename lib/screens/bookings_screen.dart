import 'package:flutter/material.dart';
import 'package:gym/models/member_model.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/show_member_screen.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/member_list_tile.dart';

class BookingsScreen extends StatefulWidget {
  BookingsScreen(this.slot);
  final SlotModel slot;
  static void show(BuildContext context,{@required SlotModel slot}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => BookingsScreen(slot),
    ));
  }
  @override
  _BookingsScreenState createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  Widget appBarTitle = new Text('Bookings',
    style: TextStyle(
      fontSize: 20,
      color: Colors.white,
    ),
  );
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        title: appBarTitle,
        elevation: 0,
        actions: [
          new IconButton(
            icon: actionIcon,
            color: Colors.white,
            iconSize: 26,
            onPressed: () {
              setState(() {
                if (this.actionIcon.icon == Icons.search) {
                  this.actionIcon = new Icon(Icons.close);
                  this.appBarTitle = Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: new TextField(
                      style: new TextStyle(
                          color: Colors.black,
                          fontSize: 19
                      ),
                      decoration: new InputDecoration(
                          prefixIcon: new Icon(Icons.search, color: Colors.grey),
                          hintText: "Search",
                          hintStyle: new TextStyle(color: Colors.grey)),
                    ),
                  );
                } else {
                  this.actionIcon = new Icon(Icons.search);
                  this.appBarTitle = new Text('Bookings',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  );
                }
              });
            },
          ),
        ],
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
            onTap: () => ShowMemberScreen.show(context, member: member),
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
