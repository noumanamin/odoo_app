import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';
import 'package:odoo_app/resources/api_provider.dart';

class Repository {
  ApiProvider _apiProvider = ApiProvider();

  Future<Either<ErrorModel, SuccessModel>> registerUser({body}) =>
      _apiProvider.registerUser(body: body);

  Future<Either<ErrorModel, SuccessModel>> loginWithEmail({body}) =>
      _apiProvider.loginWithEmail(body: body);

  Future<Either<ErrorModel, SuccessModel>> connectWithServer({body}) =>
      _apiProvider.connectWithServer(body: body);

  Future<Either<ErrorModel, SuccessModel>> getContactList({body}) =>
      _apiProvider.getContactListFromOdooServer(body: body);
}
