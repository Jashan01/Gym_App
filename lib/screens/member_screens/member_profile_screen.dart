import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:gym/utils/constants.dart';
import 'package:image_picker/image_picker.dart';

class MemberProfileScreen extends StatefulWidget {
  @override
  _MemberProfileScreenState createState() => _MemberProfileScreenState();
}

class _MemberProfileScreenState extends State<MemberProfileScreen> {
  bool _isEditable = false;
  File _imageProfile; //import image from database here using init.state

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


  Future<void> _openGallery(BuildContext context) async {
    final _pickedFile =
    await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      _imageProfile = File(_pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _openCamera(BuildContext context) async {
    final _pickedFile =
    await ImagePicker().getImage(source: ImageSource.camera);
    setState(() {
      _imageProfile = File(_pickedFile.path);
    });
    Navigator.of(context).pop();
  }

  Future<void> _showImageChoice() {
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
                onPressed: () => _openGallery(context),
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
                onPressed: () => _openCamera(context),
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
            child: AnimatedContainer(
              height: _isEditable ? 49 : 59,
              duration: Duration(seconds: 1),
              color: Colors.transparent,
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
                        AnimatedContainer(
                          height: 60,
                          color: Colors.transparent,
                          duration: Duration(seconds: 1),
                        ),
                        SizedBox(height: 90),
                      ],
                    ),
                    GestureDetector(
                      onTap: _isEditable
                          ? () => _showImageChoice()
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
                            fit: BoxFit.fill,
                          ),
                        ),
                        child: _decideProfilePhoto(),
                        duration: Duration(seconds: 1),
                      ),
                    ),
                  ],
                ),
                AnimatedContainer(
                    height: _isEditable ? 50 : 40,
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

}
