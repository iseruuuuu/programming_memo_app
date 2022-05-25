import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/memo_page_container.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo_list/memo_list_page_container.dart';
import 'logger/logger.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
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
