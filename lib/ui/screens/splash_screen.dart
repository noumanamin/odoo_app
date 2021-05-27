import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:odoo_app/blocs/auth_bloc.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/constants/strings.dart';
import 'package:odoo_app/events/auth_event.dart';
import 'package:odoo_app/ui/widgets/dark_container.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 4), () {
      BlocProvider.of<AuthBloc>(context).add(Authenticate(body: serverDataKey));
    });

    final _mediaQuery = MediaQuery.of(context);

    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Stack(
        alignment: Alignment.center,
        overflow: Overflow.visible,
        children: [
          DarkContainer(),
          Center(
            child: Container(
              height: MediaQuery.of(context).size.height * 0.3,
              width: 120.w,
              child: Image.asset(
                'assets/images/app_logo.png',
                fit: BoxFit.contain,
                color: Colors.white,
              ),
            ),
          ),
          Positioned(
            bottom: -5,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.center,
                    colors: [kPrimaryColor, Colors.transparent],
                    stops: [0.9, 0.1]),
              ),
              height: 20,
              width: MediaQuery.of(context).size.width,
            ),
          ),
        ],
      ),
    );
  }
}
