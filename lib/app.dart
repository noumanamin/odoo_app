import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:odoo_app/blocs/auth_bloc.dart';
import 'package:odoo_app/blocs/contact_bloc.dart';
import 'package:odoo_app/blocs/login_bloc.dart';
import 'package:odoo_app/blocs/register_bloc.dart';
import 'package:odoo_app/blocs/server_connect_bloc.dart';
import 'package:odoo_app/constants/odoo_singleton.dart';
import 'package:odoo_app/models/home_dashboard.dart';
import 'package:odoo_app/routes.dart';
import 'package:odoo_app/states/auth_state.dart';
import 'package:odoo_app/states/contact_state.dart';
import 'package:odoo_app/states/login_state.dart';
import 'package:odoo_app/states/register_state.dart';
import 'package:odoo_app/states/server_connect_state.dart';
import 'package:odoo_app/ui/screens/connect_with_server.dart';
import 'package:odoo_app/ui/screens/home_screen.dart';
import 'package:odoo_app/ui/screens/login_screen.dart';
import 'package:odoo_app/ui/screens/menu_detail_screen.dart';
import 'package:odoo_app/ui/screens/splash_screen.dart';
import 'package:odoo_app/ui/screens/tab_bar_screen.dart';
import 'package:odoo_app/ui/screens/wire_frame_screen.dart';
import 'package:odoo_app/ui/widgets/global_listener.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import 'constants/colors.dart';

GlobalKey<NavigatorState>? navigatorKey;

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  dynamic _initEasyLoading() {
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 1500)
      ..indicatorType = EasyLoadingIndicatorType.dualRing
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 40.0
      ..radius = 10.0
      ..successWidget = Icon(
        MaterialCommunityIcons.check_circle_outline,
        color: Colors.green,
        size: 50,
      )
      ..errorWidget = Icon(
        MaterialCommunityIcons.close_circle_outline,
        color: Colors.red,
        size: 50,
      )
      ..infoWidget = Icon(
        MaterialCommunityIcons.information_outline,
        color: Colors.lightBlueAccent,
        size: 50,
      )
      ..progressColor = kPrimaryColor
      ..maskType = EasyLoadingMaskType.custom
      ..backgroundColor = Colors.white
      ..indicatorColor = kPrimaryColor
      ..toastPosition = EasyLoadingToastPosition.bottom
      ..textColor = kDarkTextColor
      ..fontSize = 14
      ..maskColor = Colors.black.withOpacity(0.4)
      ..userInteractions = false
      ..dismissOnTap = false;

    return EasyLoading.init();
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      new FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    navigatorKey = GlobalKey<NavigatorState>();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: kPrimaryColor,
        systemNavigationBarIconBrightness: Brightness.light));

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(AuthInitialState())),
        BlocProvider<LoginBloc>(
            create: (context) => LoginBloc(LoginInitialState())),
        BlocProvider<RegisterBloc>(
            create: (context) => RegisterBloc(RegisterInitialState())),
        BlocProvider<ServerConnectBloc>(
            create: (context) =>
                ServerConnectBloc(ServerConnectInitialState())),
        BlocProvider<ContactBloc>(
            create: (context) => ContactBloc(ContactInitialState())),
      ],
      child: GlobalListener(
        child: ScreenUtilInit(
          designSize: Size(360, 690),
          allowFontScaling: false,
          builder: () => MaterialApp(
            navigatorKey: navigatorKey,
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: kPrimaryColor,
              accentColor: kAccentColor,
            ),
            builder: _initEasyLoading(),
            initialRoute: Routes.splashScreen,
            onGenerateRoute: (settings) {
              switch (settings.name) {
                case Routes.splashScreen:
                  return PageTransition(
                      child: SplashScreen(),
                      //type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                case Routes.connectWithServer:
                  return PageTransition(
                      child: ConnectWithServer(),
                      //type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                case Routes.home:
                  return PageTransition(
                      child: HomeScreen(),
                      //type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                case Routes.loginScreen:
                  return PageTransition(
                      child: LoginScreen(),
                      //type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                case Routes.wireFrameScreen:
                  return PageTransition(
                      child: WireFrameScreen(),
                      //type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                case Routes.tabBarScreen:
                  return PageTransition(
                      child: TabBarScreen(),
                      //type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);
                case Routes.menuDetail:
                  HomeDashboard? dashboard =
                      settings.arguments as HomeDashboard?;
                  return PageTransition(
                      child: MenuDetailScreen(
                        arguments: dashboard,
                      ),
                      // type: PageTransitionType.rightToLeftWithFade,
                      settings: settings);

                default:
                  return null;
              }
            },
          ),
        ),
      ),
    );
  }
}
//9646 y