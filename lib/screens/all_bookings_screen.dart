import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/show_booking_screen.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/all_bookings_list_tile.dart';

class AllBookingsScreen extends StatefulWidget {
  AllBookingsScreen(this.slotsStream);
  final Stream<List<SlotModel>> slotsStream;
  static void show(BuildContext context,{@required Stream<List<SlotModel>> slotsStream}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => AllBookingsScreen(slotsStream),
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
            onTap: () =>ShowBookingScreen.show(context, slot: slot),
          ),
        );
      },
    );
  }

}
