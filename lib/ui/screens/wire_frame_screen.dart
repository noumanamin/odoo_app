import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/strings.dart';
import 'package:odoo_app/constants/styles.dart';
import 'package:odoo_app/routes.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WireFrameScreen extends StatefulWidget {
  @override
  _WireFrameScreenState createState() => _WireFrameScreenState();
}

class _WireFrameScreenState extends State<WireFrameScreen> {

  Future<bool> _willPopCallback() async {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text("Confirmation",style: kDarkBoldLargeStyle,),
          content: Text("Are you sure you want to exit?"),
          actions: [
            RaisedButton(
              color: kAccentColor,
              onPressed: (){
                SystemNavigator.pop();
              },child: Text("Yes",style: kButtonStyle,),),
            RaisedButton(
              color: kAccentColor,
              onPressed: (){

                Navigator.of(ctx).pop();
              },child: Text("No",style: kButtonStyle,),),

          ],
        );
      },
    );
    return true; // return true if the route to be popped
  }

  @override
  Widget build(BuildContext context) {

    final _mediaQuery = MediaQuery.of(context);
    bool _portraitMode = _mediaQuery.orientation == Orientation.portrait;

    var _portraitUI = Stack(
      overflow: Overflow.visible,
      children: [

        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Image.asset(kBackgroundImage,fit: BoxFit.cover,),

        ),
        //  DarkContainer(),
        Container(
          height: 1.sh,
          width: 1.sw,
          margin: EdgeInsets.all(24.w),

          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 70.h,
                      child: Image.asset(
                        kLogoImage,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 24.h,),
                  Text(
                    "Music TV, Lifestyle TV and thousands hours of VOD content on your fingertips",
                    style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 10.h,),
                  Divider(
                    color: kAccentColor,
                    thickness: 3,
                    endIndent: 140.sp,
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    children: [
                      Text(
                        "Live TV",
                        style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        color: kAccentColor,
                        height: 15.h,
                        width: 1.w,
                      ),
                      Text(
                        "Videos On Demand",
                        style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.w),
                        color: kAccentColor,
                        height: 15.h,
                        width: 1.w,
                      ),
                      Text(
                        "TV Shows",
                        style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    children: [
                      Container(
                          height: 45.h,
                          width: 140.w,
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () async{
                              Navigator.of(context).pushNamed(Routes.tabBarScreen,arguments: 0);
                            },
                            color: kAccentColor,
                            child: Text(
                              "Sign In",
                              style: kLightBoldNormalStyle,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                          height: 45.h,
                          width: 140.w,
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              // showBarModalBottomSheet(
                              //   shape: RoundedRectangleBorder(
                              //     side: BorderSide.none,
                              //   ),
                              //   duration: Duration(milliseconds: 600,),
                              //   context: context,
                              //   builder: (context) => RegisterScreen(),
                              //   barrierColor: kPrimaryColor,
                              //
                              // );
                              Navigator.of(context).pushNamed(Routes.tabBarScreen,arguments: 1);
                            },
                            color: kWhiteColor.withOpacity(0.3),

                            child: Text(
                              "Register",
                              style: kLightBoldNormalStyle,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                side: BorderSide(color: kWhiteColor)
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  Text(
                    "Or Watch Our Live 4K Music Channel",
                    style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 24.h,),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: kWhiteColor.withOpacity(0.3),
                        ),
                        width: 200.w,
                        height: 45.h,
                        child: Padding(
                          padding:  EdgeInsets.all(14.w),
                          child: Text(
                            "FREE",
                            textAlign: TextAlign.start,
                            style: kLightBoldNormalStyle,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: kWhiteColor,
                        ),
                        height: 45.h,
                        width: 140.w,
                        child: FlatButton(
                          textColor: kAccentColor,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.playChannelScreen,arguments: kMusicTvChannel);
                          },
                          child: Text(
                            "LIVE TV",
                            style: kDarkBoldNormalStyle.copyWith(color: kAccentColor),
                          ),
                        ),
                      ),

                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
        Positioned(
          bottom: -5,
          child: Container(decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.center,
                colors: [
                  kPrimaryColor,
                  Colors.transparent
                ],
                stops: [
                  0.9,
                  0.1
                ]
            ),
          ),
            height: 20.h,
            width: MediaQuery.of(context).size.width,
          ),
        ),
      ],
    );
    var _horizontalUI = Stack(
      children: [
        Container(
            height: double.infinity,
            width: double.infinity,
            child: Image.asset(kBackgroundImage,fit: BoxFit.cover,)),
        // DarkContainer(),
        Container(
          height: double.infinity,
          width: double.infinity,
          margin: EdgeInsets.symmetric(horizontal: 24.w,vertical: 30.h),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      height: 70.h,
                      child: Image.asset(
                        kLogoImage,
                        fit: BoxFit.contain,
                      )),
                  SizedBox(height: 24.h,),
                  Text(
                    "Music TV, Lifestyle TV and thousands hours of VOD content on your fingertips",
                    style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 10.h,),
                  Divider(
                    color: kAccentColor,
                    thickness: 3,
                    endIndent: 350,
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    children: [
                      Text(
                        "Live TV",
                        style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8),
                        color: kAccentColor,
                        height: 15.h,
                        width: 1.w,
                      ),
                      Text(
                        "Videos On Demand",
                        style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 8.h),
                        color: kAccentColor,
                        height: 15.h,
                        width: 1.w,
                      ),
                      Text(
                        "TV Shows",
                        style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  Row(
                    children: [
                      Container(
                          height: 45.h,
                          width: 140.w,
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () async{
                              Navigator.of(context).pushNamed(Routes.tabBarScreen,arguments: 0);
                            },
                            color: kAccentColor,
                            child: Text(
                              "Sign In",
                              style: kLightBoldNormalStyle,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r)),
                          )),
                      SizedBox(
                        width: 10.w,
                      ),
                      Container(
                          height: 45.h,
                          width: 140.w,
                          child: RaisedButton(
                            elevation: 0,
                            onPressed: () {
                              // showBarModalBottomSheet(
                              //   shape: RoundedRectangleBorder(
                              //     side: BorderSide.none,
                              //   ),
                              //   duration: Duration(milliseconds: 600,),
                              //   context: context,
                              //   builder: (context) => RegisterScreen(),
                              //   barrierColor: kPrimaryColor,
                              //
                              // );
                              Navigator.of(context).pushNamed(Routes.tabBarScreen,arguments: 1);
                            },
                            color: kWhiteColor.withOpacity(0.3),

                            child: Text(
                              "Register",
                              style: kLightBoldNormalStyle,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.r),
                                side: BorderSide(color: kWhiteColor)
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 24.h,),
                  Text(
                    "Or Watch Our Live 4K Music Channel",
                    style: kLightBoldNormalStyle.copyWith(fontSize: 15.sp),
                  ),
                  SizedBox(height: 24.h,),
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: kWhiteColor.withOpacity(0.3),
                        ),
                        width: 200.w,
                        height: 45.h,
                        child: Padding(
                          padding: EdgeInsets.all(14.w),
                          child: Text(
                            "FREE",
                            textAlign: TextAlign.start,
                            style: kLightBoldNormalStyle,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.r),
                          color: kWhiteColor,
                        ),
                        height: 45.h,
                        width: 140.w,
                        child: FlatButton(
                          textColor: kAccentColor,
                          onPressed: () {
                            Navigator.pushNamed(context, Routes.playChannelScreen,arguments: kMusicTvChannel);
                          },
                          child: Text(
                            "LIVE TV",
                            style: kDarkBoldNormalStyle.copyWith(color: kAccentColor),
                          ),
                        ),
                      ),

                    ],
                  ),


                ],
              ),
            ),
          ),
        ),
      ],
    );

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: ScreenUtilInit(
        designSize: Size(360, 690),
        allowFontScaling: false,
        builder:()=> Scaffold(
          backgroundColor: kPrimaryColor,
          body:_portraitMode ? _portraitUI :_horizontalUI,
        ),
      ),
    );
  }
}
