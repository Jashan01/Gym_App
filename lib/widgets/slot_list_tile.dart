import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';

class SlotListTile extends StatelessWidget {
  SlotListTile({@required this.slot, this.onTap});

  final SlotModel slot;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    String lead= slot.startTime;
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        child: Text(
          '${lead.substring(0,1)+lead.substring(5,6)}',
          style: TextStyle(color: Colors.white,fontSize: 20),
        ),
      ),
      title: Text(
        '${slot.startTime} - ${slot.endTime}',
        style: TextStyle(color: Colors.white),
      ),
      subtitle: Text(
        'Maximum Customers Allowed: ${slot.maxCustomersAllowed}',
        style: TextStyle(color: Colors.grey),
      ),
      onTap: onTap,
      trailing: Icon(Icons.chevron_right),
    );
  }
}
