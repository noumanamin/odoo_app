import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/events/auth_event.dart';
import 'package:odoo_app/resources/repository.dart';
import 'package:odoo_app/states/auth_state.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../user_session.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  Repository _repository = Repository();

  AuthBloc(AuthState initialState) : super(initialState);

  @override
  Stream<AuthState> mapEventToState(AuthEvent event) async* {
    if (event is Authenticate) {
      var _accessToken = await UserSession.getAccessToken();
      if (event is Authenticate) {
        if (event.body == serverDataKey) {
          SharedPreferences? sharedPreferences =
              await SharedPreferences.getInstance();
          String userPref = sharedPreferences.getString(serverDataKey) ?? "";
          String serverAddress =
              sharedPreferences.getString(serverAddressKey) ?? "";
          yield SharedPreferencesState(
              result: userPref, serverAddress: serverAddress);
        }
      } else if (_accessToken != null) {
        var _expiryTime = await UserSession.getExpiryTime();
        if (DateTime.now().isAfter(_expiryTime)) {
          yield LoggedOutState();
        } else {
          yield LoggedInState();
        }
      } else if (_accessToken == null) {
        yield AuthDefaultState();
      } else {
        yield AuthDefaultState();
      }
    } else if (event is LoggedIn) {
      await UserSession.persistLoginToken(
          userId: event.userId,
          accessToken: event.accessToken,
          refreshToken: event.refreshToken,
          expiresIn: event.expiryTime);
      yield LoggedInState();
    } else if (event is LoggedOut) {
      yield LoggedOutState();
    }
  }
}
