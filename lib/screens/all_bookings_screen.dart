import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/member_screens/member_book_slot_screen.dart';
import 'package:gym/screens/show_booking_screen.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/all_bookings_list_tile.dart';

class AllBookingsScreen extends StatefulWidget {
  AllBookingsScreen(this.slotsStream, this.identifier);
  final Stream<List<SlotModel>> slotsStream;
  final String identifier;
  static void show(BuildContext context,{@required Stream<List<SlotModel>> slotsStream, @required String identifier}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => AllBookingsScreen(slotsStream,identifier),
    ));
  }
  @override
  _AllBookingsScreenState createState() => _AllBookingsScreenState();
}

class _AllBookingsScreenState extends State<AllBookingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
        elevation: 0,
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    //final database = Provider.of<Database>(context, listen: false); [ Define database here ]
    return StreamBuilder<List<SlotModel>>(
      stream: widget.slotsStream, // define stream coming from database , make sure it's type is List<SlotModel>
      builder: (context, snapshot) {
        return ListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, slot) => AllBookingsListTile(
            slot: slot,
            onTap: (){
              if(widget.identifier=='owner')
                {
                  return ShowBookingScreen.show(context, slot: slot);
                }
              else if(widget.identifier == 'member')
                {
                  return MemberBookSlotScreen.show(context, slot: slot);
                }
            },
          ),
        );
      },
    );
  }

}
