import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/events/login_event.dart';
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';
import 'package:odoo_app/remote_models/login/user_login_model.dart';
import 'package:odoo_app/resources/repository.dart';
import 'package:odoo_app/states/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  Repository _repository = Repository();
  late UserLoginModel loginModel;

  LoginBloc(LoginState initialState) : super(initialState);

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginWithEmail) {
      yield LoginWithEmailProcessState();
      Either<ErrorModel, SuccessModel> result =
      await _repository.loginWithEmail(body: event.body);
      yield result.fold((l) => LoginWithEmailErrorState(errorModel: l),
              (r) => LoginWithEmailSuccessState(successModel: r));
    }
  }
}
