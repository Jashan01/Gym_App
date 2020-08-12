import 'package:flutter/material.dart';

class SlotModel{
  SlotModel({@required this.startTime, @required this.endTime, @required this.maxCustomersAllowed});
  final startTime;
  final endTime;
  final int maxCustomersAllowed;

  static Map<String, dynamic> getSlot(SlotModel slot){
    return
        {
          'startTime' : slot.startTime,
          'endTime' : slot.endTime,
          'maxCustomersAllowed' : slot.maxCustomersAllowed,
        };
  }

}