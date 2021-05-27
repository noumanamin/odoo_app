import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/styles.dart';

class MyButton extends StatelessWidget {
  final Function onPressed;
  final String? text;
  final IconData? iconData;
  final Color? color;

  MyButton(
      {required this.onPressed, this.text, this.iconData, this.color = kAccentColor});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        onPressed();
      },
      child: Container(
        alignment: Alignment.center,
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
        ),
        child: iconData != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(iconData),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(text!, style: kButtonStyle)
                ],
              )
            : Text(
                text!,
                style: kButtonStyle,
              ),
      ),
    );
  }
}
