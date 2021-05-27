import 'package:odoo_app/models/error_model.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthProcessState extends AuthState {}

class LoggedInState extends AuthState {}

class LoggedOutState extends AuthState {}

class SharedPreferencesState extends AuthState {
  String? result;
  String? serverAddress;

  SharedPreferencesState({this.result, this.serverAddress});
}

class AuthDefaultState extends AuthState {}

class AuthErrorState extends AuthState {
  final ErrorModel? errorModel;

  AuthErrorState({this.errorModel});
}
