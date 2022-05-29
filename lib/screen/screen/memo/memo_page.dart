import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/parts/editor.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo/parts/preview.dart';
import 'package:programming_memo_for_mac_app/screen/screen/keyboard_action.dart';

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
        child: Shortcuts(
          shortcuts: <ShortcutActivator, Intent>{
            LogicalKeySet(LogicalKeyboardKey.metaLeft, LogicalKeyboardKey.keyS):
                const CommandKey(),
          },
          child: Actions(
            actions: <Type, Action<Intent>>{
              CommandKey:
                  CallbackAction<CommandKey>(onInvoke: (CommandKey intent) {
                _storeMemo();
              }),
            },
            child: Focus(
              autofocus: true,
              child: Scaffold(
                backgroundColor: const Color(0xFFF0EFF5),
                appBar: AppBar(
                  backgroundColor: const Color(0xFFF7F7F9),
                  elevation: 10,
                  automaticallyImplyLeading: false,
                  actions: [
                    IconButton(
                      onPressed: openMemoList,
                      iconSize: 40,
                      icon: const Icon(
                        Icons.list,
                        color: Color(0xFF4E4E4E),
                      ),
                    ),
                  ],
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
                    EditorWidgetContainer(),
                    PreviewWidgetContainer(),
                  ],
                ),
                floatingActionButton: SizedBox(
                  width: 80,
                  height: 80,
                  child: FloatingActionButton(
                    heroTag: "storeMemo",
                    backgroundColor: Colors.grey.shade800,
                    child: const Icon(
                      Icons.save_alt,
                      color: Colors.white,
                      size: 40,
                    ),
                    onPressed: _storeMemo,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
