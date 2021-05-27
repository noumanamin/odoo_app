import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/blocs/contact_bloc.dart';
import 'package:odoo_app/remote_models/helpdesk/help_desk_model.dart';
import 'package:odoo_app/remote_models/partners/partner_model.dart';

class HelpDeskScreen extends StatefulWidget {
  @override
  _HelpDeskScreenState createState() => _HelpDeskScreenState();
}

class _HelpDeskScreenState extends State<HelpDeskScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    ContactBloc provider = BlocProvider.of<ContactBloc>(context);
    List<HelpDeskModel> helpDeskModel = provider.helpDeskModel;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        color: Colors.white,
        child: ListView.builder(
            itemCount: helpDeskModel.length,
            itemBuilder: (cxt, index) {
              return Card(
                elevation: 8,
                margin: EdgeInsets.only(
                    top: index == 0 ? 12 : 8, left: 12, right: 12),
                child: Container(
                  padding: EdgeInsets.all(12),
                  child: Row(
                    children: [
                      CircleAvatar(
                        child: Text(helpDeskModel[index].name![0]),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            helpDeskModel[index].name!,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            helpDeskModel[index].email! is bool
                                ? "N/A"
                                : helpDeskModel[index].email!,
                            style: TextStyle(fontSize: 12, color: Colors.grey),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
    );
  }
}
