import 'package:flutter/material.dart';
import 'package:gym/utils/constants.dart';

class FilterScreen extends StatefulWidget {
  static void show(BuildContext context) {
    Navigator.of(context).push(MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => FilterScreen(),
    ));
  }

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool _all =true;
  bool _today = false;
  bool _tomorrow = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
        title: Text(
          'Filter By',
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
      body: Column(
        children: [
          CheckboxListTile(
            title: Text('All',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),),
            value: _all || !(_today || _tomorrow),
            onChanged: (bool value) {
              setState(() {
                _all= value ? true: false;
                _today=false;
                _tomorrow=false;
              });
            },
            checkColor: Color(Constants.BASE_LIGHT_COLOR),
            activeColor: Colors.white,
          ),
          CheckboxListTile(
            title: Text('Today',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            value: _today,
            onChanged: (bool value) {
              setState(() {
                _today= value ? true: false;
                _all=false;
              });
            },
            checkColor: Color(Constants.BASE_LIGHT_COLOR),
            activeColor: Colors.white,
          ),
          CheckboxListTile(
            title: Text('Tomorrow',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),),
            value: _tomorrow,
            onChanged: (bool value) {
              setState(() {
                _tomorrow= value ? true: false;
                _all=false;
              });
            },
            checkColor: Color(Constants.BASE_LIGHT_COLOR),
            activeColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
