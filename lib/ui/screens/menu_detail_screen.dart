import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/models/home_dashboard.dart';
import 'package:odoo_app/remote_models/helpdesk/help_desk_model.dart';
import 'package:odoo_app/ui/screens/contact_screen.dart';
import 'package:odoo_app/ui/screens/crm_vew_screen.dart';
import 'package:odoo_app/ui/screens/help_desk_screen.dart';
import 'package:odoo_app/ui/widgets/photo_hero.dart';

class MenuDetailScreen extends StatefulWidget {
  final HomeDashboard? arguments;

  MenuDetailScreen({Key? key, this.arguments}) : super(key: key);

  @override
  _MenuDetailScreenState createState() => _MenuDetailScreenState();
}

class _MenuDetailScreenState extends State<MenuDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(builder: (cxt, orientation) {
      double? h = orientation == Orientation.portrait ? height : width;
      double? w = orientation == Orientation.portrait ? width : height;
      return Scaffold(
        body: Container(
          height: h,
          width: w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  kPrimaryColor,
                  const Color(0xFF653B5B),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: h! * 0.006,
                ),
                Container(
                  height:
                      orientation == Orientation.portrait ? h * 0.05 : h * 0.15,
                  child: Row(
                    children: [
                      SizedBox(
                        width: orientation == Orientation.portrait
                            ? w! * 0.06
                            : w! * 0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          ios
                              ? Icons.arrow_back_ios_outlined
                              : Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: orientation == Orientation.portrait
                            ? w * 0.06
                            : w * 0.01,
                      ),
                      PhotoHero(
                        photo: widget.arguments!.icon!,
                        width: w * 0.06,
                        height: h * 0.06,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: w * 0.04,
                      ),
                      Center(
                        child: Text(
                          widget.arguments!.title!,
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: h * 0.006,
                ),
                Expanded(
                  child: widget.arguments!.title! == helpdesk
                      ? HelpDeskScreen()
                      : widget.arguments!.title! == contacts
                          ? ContactScreen()
                          : widget.arguments!.title! == crm
                              ? CrmViewScreen()
                              : Container(
                                  width: w,
                                  height: 100,
                                  color: widget.arguments!.color!,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SvgPicture.asset(
                                        widget.arguments!.icon!,
                                        width: w * 0.09,
                                        height: h * 0.09,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: w * 0.02,
                                      ),
                                      Center(
                                        child: Text(
                                          widget.arguments!.title!,
                                          style: TextStyle(
                                              fontSize: 20,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
