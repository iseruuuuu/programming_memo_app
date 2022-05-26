# programming_memo_for_mac_app

## 現状のアプリ  


## アップデート内容


## やりたいこと

## やることリスト
- [ ] デザインのテーマを決める(iOS風) 
- [ ] テキストの修正
- [ ] リスト画面のセルのデザイン修正（Card.dart）
- [ ] 削除済みリスト載せるのデザイン修正（Card.dart）
- [ ] consoleに出てくるものをあまり表示させたくない
- [ ] フォルダーの理解を深める
- [ ] 何文字入れるかどうかについては後で決める(meme_list_card_page.dart)
- [ ] StackOverflowしないために、あらかじめ最低大きさを決める。(memo_list_card_page.dart)
- [ ] 「開く」と「削除」のボタンのデザインを一新する(memo_list_card_page.dart)
- [ ] プレビュー画面の大きさ調整
- [ ] プレビュー画面のmarkdownを黒にしたい！
- [ ] 削除済みメモがない時の画面を一新したい。


## 完了リスト
- [x] 起動時のテキストのタイトルを未記入にしたい
- [x] 起動時のテキストの内容を未記入にしたい
- [x] 入力画面 → リスト画面 ->入力画面にしたい
- [x] MarkDownメモ一覧を削除した。(memo_list_page.dart)
- [x] 「リスト画面へ」をいい感じのアイコンに変更（memo_page.dart)
- [x] appBarをgithubみたいにしたい。
- [x] listのcellのデザインを一新する (memo_list_card_page.dart) 
- [x] listを2回タップで開けるようにする  (memo_list_card_page.dart) 
- [x] 「〇〇日後に削除されます」の位置を変更(memo_list_card_page.dart) 
- [x] 削除リストとメモ一覧の2回タップの処理の分岐を行った(memo_list_card_page.dart) 
- [x] TextFieldの色を白にしたい(editor_widget.dart)
- [x] FloatingButtonの色・サイズを変更する。(memo_list_page.dart)
- [x] FloatingButtonの色・サイズを変更する。(memo_page.dart)
- [x] プレビュー画面の大きさを全体的にする。(preview_widget.dart)
- [x] プレビュー画面のColorを白っぽくする。(preview_widget.dart)
- [x] プレビュー画面で「# ww」と入力すると、コピーアイコンを削除する（header.dart）
- [x] プレビュー画面の見出しのサイズをGithubのMarkdownのサイズにした。(header.dart)

## 具体的な解決方法
・入力画面 → リスト画面 ->入力画面にしたい   
 ->WillPopScopeの採用とautomaticallyImplyLeading: false,を採用
 
 
