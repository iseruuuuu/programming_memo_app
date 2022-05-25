import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/parts/editor.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/parts/preview.dart';

class MemoPage extends StatelessWidget {
  final Function() openMemoList;
  final Function() storeMemo;

  const MemoPage({
    required this.openMemoList,
    required this.storeMemo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoTabEditor = AppLocalizations.of(context)?.memoTabEditor ?? "";
    final memoTabPreview = AppLocalizations.of(context)?.memoTabPreview ?? "";
    final notifyMemoStored =
        AppLocalizations.of(context)?.notifyMemoStored ?? "";
    const fabPaddingInset = EdgeInsets.all(8);

    void _storeMemo() {
      storeMemo();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(notifyMemoStored),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    Future<bool> _willPopCallback() async {
      return true;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            actions: [
              TextButton(
                onPressed: openMemoList,
                child: const Text(
                  'リスト画面へ',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
            bottom: TabBar(
              tabs: <Widget>[
                Tab(text: memoTabEditor),
                Tab(text: memoTabPreview),
              ],
            ),
          ),
          body: const TabBarView(
            children: <Widget>[
              EditorWidgetContainer(),
              PreviewWidgetContainer(),
            ],
          ),
          floatingActionButton: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // FloatingActionButton(
              //   heroTag: "openMemoList",
              //   child: const Icon(Icons.list),
              //   onPressed: openMemoList,
              // ),
              const Padding(padding: fabPaddingInset),
              FloatingActionButton(
                heroTag: "storeMemo",
                child: const Icon(
                  Icons.save_alt,
                  color: Colors.white,
                ),
                onPressed: _storeMemo,
              )
            ],
          ),
        ),
      ),
    );
  }
}
