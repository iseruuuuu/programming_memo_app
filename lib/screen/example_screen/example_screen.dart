import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/example_screen/example_edit_container.dart';
import 'package:programming_memo_for_mac_app/screen/example_screen/example_preview_container.dart';

class ExampleScreen extends StatelessWidget {
  const ExampleScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoTabEditor = AppLocalizations.of(context)?.memoTabEditor ?? "";
    final memoTabPreview = AppLocalizations.of(context)?.memoTabPreview ?? "";
    Future<bool> _willPopCallback() async {
      return true;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: DefaultTabController(
        length: 2,
        child: Focus(
          autofocus: true,
          child: Scaffold(
            backgroundColor: const Color(0xFFF0EFF5),
            appBar: AppBar(
              centerTitle: true,
              title: const Text(
                '記入例',
                style: TextStyle(
                  color: Color(0xFF4E4E4E),
                ),
              ),
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                iconSize: 30,
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Color(0xFF4E4E4E),
                ),
              ),
              backgroundColor: const Color(0xFFF7F7F9),
              elevation: 10,
              automaticallyImplyLeading: false,
              bottom: TabBar(
                indicatorWeight: 5,
                indicatorColor: const Color(0xFF4E4E4E),
                labelColor: const Color(0xFF4E4E4E),
                tabs: <Widget>[
                  Tab(text: memoTabEditor),
                  Tab(text: memoTabPreview),
                ],
              ),
            ),
            body: const TabBarView(
              children: <Widget>[
                ExampleEditContainer(),
                ExamplePreviewContainer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
