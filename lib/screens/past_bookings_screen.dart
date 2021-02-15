import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/show_past_booking_screen.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/all_bookings_list_tile.dart';

class PastBookingsScreen extends StatelessWidget {

  PastBookingsScreen(this.slotsStream, this.date);
  final Stream<List<SlotModel>> slotsStream;
  final String date;
  static void show(BuildContext context,{@required Stream<List<SlotModel>> slotsStream, @required String date}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => PastBookingsScreen(slotsStream,date),
    ));
  }

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
      stream: slotsStream, // define stream coming from database , make sure it's type is List<SlotModel>
      builder: (context, snapshot) {
        return ListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, slot) => AllBookingsListTile(
            slot: slot,
            onTap: (){
              return ShowPastBookingScreen.show(context, slot: slot);
            },
          ),
        );
      },
    );
  }

}
