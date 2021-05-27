import 'dart:convert';

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
import 'package:odoo_app/events/server_connect_event.dart';
import 'package:odoo_app/remote_models/server_result.dart';
import 'package:odoo_app/states/login_state.dart';
import 'package:odoo_app/states/server_connect_state.dart';
import 'package:odoo_app/ui/widgets/custom_container.dart';
import 'package:odoo_app/ui/widgets/dark_container.dart';
import 'package:odoo_app/ui/widgets/my_button.dart';
import 'package:odoo_app/ui/widgets/my_text_field.dart';

import '../../routes.dart';
import '../../user_session.dart';

class ConnectWithServer extends StatefulWidget {
  @override
  _ConnectWithServerState createState() => _ConnectWithServerState();
}

class _ConnectWithServerState extends Base<ConnectWithServer> {
  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  TextEditingController serverAddress = TextEditingController();
  var _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    serverAddress.text = "https://aqd1-uat100-2551003.dev.odoo.com";
    OdooSingleton().context = context;
    return BlocListener<ServerConnectBloc, ServerConnectState>(
      listener: (context, state) {
        if (state is ServerConnectProcessState) {
          EasyLoading.show(status: "Please wait..", dismissOnTap: true);
        } else if (state is ServerConnectSuccessState) {
          List<String> serverList = [];
          ServerResult result = ServerResult.fromJson(state.successModel!.data);

          for (int index = 0; index < result.result!.length; index++) {
            serverList.add(result.result![index]);
          }
          BlocProvider.of<ServerConnectBloc>(context).serverList = serverList;

          String serverAddress = OdooSingleton().baseUrl;

          var data = json.encode(result.toJson());
          saveData(data: data, key: serverDataKey);
          saveData(data: serverAddress, key: serverAddressKey);
          EasyLoading.dismiss();
          Navigator.of(context).pushReplacementNamed(
              Routes.loginScreen,
              arguments: "1");
        } else if (state is ServerConnectErrorState) {
          EasyLoading.showError(state.errorModel!.title,
              duration: Duration(seconds: 2));
        }
      },
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Container(
            width: width!,
            height: height!,
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
                  height: height! * 0.18,
                ),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: height! * 0.07,
                  color: Colors.white,
                ),
                SizedBox(
                  height: height! * 0.18,
                ),
                Container(
                    margin: EdgeInsets.only(left: 24, right: 24),
                    width: width!,
                    decoration: BoxDecoration(boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 4,
                        offset: Offset(2, 4), // Shadow position
                      ),
                    ]),
                    child: MyTextField(
                        hintText: "Enter server address",
                        controller: serverAddress,
                        textInputAction: TextInputAction.next,
                        sufixIcon: Icon(
                          FontAwesome.globe,
                          color: iconColor,
                        ),
                        validator: "Please enter server address")),
                SizedBox(
                  height: height! * 0.025,
                ),
                Container(
                  margin: EdgeInsets.only(left: 24, right: 24),
                  width: width!,
                  height: height! * 0.07,
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
                      if (!_formKey.currentState!.validate()) {
                        return;
                      }

                      final Map<String, String> _body = {
                        "server": serverAddress.text,
                      };

                      BlocProvider.of<ServerConnectBloc>(context)
                          .add(ServerConnect(body: _body));
                    },
                    child: Text(
                      "Connect with Server",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
