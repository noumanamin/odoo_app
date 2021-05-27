import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/ui/screens/login_screen.dart';
import 'package:odoo_app/ui/screens/register_screen.dart';

class TabBarScreen extends StatefulWidget {
  @override
  _TabBarScreenState createState() => _TabBarScreenState();
}

class _TabBarScreenState extends State<TabBarScreen> {

  @override
  Widget build(BuildContext context) {
    int _selectedPage = ModalRoute.of(context)!.settings.arguments as int;
    return DefaultTabController(
      length: 2,
      initialIndex: _selectedPage,
      child: Scaffold(
        bottomNavigationBar: Container(
          color: kPrimaryColor,
          child: TabBar(
            unselectedLabelColor: kWhiteColor,
            onTap: (index) {
              print(index);
            },

            indicatorColor: kAccentColor,
            labelColor: kAccentColor,
            labelStyle: TextStyle(fontSize: 14.sp,fontWeight: FontWeight.w600),
            tabs: [
              Tab(
                // icon: Icon(Icons.menu_outlined),
                text: "Log In",
              ),
              Tab(
                // icon: Icon(Icons.album_sharp),
                text: "Sign Up",
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginScreen(),
            RegisterScreen()

          ],
        ),
      ),
    );
  }
}
