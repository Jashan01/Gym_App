import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/member_screens/member_book_slot_screen.dart';
import 'package:gym/utils/constants.dart';

class MemberListCard extends StatelessWidget {
  MemberListCard({@required this.slot, this.context});

  final SlotModel slot;
  final BuildContext context;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 200,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [
              0.4,
              1,
            ],
            colors: [
              Color(0xFF1F1030),
              Colors.black54
            ],
          ),
          borderRadius: BorderRadius.all(Radius.circular(8)),
        ),
        child: _cardContents(context),
      ),
    );
  }

  Widget _cardContents(BuildContext context){
    int bookingsLeft= (slot.maxCustomersAllowed)-(slot.bookingsDone);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 15, 12, 8),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Color(Constants.BASE_LIGHT_COLOR),
                    borderRadius: BorderRadius.all(Radius.circular(100)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(8, 4, 8, 4),
                    child: Text(
                      'BOOKINGS LEFT: $bookingsLeft',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12
                      ),
                    ),
                  ),
                )
              ],
            ),
            Container(
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    '${slot.startTime} - ${slot.endTime}',
                    style: TextStyle(
                      color: Color(Constants.BASE_COLOR),
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        '${slot.startTime} - ${slot.endTime}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'Max Customers Allowed: ${slot.maxCustomersAllowed}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () => MemberBookSlotScreen.show(context,slot: slot),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(Constants.BASE_LIGHT_COLOR),
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 6, 10, 6),
                      child: Text(
                        'Book Now',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
