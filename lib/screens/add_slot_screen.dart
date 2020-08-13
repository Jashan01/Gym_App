import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class AddSlotScreen extends StatefulWidget {
  static void show(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => AddSlotScreen(),
    ));
  }

  @override
  _AddSlotScreenState createState() => _AddSlotScreenState();
}

class _AddSlotScreenState extends State<AddSlotScreen> {
  String _startTime = '00:00';
  String _endTime = '00:00';
  int _maximumCustomersAllowed = 0;

  String _timeToString(TimeOfDay time) {
    String timeString;

    if (time == null) {
      return '00:00';
    }

    if (time.hour < 12) {
      timeString = time.minute > 9
          ? '${time.hour}:${time.minute} am'
          : '${time.hour}:0${time.minute} am';
    } else if (time.hour >= 12 && time.hour < 24) {
      timeString = time.minute > 9
          ? '${time.hour - 12}:${time.minute} pm'
          : '${time.hour - 12}:0${time.minute} pm';
    }
    return timeString;
  }

  Future<void> _pickTime(int identifier) async {
    TimeOfDay time =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    setState(() {
      if (identifier == 1) {
        _startTime = _timeToString(time);
      } else if (identifier == 2) {
        _endTime = _timeToString(time);
      }
    });
  }

  void _pickNumber() {
    showDialog<int>(
        context: context,
        builder: (BuildContext context) {
          return NumberPickerDialog.integer(
            minValue: 0,
            maxValue: 99,
            title: new Text("Select maximum members"),
            initialIntegerValue: _maximumCustomersAllowed,
          );
        }).then((value) {
      if (value != null) {
        setState(() {
          _maximumCustomersAllowed = value;
        });
      } else {
        setState(() {
          _maximumCustomersAllowed = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          'New Slot',
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
        actions: [
          FlatButton(
            child: Icon(
              Icons.done,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Form(
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    title: Text(
                      'Start Time',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      _startTime,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: () => _pickTime(1),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    title: Text(
                      'End Time',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      _endTime,
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: () => _pickTime(2),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.blueGrey[700],
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.all(Radius.circular(4)),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  child: ListTile(
                    title: Text(
                      'Maximum Customers Allowed',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Text(
                      '$_maximumCustomersAllowed',
                      style: TextStyle(
                        fontSize: 17,
                      ),
                    ),
                    onTap: () => _pickNumber(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
