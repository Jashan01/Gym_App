import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gym/models/slot_model.dart';
import 'package:gym/screens/past_bookings_screen.dart';
import 'package:gym/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditable = false;
  File _imageProfile; //import image from database here using init.state
  File _imageGym; //import image from database here using init.state

  Widget _decideProfilePhoto() {
    if (_imageProfile == null) {
      return Icon(
        Icons.person,
        size: 130,
      );
    } else {
      return Container();
    }
  }

  Widget _decideGymPhoto() {
    if (_imageGym == null) {
      return Icon(
        Icons.location_city,
        size: 200,
      );
    } else {
      return Image.file(
        _imageGym,
        fit: BoxFit.fitWidth,
      );
    }
  }

  Future<void> _openGallery(BuildContext context, String identifier) async {
    final _pickedFile =
        await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (identifier == 'profile') {
        _imageProfile = File(_pickedFile.path);
      } else if (identifier == 'gym') {
        _imageGym = File(_pickedFile.path);
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera(BuildContext context, String identifier) async {
    final _pickedFile =
        await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      if (identifier == 'profile') {
        _imageProfile = File(_pickedFile.path);
      } else if (identifier == 'gym') {
        _imageGym = File(_pickedFile.path);
      }
    });
    Navigator.of(context).pop();
  }

  Future<void> _showImageChoice(String identifier) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Choose Image Source',
            textAlign: TextAlign.center,
          ),
          content: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FlatButton(
                child: Text(
                  'Gallery',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(Constants.BASE_COLOR),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _openGallery(context, identifier),
              ),
              FlatButton(
                child: Text(
                  'Camera',
                  style: TextStyle(
                    fontSize: 18,
                    color: Color(Constants.BASE_COLOR),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onPressed: () => _openCamera(context, identifier),
              )
            ],
          ),
        );
      },
    );
  }

  BoxShadow _isEditableShadow() {
    return BoxShadow(
      color: Colors.black,
      blurRadius: 6,
      spreadRadius: 10,
      offset: Offset(0, 10),
    );
  }

  Future<String> _pickDate(BuildContext context) async {
    DateTime dateTime = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2050));
    if (dateTime != null) {
      String date = dateTime.toString();
      return '${date.substring(8, 10)}/${date.substring(5, 7)}/${date.substring(0, 4)}';
    } else {
      return null;
    }
  }

  Future<void> _seePastBookings(BuildContext context) async {
    String date = await _pickDate(context);
    if (date != null) {
      PastBookingsScreen.show(context, slotsStream: slotsStream(), date: date);
    }
  }

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
                  'Profile',
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
              Icons.exit_to_app,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {}, //Logout button to be implementer
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _isEditable = _isEditable ? false : true;
          });
        },
        child: Icon(_isEditable ? Icons.done : Icons.edit),
        backgroundColor: Color(Constants.BASE_COLOR),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            flex: 0,
            child: GestureDetector(
              onTap: () =>
                  _seePastBookings(context), //pass identifier owner or member
              child: AnimatedContainer(
                height: _isEditable ? 49 : 59,
                duration: Duration(seconds: 1),
                color: Colors.black54,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'See Past Bookings',
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
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GestureDetector(
                          onTap: _isEditable
                              ? () => _showImageChoice('gym')
                              : () {},
                          child: AnimatedContainer(
                            height: 200,
                            child: _decideGymPhoto(),
                            decoration: BoxDecoration(
                              color: Colors.blueGrey,
                              boxShadow:
                                  _isEditable ? [_isEditableShadow()] : [],
                            ),
                            duration: Duration(seconds: 1),
                          ),
                        ),
                        SizedBox(height: 90),
                      ],
                    ),
                    GestureDetector(
                      onTap: _isEditable
                          ? () => _showImageChoice('profile')
                          : () {},
                      child: AnimatedContainer(
                        padding: EdgeInsets.all(10.0),
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          color: Color(Constants.BASE_COLOR),
                          shape: BoxShape.circle,
                          boxShadow: !_isEditable
                              ? [
                                  BoxShadow(
                                      color: Colors.black54,
                                      blurRadius: 5,
                                      spreadRadius: 3,
                                      offset: Offset(0, 4)),
                                ]
                              : [_isEditableShadow()],
                          image: _imageProfile == null
                              ? null
                              : DecorationImage(
                                  image: FileImage(_imageProfile),
                                  fit: BoxFit.fitWidth,
                                ),
                        ),
                        child: _decideProfilePhoto(),
                        duration: Duration(seconds: 1),
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                    height: _isEditable ? 40 : 30,
                    duration: Duration(seconds: 1)),
                Text(
                  'Name: Gym Owner', //import name of gym owner
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text(
                  'Contact: 978654321', //import number of gym owner
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
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
