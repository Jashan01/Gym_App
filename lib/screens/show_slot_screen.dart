import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';

class ShowSlotScreen extends StatelessWidget {
  ShowSlotScreen(this.slot);

  final SlotModel slot;

  static void show(BuildContext context, {@required SlotModel slot}) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => ShowSlotScreen(slot),
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
          '${slot.startTime} - ${slot.endTime}',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Start Time',style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),
                  Text(slot.startTime,style:
                  TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),),
                ],
              ),
              decoration: BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey,width: 0.5))
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('End Time',style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),
                  Text(slot.endTime,style:
                  TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 0.5))
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Maximum Customers Allowed',style:
                  TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),),
                  Text('${slot.maxCustomersAllowed}',style:
                  TextStyle(
                    color: Colors.grey,
                    fontSize: 20,
                  ),),
                ],
              ),
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.grey,width: 0.5))
              ),
            ),
          ],
          ),
      ),
    );
  }
}
