import 'package:flutter/material.dart';
import 'package:gym/models/member_model.dart';
import 'package:gym/screens/add_member_screen.dart';
import 'package:gym/screens/show_member_screen.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/member_list_tile.dart';

class MembersScreen extends StatefulWidget {
  @override
  _MembersScreenState createState() => _MembersScreenState();
}

class _MembersScreenState extends State<MembersScreen> {
  Widget appBarTitle = new Text('');
  Icon actionIcon = new Icon(Icons.search);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        title: appBarTitle,
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Members',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
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
                  this.appBarTitle = new Text("AppBar Title");
                }
              });
            },
          ),
          FlatButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => AddMemberScreen.show(context),
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
