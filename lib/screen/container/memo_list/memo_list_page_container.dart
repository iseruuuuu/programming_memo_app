import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:programming_memo_for_mac_app/screen/screen/memo_list/memo_list_page.dart';
import 'package:programming_memo_for_mac_app/store/memo/memo_provider.dart';

class MemoListPageContainer extends ConsumerWidget {
  const MemoListPageContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loadingState = ref.watch(memoStateProvider).loadingState;

    createMemo() {
      final memoList = ref.read(memoStateProvider).memoList;
      ref.read(memoStateProvider.notifier).createMemo(memoList);
      Navigator.pushNamed(context, '/');
    }

    reloadMemoList() {
      final loadMemoList = ref.read(memoStateProvider.notifier).loadMemoList;
      loadMemoList();
    }

    return MemoListPage(
      loadingState: loadingState,
      createMemo: createMemo,
      reloadMemo: reloadMemoList,
    );
  }
}
