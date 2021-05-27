import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:odoo_app/blocs/contact_bloc.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/remote_models/partners/partner_model.dart';

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    return OrientationBuilder(builder: (cxt,orientation){
      ContactBloc provider = BlocProvider.of<ContactBloc>(context);
      PartnerModel partnerModel = provider.partnerModel;
      double? h = orientation == Orientation.portrait ? height : width;
      double? w = orientation == Orientation.portrait ? width : height;
      return Scaffold(
        body: Container(
          padding: EdgeInsets.only(
            left: 12,
            right: 12,
          ),
          color: Colors.white,
          child: ListView.builder(
              itemCount: partnerModel.result!.length,
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
                          child: Text(partnerModel.result![index].name![0]),
                        ),
                        SizedBox(
                          width: 12,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              partnerModel.result![index].name!,
                              style: TextStyle(fontSize: 16),
                            ),
                            Text(
                              partnerModel.result![index].mobile!,
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
    });
  }
}
