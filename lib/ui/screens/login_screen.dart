import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_app/base.dart';
import 'package:odoo_app/blocs/auth_bloc.dart';
import 'package:odoo_app/blocs/login_bloc.dart';
import 'package:odoo_app/blocs/server_connect_bloc.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/constants/odoo_singleton.dart';
import 'package:odoo_app/constants/strings.dart';
import 'package:odoo_app/constants/styles.dart';
import 'package:odoo_app/events/auth_event.dart';
import 'package:odoo_app/events/login_event.dart';
import 'package:odoo_app/remote_models/login/user_login_model.dart';
import 'package:odoo_app/states/login_state.dart';
import 'package:odoo_app/ui/widgets/custom_container.dart';
import 'package:odoo_app/ui/widgets/dark_container.dart';
import 'package:odoo_app/ui/widgets/my_button.dart';
import 'package:odoo_app/ui/widgets/my_text_field.dart';

import '../../routes.dart';
import '../../user_session.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends Base<LoginScreen> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  List<String> serverList = [];
  String? _selectedValue;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    serverList = BlocProvider.of<ServerConnectBloc>(context).serverList;
    passwordController.text = "admin123!@#";
    emailController.text = "admin";
    OdooSingleton().context = context;

    return OrientationBuilder(builder: (cxt,orientation){
      double? h = orientation == Orientation.portrait ? height : width;
      double? w = orientation == Orientation.portrait ? width : height;
      return BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginWithEmailProcessState) {
            EasyLoading.show(status: "Please wait..", dismissOnTap: true);
          } else if (state is LoginWithEmailSuccessState) {
            // BlocProvider.of<AuthBloc>(context).add(LoggedIn(
            //     userId: state.successModel.data["userID"],
            //     accessToken: state.successModel.data["access_token"],
            //     refreshToken: state.successModel.data["refresh_token"],
            //     expiryTime: state.successModel.data["expires_in"]));
            EasyLoading.dismiss();
            UserLoginModel model =
            UserLoginModel.fromJson(state.successModel!.data);
            BlocProvider.of<LoginBloc>(context).loginModel = model;

            Navigator.of(context).pushReplacementNamed(Routes.home, arguments: 1);
          } else if (state is LoginWithEmailErrorState) {
            EasyLoading.showError(state.errorModel!.title,
                duration: Duration(seconds: 2));
          }
        },
        child: Scaffold(
          body: Form(
            key: formKey,
            child: Container(
              width: w,
              height: h,
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
              child: ListView(
                children: [
                  SizedBox(
                    height: h! * 0.18,
                  ),
                  Image.asset(
                    'assets/images/app_logo.png',
                    height: h * 0.07,
                    color: Colors.white,
                  ),
                  SizedBox(
                    height: h * 0.06,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    padding: EdgeInsets.only(left: 12, right: 12),
                    width: w,
                    height: h * 0.07,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                            offset: Offset(2, 4), // Shadow position
                          ),
                        ]),
                    child: DropdownButton(
                      hint: Text('Please choose a database'),
                      // Not necessary for Option 1
                      isExpanded: true,
                      underline: Container(
                        width: 100,
                        height: 1,
                        color: Colors.transparent,
                      ),
                      value: _selectedValue,
                      onChanged: (newValue) {
                        setState(() {
                          _selectedValue = newValue as String?;
                        });
                      },
                      items: serverList.map((location) {
                        return DropdownMenuItem(
                          child: new Text(location),
                          value: location,
                        );
                      }).toList(),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.025,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 24, right: 24),
                      width: w,
                      height: h * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 4,
                              offset: Offset(2, 4), // Shadow position
                            ),
                          ]),
                      child: MyTextField(
                        hintText: "Your email address",
                        controller: emailController,
                        onTextChange: (value) {},
                        validator: "Please enter your email address",
                        textInputAction: TextInputAction.next,
                        sufixIcon: Icon(
                          Icons.person_outline,
                          color: iconColor,
                        ),
                      )),
                  SizedBox(
                    height: h * 0.025,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 24, right: 24),
                      width: w,
                      height: h * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(4),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.5),
                              blurRadius: 4,
                              offset: Offset(2, 4), // Shadow position
                            ),
                          ]),
                      child: MyTextField(
                        hintText: "Your password",
                        obscureText: true,
                        textInputAction: TextInputAction.done,
                        controller: passwordController,
                        onTextChange: (value) {},
                        validator: "Please enter your password",
                        sufixIcon: Icon(
                          Icons.lock_outlined,
                          color: iconColor,
                        ),
                      )),
                  SizedBox(
                    height: h * 0.04,
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    width: w,
                    height: h * 0.07,
                    decoration: BoxDecoration(
                        color: colorGreen,
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.5),
                            blurRadius: 4,
                            offset: Offset(2, 4), // Shadow position
                          ),
                        ]),
                    child: MaterialButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        _selectedValue = _selectedValue ?? "";
                        if (_selectedValue!.isEmpty) {
                          showMessage(
                              "Alert", "Please select database from list");
                          return;
                        }
                        if (!formKey.currentState!.validate()) {
                          return;
                        }

                        final Map<String, String> _body = {
                          'database': _selectedValue!,
                          "username": emailController.text,
                          "password": passwordController.text,
                        };
                        BlocProvider.of<LoginBloc>(context)
                            .add(LoginWithEmail(body: _body));
                      },
                      child: Text(
                        "LOGIN",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: h * 0.06,
                  ),
                  Container(
                    width: w,
                    alignment: Alignment.center,
                    child: Text(
                      "Create an account",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
