

import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';

abstract class LoginState{

}

class LoginInitialState extends LoginState{

}

class LoginWithEmailProcessState extends LoginState{

}

class LoginWithEmailSuccessState extends LoginState{
  final SuccessModel? successModel;

  LoginWithEmailSuccessState({
    this.successModel});
}

class LoginWithEmailErrorState extends LoginState{
  final ErrorModel? errorModel;

  LoginWithEmailErrorState({
    this.errorModel});
}



