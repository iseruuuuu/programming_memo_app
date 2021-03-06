import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:programming_memo_for_mac_app/container.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';
import 'package:programming_memo_for_mac_app/store/loading_state.dart';
import 'package:programming_memo_for_mac_app/usecase/memo/memo.dart';
import 'memo_state.dart';

final memoStateProvider = StateNotifierProvider<EditorNotifier, MemoState>(
  (ref) => EditorNotifier(memoUseCase),
);

final memoProvider = Provider.autoDispose((ref) {
  return ref.watch(memoStateProvider).memo;
});

class EditorNotifier extends StateNotifier<MemoState> {
  final MemoUseCase memoUseCase;

  EditorNotifier(this.memoUseCase) : super(MemoState.initial()) {
    _loadMemoListAndDeletedMemoList();
  }

  void _loadMemoListAndDeletedMemoList() async {
    _setLoadingState(LoadingState.loading);
    try {
      await memoUseCase.deleteExpiredMemos();
      final memoList = await memoUseCase.loadUndeletedMemos();
      _setMemoList(memoList);
      if (memoList.isEmpty) {
        createMemo(memoList);
      } else {
        _setMemo(memoList.first);
      }

      final deletedMemoList = await memoUseCase.loadDeletedMemos();
      _setDeletedMemoList(deletedMemoList);
      _setLoadingState(LoadingState.ready);
    } catch (e) {
      _setLoadingState(LoadingState.failed);
    }
  }

  // Action Creators
  void loadMemoList() {
    _loadMemoListAndDeletedMemoList();
  }

  void updateTitle(Memo memo, String title) {
    _setMemo(memo.copyWith(title: title));
  }

  void updateContent(Memo memo, String content) {
    _setMemo(memo.copyWith(content: content));
  }

  void storeMemo(Memo memo, List<Memo> memoList) async {
    try {
      final newMemo = await memoUseCase.updateModifiedAt(memo);

      final replacedMemoList = [
        newMemo,
        ...[...memoList]..removeWhere((m) => m.id == memo.id)
      ];
      _setMemoList(replacedMemoList);
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }

  void createMemo(List<Memo> memoList) async {
    _setMemo(await memoUseCase.createMemo());
  }

  void openMemo(Memo memo, List<Memo> memoList) async {
    try {
      final newMemo = await memoUseCase.updateOpenedAt(memo);

      final foundMemoIndex = memoList.indexWhere((m) => m.id == memo.id);
      final newMemoList = [...memoList];
      // foundMemoIndex must be >= 0.
      newMemoList[foundMemoIndex] = newMemo;
      _setMemoAndMemoList(newMemo, newMemoList);
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }

  void makeDeleteMemo(
      Memo memo, List<Memo> memoList, List<Memo> deletedMemoList) async {
    try {
      final newMemo = await memoUseCase.makeDeleteMemo(memo);
      final removedMemoList = [...memoList]
        ..removeWhere((m) => m.id == memo.id);
      final newDeletedMemoList = [newMemo, ...deletedMemoList];
      if (removedMemoList.isEmpty) {
        _setMemoAll(null, removedMemoList, newDeletedMemoList);
        createMemo(removedMemoList);
      } else {
        _setMemoAll(removedMemoList.first, removedMemoList, newDeletedMemoList);
      }
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }

  void restoreMemo(
      Memo memo, List<Memo> memoList, List<Memo> deletedMemoList) async {
    try {
      final newMemo = await memoUseCase.restoreMemo(memo);
      _setMemoListAll([newMemo, ...memoList],
          [...deletedMemoList]..removeWhere((m) => m.id == newMemo.id));
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }

  void permanentDeleteMemo(Memo memo, List<Memo> deletedMemoList) async {
    try {
      await memoUseCase.deleteMemo(memo);
      _setDeletedMemoList(
          [...deletedMemoList]..removeWhere((m) => m.id == memo.id));
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }

  // Reducer
  void _setLoadingState(LoadingState loadingState) {
    state = state.copyWith(
      loadingState: loadingState,
    );
  }

  void _setMemo(Memo memo) {
    state = state.copyWith(
      memo: memo,
    );
  }

  void _setDeletedMemoList(List<Memo> deletedMemoList) {
    state = state.copyWith(
      deletedMemoList: deletedMemoList,
    );
  }

  void _setMemoList(List<Memo> memoList) {
    state = state.copyWith(
      memoList: memoList,
    );
  }

  void _setMemoAndMemoList(Memo? memo, List<Memo> memoList) {
    state = state.copyWith(
      memo: memo,
      memoList: memoList,
    );
  }

  void _setMemoListAll(List<Memo> memoList, List<Memo> deletedMemoList) {
    state = state.copyWith(
      memoList: memoList,
      deletedMemoList: deletedMemoList,
    );
  }

  void _setMemoAll(
      Memo? memo, List<Memo> memoList, List<Memo> deletedMemoList) {
    state = state.copyWith(
      memo: memo,
      memoList: memoList,
      deletedMemoList: deletedMemoList,
    );
  }
}

//TODO index????????????????????????

/*TODO ???????????????
void allDelete(
      Memo memo, List<Memo> memoList, List<Memo> deletedMemoList) async {

    final newMemo = await memoUseCase.makeDeleteMemo(memoList[1]);
    final removedMemoList = [...memoList]..remove([]);
    final newDeletedMemoList = [newMemo, ...deletedMemoList];
    if (removedMemoList.isEmpty) {
      _setMemoAll(null, removedMemoList, newDeletedMemoList);
      createMemo(removedMemoList);
      // _setMemoAll(removedMemoList.first, [], []);
    } else {
      // _setMemoAll(removedMemoList.first, removedMemoList, newDeletedMemoList);
      _setMemoAll(removedMemoList.first, removedMemoList, newDeletedMemoList);
    }

    try {
      final newMemo = await memoUseCase.makeDeleteMemo(memo);
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }
 */

/*TODO ??????????????????
void permanentDeleteMemo(Memo memo, List<Memo> deletedMemoList) async {
    try {
      await memoUseCase.deleteMemo(deletedMemoList[1]);

      print(deletedMemoList[0]);
      print(deletedMemoList[1]);

      _setDeletedMemoList(
          [...deletedMemoList]..removeWhere((m) => m.id == memo.id));
    } catch (e) {
      // TODO(Niccari): Error handling
    }
  }

 */
