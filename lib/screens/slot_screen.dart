import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/add_slot_screen.dart';
import 'package:gym/screens/show_slot_screen.dart';
import 'package:gym/utils/list_items_builder.dart';
import 'package:gym/widgets/slot_list_tile.dart';

class SlotScreen extends StatefulWidget {
  @override
  _SlotScreenState createState() => _SlotScreenState();
}

class _SlotScreenState extends State<SlotScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width,40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Slots',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ),
        elevation: 0,
        actions: [
          FlatButton(
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => AddSlotScreen.show(context),
          ),
        ],
      ),
      body: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    //final database = Provider.of<Database>(context, listen: false); [ Define database here ]
    return StreamBuilder<List<SlotModel>>(
      stream:
          slotsStream(), // define stream coming from database , make sure it's type is List<SlotModel>
      builder: (context, snapshot) {
        return ListItemBuilder(
          snapshot: snapshot,
          itemBuilder: (context, slot) => SlotListTile(
            slot: slot,
            onTap: () =>ShowSlotScreen.show(context, slot: slot),
          ),
        );
      },
    );
  }

  Stream<List<SlotModel>> slotsStream() {
    return Stream.value([
      SlotModel(
        startTime: '2:00 pm',
        endTime: '3:00 pm',
        maxCustomersAllowed: 20,
      ),
      SlotModel(
        startTime: '3:00 pm',
        endTime: '4:00 pm',
        maxCustomersAllowed: 15,
      ),
      SlotModel(
        startTime: '4:00 pm',
        endTime: '5:00 pm',
        maxCustomersAllowed: 16,
      ),
      SlotModel(
        startTime: '5:00 pm',
        endTime: '6:00 pm',
        maxCustomersAllowed: 16,
      )
    ]);
  }
}
