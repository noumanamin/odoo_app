import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:http/http.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/constants/odoo_singleton.dart';
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';
import 'package:odoo_app/odoo_helpers/odoo_helpers.dart';
import 'package:odoo_app/base.dart';
import 'package:odoo_app/odoo_helpers/odoo_response.dart';

class ApiProvider {
  final String _baseBannerUrl =
      "https://api.kedutv.com/public/index.php/banners/sections";

  Odoo? odoo;
  Client _client = Client();

  Future<Either<ErrorModel, SuccessModel>> registerUser({body}) async {
    Response response =
        await _client.post("${OdooSingleton().baseUrl} /register",
            body: body,
            headers: {
              HttpHeaders.authorizationHeader:
                  "Basic a2VkdXR2YW5kcm9pZGNsaWVudDo3NmExMzYxOTM0ZTZjYmVjMGMxMDY4NGExOWI4MWY2NQ==",
              "content-type": "application/x-www-form-urlencoded",
            },
            encoding: Encoding.getByName("utf-8"));
    var parsedBody = jsonDecode(response.body);

    if (response.statusCode == 200 && parsedBody["code"] == "321a") {
      return right(
          SuccessModel(title: "Success", message: parsedBody["message"]));
    } else if (parsedBody["status"] == 400 && parsedBody["error"] == 400) {
      return left(ErrorModel(title: parsedBody["messages"]["email"]));
    } else {
      return left(ErrorModel(title: "Error"));
    }
  }

  Future<Either<ErrorModel, SuccessModel>> loginWithEmail({body}) async {
    String username = body['username'];
    String password = body['password'];
    String database = body['database'];

    odoo = new Odoo(url: OdooSingleton().baseUrl);
    Response response = await odoo!.authenticate(username, password, database);
    var parsedBody = jsonDecode(response.body);

    if (response.statusCode == 200) {
      if (parsedBody["status"] == 200 && parsedBody["code"] == "321a") {
        return left(ErrorModel(title: parsedBody["message"]));
      } else if (parsedBody["status"] == 200 && parsedBody["code"] == "321b") {
        return left(ErrorModel(title: parsedBody["message"]));
      } else {
        return right(SuccessModel(title: "Success", data: parsedBody));
      }
    } else if (parsedBody["error"] == "invalid_grant") {
      return left(ErrorModel(title: parsedBody["error_description"]));
    } else {
      return left(ErrorModel(title: "Error"));
    }
  }

  Future<Either<ErrorModel, SuccessModel>> connectWithServer({body}) async {
    String server = body['server'];

    odoo = new Odoo(url: server);
    var response = await odoo!.getDatabases();
    var parsedBody = jsonDecode(response.body);
    if (response.statusCode == 200) {
      OdooSingleton().baseUrl = server;
      return right(SuccessModel(title: "Success", data: parsedBody));
    } else {
      return left(ErrorModel(title: "Error"));
    }
  }

  Future<Either<ErrorModel, SuccessModel>> getContactListFromOdooServer(
      {body}) async {
    String page = body['page'];

    odoo = new Odoo(url: OdooSingleton().baseUrl);
    OdooResponse? response;
    if (page == contacts) {
      response = await odoo!.callKW('res.partner', "search_read", []);
    } else if (page == helpdesk) {
      response = await odoo!.callKW('helpdesk.ticket', "search_read", []);
    } else if (page == crm) {
      var res = await odoo!.callKW('res.company', "search_read", []);
      int id = res.getResult()[0]['id'];
      response = await odoo!.read("crm.lead", [id], []);
    }
    if (response == null) {
      return left(ErrorModel(title: "Data not found!!"));
    }
    json.encode(response.getResult());
    var parsedBody = response.getResult();
     if (response.getStatusCode() == 200 &&
        response.getResult() != null) {
      return right(SuccessModel(title: "Success", data: parsedBody));
    } else {
      return left(ErrorModel(title: "Data not found!!"));
    }
  }
}
