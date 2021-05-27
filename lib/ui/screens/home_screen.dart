import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odoo_app/base.dart';
import 'package:odoo_app/blocs/contact_bloc.dart';
import 'package:odoo_app/blocs/login_bloc.dart';
import 'package:odoo_app/constants/colors.dart';
import 'package:odoo_app/constants/constants_utils.dart';
import 'package:odoo_app/events/contact_event.dart';
import 'package:odoo_app/models/home_dashboard.dart';
import 'package:odoo_app/odoo_helpers/odoo_helpers.dart';
import 'package:odoo_app/odoo_helpers/odoo_response.dart';
import 'package:odoo_app/remote_models/crm/crm_model.dart';
import 'package:odoo_app/remote_models/crm/crm_result.dart';
import 'package:odoo_app/remote_models/helpdesk/api_result.dart';
import 'package:odoo_app/remote_models/helpdesk/help_desk_model.dart';
import 'package:odoo_app/remote_models/partners/partner_model.dart';
import 'package:odoo_app/routes.dart';
import 'package:odoo_app/states/contact_state.dart';
import 'package:odoo_app/ui/widgets/photo_hero.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends Base<HomeScreen> {
  String click = "";
  late HomeDashboard dashboard;
  List<HomeDashboard> dashboardList = [
    HomeDashboard(
        title: website,
        icon: "assets/images/ic_website.svg",
        color: Colors.blue),
    HomeDashboard(
        title: contacts,
        icon: "assets/images/ic_contact.svg",
        color: Colors.red),
    HomeDashboard(
        title: helpdesk,
        icon: "assets/images/ic_helpdesk.svg",
        color: Colors.brown),
    HomeDashboard(
        title: payslip,
        icon: "assets/images/ic_payslip.svg",
        color: Colors.orange),
    HomeDashboard(
        title: employee,
        icon: "assets/images/ic_employee.svg",
        color: Colors.deepOrange),
    HomeDashboard(
        title: crm, icon: "assets/images/ic_crm.svg", color: Colors.green),
  ];

  @override
  Widget build(BuildContext context) {
    LoginBloc provider = BlocProvider.of<LoginBloc>(context);
    OdooResponse? res = menuResponse;
    var results = res!.getResult();
    return OrientationBuilder(builder: (cxt, orientation) {
      double? h = orientation == Orientation.portrait ? height : width;
      double? w = orientation == Orientation.portrait ? width : height;
      return Scaffold(
        body: Container(
          height: h,
          width: w,
          decoration: BoxDecoration(
            gradient: new LinearGradient(
                colors: [
                  kPrimaryColor,
                  const Color(0xFF653B5B),
                ],
                begin: const FractionalOffset(0.0, 0.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp),
          ),
          child: SafeArea(
            child: BlocListener<ContactBloc, ContactState>(
              listener: (cxt, state) {
                if (state is ContactProcessState) {
                  EasyLoading.show(status: "Please wait..", dismissOnTap: true);
                } else if (state is ContactSuccessState) {
                  if (click == contacts) {
                    PartnerModel partnerModel =
                        PartnerModel.fromJson(state.successModel!.data);
                    EasyLoading.dismiss();
                    BlocProvider.of<ContactBloc>(context).partnerModel =
                        partnerModel;
                  } else if (click == helpdesk) {
                    ApiResult result =
                        ApiResult.fromJson(state.successModel!.data);
                    BlocProvider.of<ContactBloc>(context).helpDeskModel =
                        result.result!;
                  } else if (click == crm) {
                    CrmResult result =
                        CrmResult.fromJson(state.successModel!.data);
                    BlocProvider.of<ContactBloc>(context).crmModelList =
                        result.result!;
                  }
                  EasyLoading.dismiss();
                  timeDilation = 4.0;
                  Navigator.pushNamed(
                    context,
                    Routes.menuDetail,
                    arguments: dashboard,
                  );
                } else if (state is ContactErrorState) {
                  EasyLoading.showError(state.errorModel!.title,
                      duration: Duration(seconds: 2));
                }
              },
              child: Column(
                children: [
                  SizedBox(
                    height: h! * 0.18,
                  ),
                  Expanded(
                      child: Container(
                    height: height,
                    child: GridView.count(
                      // Create a grid with 2 columns. If you change the scrollDirection to
                      // horizontal, this produces 2 rows.
                      crossAxisCount: 3,
                      childAspectRatio:
                          orientation == Orientation.portrait ? 3 / 3 : 7 / 3,
                      // Generate 100 widgets that display their index in the List.
                      children: List.generate(dashboardList.length, (index) {
                        return GestureDetector(
                          onTap: () {
                            timeDilation = 1.0;
                            dashboard = dashboardList[index];
                            click = dashboardList[index].title!;
                            final Map<String, String> _body = {
                              "page": click,
                            };

                            BlocProvider.of<ContactBloc>(context)
                                .add(ContactList(body: _body));
                          },
                          child: Column(
                            children: [
                              PhotoHero(
                                photo: dashboardList[index].icon,
                                width: w! * 0.1,
                                height: h * 0.1,
                                color: Colors.white,
                              ),
                              SizedBox(
                                height: h * 0.02,
                              ),
                              Center(
                                child: Text(
                                  dashboardList[index].title!,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                  ))
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
