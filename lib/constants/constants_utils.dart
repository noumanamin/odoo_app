import 'package:odoo_app/constants/odoo_singleton.dart';
import 'dart:io' show Platform;

double? height = OdooSingleton().height;
double? width = OdooSingleton().width;

String UID = "uid";
String SESSION_ID = "session_id";
String USER_PREF = "UserPrefs";
String ODOO_URL = "odooUrl";
String SESSION = "session";
String PERSON_ID = "person_id";
String serverDataKey = "serverKataKey";
String serverAddressKey = "serverAddressKey";

bool ios = Platform.isIOS ? true : false;
String website = 'Website';
String contacts = 'Contacts';
String helpdesk = 'Helpdesk';
String payslip = 'Payslip';
String employee = 'Employee';
String crm = 'CRM';
