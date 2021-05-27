
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';

abstract class ServerConnectState{

}

class ServerConnectInitialState extends ServerConnectState{

}

class ServerConnectProcessState extends ServerConnectState{

}

class ServerConnectSuccessState extends ServerConnectState{
  final SuccessModel? successModel;

  ServerConnectSuccessState({
    this.successModel});
}

class ServerConnectErrorState extends ServerConnectState{
  final ErrorModel? errorModel;

  ServerConnectErrorState({
    this.errorModel});
}



