

import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';

abstract class RegisterState{

}

class RegisterInitialState extends RegisterState{

}

class RegisterUserProcessState extends RegisterState{

}

class  RegisterUserSuccessState extends RegisterState{
  final SuccessModel? successModel;
  RegisterUserSuccessState({
    this.successModel});
}

class  RegisterUserErrorState extends RegisterState{
  final ErrorModel? errorModel;

  RegisterUserErrorState({
    this.errorModel});
}


