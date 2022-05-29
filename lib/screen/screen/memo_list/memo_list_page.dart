import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo_list/parts/deleted_memo_list.dart';
import 'package:programming_memo_for_mac_app/screen/container/memo_list/parts/memo_list_widgets_container.dart';
import 'package:programming_memo_for_mac_app/screen/screen/error_text_widget.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';

class MemoListPage extends StatelessWidget {
  final Function() createMemo;
  final Function() reloadMemo;
  final LoadingState loadingState;

  const MemoListPage(
      {required this.loadingState,
      required this.createMemo,
      required this.reloadMemo,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final memoListFailedToLoad =
        AppLocalizations.of(context)?.memoListFailedToLoad ?? "";
    final errorWidget = ErrorTextWidget(
      errorText: memoListFailedToLoad,
      recoverActionText: "再読み込み",
      onActionPressed: () {
        reloadMemo();
      },
    );

    Future<bool> _willPopCallback() async {
      return true;
    }

    return WillPopScope(
      onWillPop: _willPopCallback,
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: const Color(0xFFF0EFF5),
          appBar: AppBar(
            backgroundColor: const Color(0xFFF7F7F9),
            elevation: 10,
            bottom: const TabBar(
              indicatorWeight: 5,
              indicatorColor: Color(0xFF4E4E4E),
              labelColor: Color(0xFF4E4E4E),
              tabs: <Widget>[
                Tab(text: 'メモ一覧'),
                Tab(text: 'ゴミ箱'),
              ],
            ),
            automaticallyImplyLeading: false,
          ),
          body: TabBarView(
            children: <Widget>[
              //TODO メモ一覧
              MemoListWidgetsContainer(errorWidget: errorWidget),
              //TODO 削除済みメモ一覧
              DeletedMemoListWidgetsContainer(errorWidget: errorWidget),
            ],
          ),
          floatingActionButton: SizedBox(
            width: 80,
            height: 80,
            child: FloatingActionButton(
              heroTag: "createMemo",
              backgroundColor: Colors.grey.shade800,
              child: const Icon(
                Icons.add,
                color: Colors.white,
                size: 40,
              ),
              onPressed: createMemo,
            ),
          ),
        ),
      ),
    );
  }
}
