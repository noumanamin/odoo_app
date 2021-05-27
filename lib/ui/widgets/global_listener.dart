import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:odoo_app/app.dart';
import 'package:odoo_app/blocs/auth_bloc.dart';
import 'package:odoo_app/blocs/server_connect_bloc.dart';
import 'package:odoo_app/constants/odoo_singleton.dart';
import 'package:odoo_app/remote_models/server_result.dart';
import 'package:odoo_app/routes.dart';
import 'package:odoo_app/states/auth_state.dart';
import 'package:odoo_app/user_session.dart';

class GlobalListener extends StatelessWidget {
  final child;

  GlobalListener({this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(listeners: [
      BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthDefaultState) {
            Navigator.pushReplacementNamed(
                navigatorKey!.currentContext!, Routes.wireFrameScreen);
          } else if (state is SharedPreferencesState) {
            String? result = state.result;
            String? serverAddress = state.serverAddress;
            if(result!.isEmpty || serverAddress!.isEmpty){
              Navigator.pushNamedAndRemoveUntil(navigatorKey!.currentContext!,
                  Routes.connectWithServer, (Route<dynamic> route) => false,
                  arguments: 0);
            }else{
              var data = json.decode(result);
              ServerResult apiResult = ServerResult.fromJson(data);
              BlocProvider.of<ServerConnectBloc>(context).serverList = apiResult.result!;
              OdooSingleton().baseUrl = serverAddress;
              Navigator.pushNamedAndRemoveUntil(navigatorKey!.currentContext!,
                  Routes.loginScreen, (Route<dynamic> route) => false,
                  arguments: 0);

            }

          } else if (state is LoggedInState) {
            Navigator.pushNamedAndRemoveUntil(navigatorKey!.currentContext!,
                Routes.navigationScreen, (Route<dynamic> route) => false,
                arguments: 0);
          } else if (state is AuthErrorState) {
            EasyLoading.showError(state.errorModel!.message);
            Navigator.pushNamedAndRemoveUntil(navigatorKey!.currentContext!,
                Routes.splashScreen, (route) => false);
          } else if (state is LoggedOutState) {
            UserSession.logout();
            Navigator.pushReplacementNamed(
                navigatorKey!.currentContext!, Routes.wireFrameScreen);
          }
        },
      ),
    ], child: child);
  }
}
