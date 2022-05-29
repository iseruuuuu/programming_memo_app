import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:programming_memo_for_mac_app/domain/entities/memo/memo.dart';

void openDialog(BuildContext context, Memo memo, Function(Memo) memoFunctuon) {
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        content: const SizedBox(
          height: 80,
          child: Center(
            child: Text(
              'この写真は削除されます。\n'
              'この操作は取り消せません。',
              style: TextStyle(
                color: Colors.black,
                fontSize: 17,
              ),
            ),
          ),
        ),
        actions: [
          CupertinoDialogAction(
            child: const Text(
              'キャンセル',
              style: TextStyle(
                color: Colors.blueAccent,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoDialogAction(
            child: const Text(
              '写真を削除',
              style: TextStyle(
                color: Colors.red,
                fontSize: 15,
              ),
            ),
            onPressed: () {
              memoFunctuon(memo);
              Navigator.pop(context);
            },
          ),
        ],
      );
    },
  );
}
