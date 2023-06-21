import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with WidgetsBindingObserver {
  ///statusBar设置为透明，去除半透明遮罩,状态栏字体黑色 dark ,白色light
  final SystemUiOverlayStyle _style = const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  );

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      init();
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(_style);
    return ScreenUtilInit(
      designSize: const Size(750, 1624),
      builder: (context, child) => MaterialApp(
        // navigatorKey: navigatorState,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.red,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        // localizationsDelegates: const [
        //   GlobalMaterialLocalizations.delegate,
        //   GlobalWidgetsLocalizations.delegate,
        //   GlobalCupertinoLocalizations.delegate,
        //   DefaultCupertinoLocalizations.delegate,
        // ],
        // supportedLocales: const [
        //   Locale('zh'),
        //   Locale('en'),
        // ],
        // locale: const Locale("zh"),
        home: homeWidget(),
        // navigatorObservers: [TrackerRouteObserverProvider.of(context)!],
        onGenerateRoute: (setting) {
          Uri uri = Uri.parse(setting.name!);
          String route = uri.path;
          return null;
          // switch (route) {
          //   default:
          //     return MaterialPageRoute(
          //         builder: (context) => WidgetNotFound());
          // }
        },
      ),
    );
  }

  void init() {}

  homeWidget() {
    return const HomePage();
  }
}
