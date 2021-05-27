import 'package:flutter/material.dart';
import 'package:odoo_app/constants/colors.dart';

class DarkContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,

      color: kPrimaryColor.withOpacity(0.1),
    );
  }
}
