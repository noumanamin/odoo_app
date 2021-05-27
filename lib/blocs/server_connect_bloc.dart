import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/events/login_event.dart';
import 'package:odoo_app/events/server_connect_event.dart';
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';
import 'package:odoo_app/resources/repository.dart';
import 'package:odoo_app/states/login_state.dart';
import 'package:odoo_app/states/server_connect_state.dart';

class ServerConnectBloc extends Bloc<ServerConnectEvent, ServerConnectState> {
  Repository _repository = Repository();
  List<String> serverList = [];
  ServerConnectBloc(ServerConnectState initialState) : super(initialState);

  @override
  Stream<ServerConnectState> mapEventToState(ServerConnectEvent event) async* {
    if (event is ServerConnect) {
      yield ServerConnectProcessState();
      Either<ErrorModel, SuccessModel> result =
          await _repository.connectWithServer(body: event.body);
      yield result.fold((l) => ServerConnectErrorState(errorModel: l),
          (r) => ServerConnectSuccessState(successModel: r));
    }
  }
}
