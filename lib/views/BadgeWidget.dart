import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BadgeWidget extends StatelessWidget {
  final double top;
  final double right;
  final Widget child;
  final int value;
  final Color? color;

  BadgeWidget({
    required this.child,
    required this.value,
    required this.top,
    required this.right,
    this.color,

  });


  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        child,
        value == 0
            ? Container()
            : Positioned(
          right: this.right,
          top: this.top,
          child: Container(
            padding: EdgeInsets.all(2.0),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0),
                color: this.color != null ? this.color : Colors.red),
            child: Text(
              value.toString(),
              style: TextStyle(
                fontSize: 10,
                color: Colors.white,
              ),
            ),
          ),
        )
      ],
    );
  }}
