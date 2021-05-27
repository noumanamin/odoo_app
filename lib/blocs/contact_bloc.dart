import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/events/contact_event.dart';
import 'package:odoo_app/events/login_event.dart';
import 'package:odoo_app/models/error_model.dart';
import 'package:odoo_app/models/success_model.dart';
import 'package:odoo_app/remote_models/crm/crm_model.dart';
import 'package:odoo_app/remote_models/helpdesk/help_desk_model.dart';
import 'package:odoo_app/remote_models/login/user_login_model.dart';
import 'package:odoo_app/remote_models/partners/partner_model.dart';
import 'package:odoo_app/resources/repository.dart';
import 'package:odoo_app/states/contact_state.dart';
import 'package:odoo_app/states/login_state.dart';

class ContactBloc extends Bloc<ContactEvent, ContactState> {
  Repository _repository = Repository();

  late PartnerModel partnerModel;
  late List<HelpDeskModel> helpDeskModel;
  late List<CrmModel> crmModelList;

  // late UserContactModel ContactModel;

  ContactBloc(ContactState initialState) : super(initialState);

  @override
  Stream<ContactState> mapEventToState(ContactEvent event) async* {
    if (event is ContactList) {
      yield ContactProcessState();
      Either<ErrorModel, SuccessModel> result =
          await _repository.getContactList(body: event.body);
      yield result.fold((l) => ContactErrorState(errorModel: l),
          (r) => ContactSuccessState(successModel: r));
    }
  }
}
