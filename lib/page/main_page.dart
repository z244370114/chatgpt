import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';

import '../generated/l10n.dart';
import '../network/model/chat_model.dart';
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

  final getStorage = GetStorage("zyChatGpt");

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
          colorSchemeSeed: Colors.purple,
          appBarTheme: const AppBarTheme(centerTitle: true),
        ),
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          S.delegate,
        ],
        supportedLocales: S.delegate.supportedLocales,
        home: homeWidget(),
        onGenerateRoute: (setting) {
          Uri uri = Uri.parse(setting.name!);
          String route = uri.path;
          return null;
        },
      ),
    );
  }

  void init() {}

  homeWidget() {
    return const HomePage();
  }
}
