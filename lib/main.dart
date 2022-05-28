import 'dart:io';
import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/memo_page_container.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo_list/memo_list_page_container.dart';
import 'package:window_size/window_size.dart';
import 'logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  debugDefaultTargetPlatformOverride = TargetPlatform.fuchsia;
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isMacOS) {
    //maxのサイズ
    setWindowMaxSize(const Size(double.infinity, double.infinity));
    //mac airのサイズの半分
    setWindowMinSize(const Size(633, 768));
  }

  runApp(
    ProviderScope(
      observers: [ProviderLogger()],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final darkTheme = ThemeData(brightness: Brightness.dark);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        //多言語に対応している
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ja', 'JP'),
        Locale('en', 'EN'),
      ],
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) =>
          AppLocalizations.of(context)?.appTitle ?? "",
      theme: ThemeData(
        brightness: Brightness.light,
      ),
      darkTheme: darkTheme.copyWith(
        indicatorColor: CupertinoColors.black,
        colorScheme: darkTheme.colorScheme.copyWith(
          primary: CupertinoColors.secondarySystemGroupedBackground,
          secondary: CupertinoColors.secondarySystemGroupedBackground,
        ),
      ),
      themeMode: ThemeMode.system,
      routes: {
        '/': (context) => const MemoPageContainer(),
        '/list': (context) => const MemoListPageContainer(),
      },
    );
  }
}
