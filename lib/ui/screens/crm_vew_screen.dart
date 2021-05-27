import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/blocs/contact_bloc.dart';
import 'package:odoo_app/remote_models/crm/crm_model.dart';

class CrmViewScreen extends StatefulWidget {
  @override
  _CrmViewScreenState createState() => _CrmViewScreenState();
}

class _CrmViewScreenState extends State<CrmViewScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    ContactBloc provider = BlocProvider.of<ContactBloc>(context);
    List<CrmModel> crmList = provider.crmModelList;
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(
          left: 12,
          right: 12,
        ),
        color: Colors.white,
        child: ListView.builder(
            itemCount: crmList.length,
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
                        child: Text(crmList[index].name![0]),
                      ),
                      SizedBox(
                        width: 12,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            crmList[index].name!,
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            crmList[index].userEmail! is bool
                                ? "N/A"
                                : crmList[index].userEmail!,
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
