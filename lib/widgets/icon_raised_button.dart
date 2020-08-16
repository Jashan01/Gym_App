import 'package:flutter/material.dart';
import 'package:gym/widgets/custom_raised_button.dart';

class IconRaisedButton extends CustomRaisedButton {
  IconRaisedButton({
    @required String text,
    @required IconData icon,
    Color color,
    Color textColor,
    VoidCallback onPressed,
  })  : assert(text != null),
        assert(icon != null),
        super(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Icon(icon,size: 30.0,color: Colors.white,),
            Text(
              text,
              style: TextStyle(
                color: textColor,
                fontSize: 15.0,
              ),
            ),
            Opacity(
              opacity: 0.0,
              child: Icon(icon,size: 30.0,color: Colors.white,),
            ),
          ],
        ),
        color: color,
        borderRadius:100,
        onPressed: onPressed,
      );
}

