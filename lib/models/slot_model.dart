import 'package:flutter/material.dart';

class SlotModel{
  SlotModel({this.bookingsDone,@required this.startTime, @required this.endTime, @required this.maxCustomersAllowed});
  final startTime;
  final endTime;
  final int maxCustomersAllowed;
  final int bookingsDone;

  static Map<String, dynamic> getSlot(SlotModel slot){
    return
        {
          'startTime' : slot.startTime,
          'endTime' : slot.endTime,
          'maxCustomersAllowed' : slot.maxCustomersAllowed,
          'bookingsDone' : slot.bookingsDone,
        };
  }

}