import 'package:flutter/material.dart';

  Widget sizeBox(double _width, IconData _icon, Function _onpresd) {
    return SizedBox(
      width: _width,
      child: RaisedButton(
          shape: CircleBorder(),
          padding: EdgeInsets.all(0.0),
          color: Colors.grey.shade900,
          elevation: 0.0,
          onPressed: _onpresd,
          child: Icon(
            _icon,
            color: Colors.white,
            size: _width,
          )),
    );
  }
