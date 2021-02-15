import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';

class SlotListTile extends StatelessWidget {
  SlotListTile({@required this.slot, this.onTap});

  final SlotModel slot;
  final VoidCallback onTap;

  String showLeadText()
  {
    String lead= slot.startTime;
    if(lead.length == 7)
    {
      return lead.substring(0,1)+lead.substring(5,6);
    }
    else{
      return lead.substring(0,2)+lead.substring(6,7);
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(color: Colors.purple, shape: BoxShape.circle),
        child: Text(
          showLeadText(),
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
