import 'package:flutter/material.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/all_bookings_screen.dart';
import 'package:gym/screens/filter_screen.dart';
import 'package:gym/utils/constants.dart';
import 'package:gym/widgets/empty_content.dart';
import 'package:gym/widgets/list_card.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 40),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(15, 5, 0, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Home',
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
              Icons.filter_list,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => FilterScreen.show(context),
          ),
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 1,
            child: GestureDetector(
              onTap: () => AllBookingsScreen.show(context,
                  slotsStream: slotsStream(),
                  identifier: 'owner'), //pass identifier owner or member
              child: Container(
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'See All',
                        style: TextStyle(
                          color: Color(Constants.BASE_LIGHT_COLOR),
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: Container(child: _buildContent(context)),
          ),
        ],
      ),
    );
  }

  Widget _buildContent(BuildContext context) {
    return StreamBuilder<List<SlotModel>>(
      stream: slotsStream(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final slots = snapshot.data;
          if (slots.isNotEmpty) {
            final children = slots
                .map(
                  (slot) => ListCard(
                    slot: slot,
                    context: context,
                  ),
                )
                .toList();
            return ListView(
              itemExtent: 250,
              children: children,
            );
          } else {
            return EmptyContent();
          }
        } else if (snapshot.hasError) {
          return Center(child: Text('some error occurred'));
        } else {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    );
  }

  Stream<List<SlotModel>> slotsStream() {
    return Stream.value([
      SlotModel(
        startTime: '2:00 pm',
        endTime: '3:00 pm',
        maxCustomersAllowed: 20,
        bookingsDone: 17,
        date: '18/08/2020',
      ),
      SlotModel(
        startTime: '3:00 pm',
        endTime: '4:00 pm',
        maxCustomersAllowed: 15,
        bookingsDone: 6,
        date: '18/08/2020',
      ),
      SlotModel(
        startTime: '4:00 pm',
        endTime: '5:00 pm',
        maxCustomersAllowed: 16,
        bookingsDone: 4,
        date: '18/08/2020',
      ),
      SlotModel(
        startTime: '5:00 pm',
        endTime: '6:00 pm',
        maxCustomersAllowed: 16,
        bookingsDone: 5,
        date: '19/08/2020',
      ),
      SlotModel(
        startTime: '7:00 pm',
        endTime: '8:00 pm',
        maxCustomersAllowed: 20,
        bookingsDone: 0,
        date: '19/08/2020',
      ),
      SlotModel(
        startTime: '10:00 am',
        endTime: '11:00 am',
        maxCustomersAllowed: 20,
        bookingsDone: 10,
        date: '21/08/2020',
      ),
      SlotModel(
        startTime: '11:00 am',
        endTime: '12:00 pm',
        maxCustomersAllowed: 20,
        bookingsDone: 15,
        date: '21/08/2020',
      ),
    ]);
  }
}
