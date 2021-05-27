import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:odoo_app/blocs/register_bloc.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/strings.dart';
import 'package:odoo_app/constants/styles.dart';
import 'package:odoo_app/events/register_event.dart';
import 'package:odoo_app/states/register_state.dart';
import 'package:odoo_app/ui/widgets/dark_container.dart';
import 'package:odoo_app/ui/widgets/my_button.dart';
import 'package:odoo_app/ui/widgets/my_text_field.dart';

import '../../routes.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  String? _firstName;
  String? _lastName;

  String? _email;

  var _formKey = GlobalKey<FormState>();

  bool _autoValidate = false;

  String? _password;

  String? _passwordConfirm;

  bool _isAgreed = false;

  var password = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    bool _portraitMode = _mediaQuery.orientation == Orientation.portrait;

    var _portraitUI = Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 1.sh,
          width: 1.sw,
          child: Image.asset(
            kAuthImage,
            fit: BoxFit.cover,
          ),
        ),
        DarkContainer(),
        Container(
            margin: EdgeInsets.only(top: 40.h),
            height: 40.h,
            child: Image.asset(
              kLogoImage,
              fit: BoxFit.contain,
            )),
        Container(
          margin: EdgeInsets.only(top: 100.h),
          height: 0.86.sh,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(left: 20.w, right: 20.w),
                  decoration: BoxDecoration(
                    color: kWhiteColor.withOpacity(0.8),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      autovalidate: _autoValidate,
                      child: Padding(
                        padding: EdgeInsets.all(20.w),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                "Welcome to Kedu TV",
                                style: kDarkBoldLargeStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 4.h,
                              ),
                              Text(
                                "You need a Kedu account to access entertainment across thousands hours of VOD content and live streaming channels",
                                style: kDarkSmallStyle,
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Text(
                                "First Name",
                                style: kDarkNormalStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              MyTextField(
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Last Name",
                                style: kDarkNormalStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              MyTextField(
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Email",
                                style: kDarkNormalStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              MyTextField(
                                keyboardType: TextInputType.emailAddress,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Password",
                                style: kDarkNormalStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              MyTextField(
                                obscureText: true,
                                controller: password,
                                textInputAction: TextInputAction.next,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Text(
                                "Confirm Password",
                                style: kDarkNormalStyle,
                              ),
                              SizedBox(
                                height: 5.h,
                              ),
                              MyTextField(
                                obscureText: true,
                              ),
                              SizedBox(
                                height: 8.h,
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: Checkbox(
                                        value: _isAgreed,
                                        onChanged: (val) {
                                          setState(() {
                                            _isAgreed = val!;
                                          });
                                        }),
                                  ),
                                  Expanded(
                                      child: Text(
                                    kAgreeToTerms,
                                    style: kDarkSmallStyle,
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                  )),
                                ],
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              MyButton(
                                text: "Register",
                                color: _isAgreed ? kAccentColor : kGreyColor,
                                onPressed: _registerUser,
                              ),
                              SizedBox(
                                height: 16.h,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Already have an account?",
                                    style: kDarkNormalStyle,
                                  ),
                                  SizedBox(
                                    width: 5.w,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed(
                                              Routes.tabBarScreen,
                                              arguments: 0);
                                    },
                                    child: Text(
                                      "Sign In",
                                      style: kDarkBoldNormalStyle.copyWith(
                                          color: kAccentColor),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
    var _horizontalUI = Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          height: 1.sh,
          width: 1.sw,
          child: Image.asset(
            kAuthImage,
            fit: BoxFit.cover,
          ),
        ),
        DarkContainer(),
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 30.h,
              ),
              Container(
                  height: 40.h,
                  child: Image.asset(
                    kLogoImage,
                    fit: BoxFit.contain,
                  )),
              SizedBox(
                height: 16.h,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 100.w),
                decoration: BoxDecoration(
                  color: kWhiteColor.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child: Form(
                  key: _formKey,
                  autovalidate: _autoValidate,
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Welcome to Kedu TV",
                            style: kDarkBoldLargeStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 4.h,
                          ),
                          Text(
                            "You need a Kedu account to access entertainment across thousands hours of VOD content and live streaming channels",
                            style: kDarkSmallStyle,
                            textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Text(
                            "First Name",
                            style: kDarkNormalStyle,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          MyTextField(
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Last Name",
                            style: kDarkNormalStyle,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          MyTextField(
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Email",
                            style: kDarkNormalStyle,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          MyTextField(
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Password",
                            style: kDarkNormalStyle,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          MyTextField(
                            obscureText: true,
                            controller: password,
                            textInputAction: TextInputAction.next,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Text(
                            "Confirm Password",
                            style: kDarkNormalStyle,
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          MyTextField(
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(bottom: 12.h),
                                child: Checkbox(
                                    value: _isAgreed,
                                    onChanged: (val) {
                                      setState(() {
                                        _isAgreed = val!;
                                      });
                                    }),
                              ),
                              Expanded(
                                  child: Text(
                                kAgreeToTerms,
                                style: kDarkSmallStyle,
                                textAlign: TextAlign.center,
                                maxLines: 2,
                              )),
                            ],
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          MyButton(
                            text: "Register",
                            color: _isAgreed ? kAccentColor : kGreyColor,
                            onPressed: _registerUser,
                          ),
                          SizedBox(
                            height: 16.h,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Already have an account?",
                                style: kDarkNormalStyle,
                              ),
                              SizedBox(
                                width: 5.w,
                              ),
                              InkWell(
                                onTap: () {
                                  Navigator.of(context).pushReplacementNamed(
                                      Routes.tabBarScreen,
                                      arguments: 0);
                                },
                                child: Text(
                                  "Sign In",
                                  style: kDarkBoldNormalStyle.copyWith(
                                      color: kAccentColor),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 16.h,
              ),
            ],
          ),
        ),
      ],
    );

    return BlocListener<RegisterBloc, RegisterState>(
      listener: (context, state) {
        if (state is RegisterUserProcessState) {
          EasyLoading.show(status: "Please wait..");
        } else if (state is RegisterUserSuccessState) {
          EasyLoading.showSuccess(state.successModel!.message,
              duration: Duration(seconds: 2));
          Navigator.of(context)
              .pushReplacementNamed(Routes.tabBarScreen, arguments: 0);
        } else if (state is RegisterUserErrorState) {
          EasyLoading.showError(state.errorModel!.title,
              duration: Duration(seconds: 2));
        }
      },
      child: WillPopScope(
        onWillPop: () {
          return Future.value(!EasyLoading.isShow);
        },
        child: Scaffold(
          body: _portraitMode ? _portraitUI : _horizontalUI,
        ),
      ),
    );
  }

  _registerUser() {
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final Map<String, String> _body = {
        "firstname": _firstName!,
        "lastname": _lastName!,
        "email": _email!,
        "password": _password!,
        "password_confirm": _passwordConfirm!,
      };
      BlocProvider.of<RegisterBloc>(context).add(RegisterUser(body: _body));
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }
}
