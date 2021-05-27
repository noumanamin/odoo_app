

import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/events/register_event.dart';
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';
import 'package:odoo_app/resources/repository.dart';
import 'package:odoo_app/states/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent,RegisterState>{

  Repository _repository=Repository();

  RegisterBloc(RegisterState initialState) : super(initialState);


  @override
  Stream<RegisterState> mapEventToState(RegisterEvent event) async*{
    if(event is RegisterUser){
      yield RegisterUserProcessState();
      Either<ErrorModel,SuccessModel> result = await _repository.registerUser(body: event.body);
      yield result.fold((l) => RegisterUserErrorState(errorModel: l), (r) =>
          RegisterUserSuccessState(successModel: r));
    }
  }
}