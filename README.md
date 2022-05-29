# programming_memo_for_mac_app

## 現状のアプリ  


## アップデート内容


## やりたいこと

## やることリスト
- [ ] デザインのテーマを決める(iOS風) 
- [ ] リスト画面のセルのデザイン修正（Card.dart）
- [ ] 削除済みリスト載せるのデザイン修正（Card.dart）
- [ ] フォルダーの理解を深める
- [ ] ショートカット入力のタブの切り替え「右スクロール」できるようにする。
- [ ] ショートカット入力のタブの切り替え「右スクロール」できるようにする。

## errorリスト
- [ ] macOSの時のプレビュー画面では、FontWeight.boldが効いていない？
- [ ] テキストフィールドの操作の確認をする

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
- [x] プレビュー画面のmarkdownを黒にした（markdown_body.dart）
- [x] プレビュー画面のcodeのPaddingをQiitaと同じにした。(mark_down_body.dart)
- [x] プレビュー画面で画像を挿入できるようにした。(markdown_body.dart)
- [x] プレビュー画面の大きさ調整(markdown_body.dart, pre.dart)
- [x] プレビュー画面のcodeの大きさをMediaQueryにする(markdown_body.dart, pre.dart)
- [x] 削除済みメモがない時の画面を一新した（deleted_memo_list_widget.dart）
- [x] メモ一覧のメモがない時の画面を一新した（memo_list_widget.dart）
- [x] プレビュー画面のwaringのデザインを実装した(markdown_body.dartとpre.dart)
- [x] プレビュー画面の補足説明（veryWaring,littleWaring,information）の３つを作成した。(markdown_body.dartとpre.dart)
- [x] veryWaring・littleWaring・informationの横にそれぞれアイコンを足してあげた（per.dart）
- [x] プレビュー画面の太文字をできるようにした(markdown_body.dartとper.dart)
- [x] プレビュー画面のColor型が入力できるようにした。(markdown_body.dartとper.dart)
- [x] プレビュー画面の引用(1)を別の形で入力できるようにした。(markdown_body.dartとper.dart)
- [x] プレビュー画面の多重引用を別の形で入力できるようにした。(markdown_body.dartとper.dart)
- [x] veryWaring・littleWaring・informationがStackOverFlowしないようにした。(per.dart)
- [x] アプリのMaxサイズとMinサイズを決めた
- [x] h1~h6までのStackOverFlowしないようにした。(hearer.dart)
- [x] cellがStackOverFlowしないようにした(memo_list_card_page.dart)
- [x] consoleに出てくるものを表示させないようにした（logger.dart）
- [x] ショートカット入力の保存の処理「Command＋S」をできるようにする()。
- [x] ショートカット入力の下スクロール「下やじるし」をできるようにする()。
- [x] ショートカット入力の上スクロール「上やじるし」をできるようにする()。
- [x] 「開く」と「削除」のボタンのデザインを一新する(memo_list_card_page.dart)
- [x] 削除の確認のダイアログを作成した（dialog.dart）。

## markdownOKリスト
- [x] 見出し
- [x] リンクの挿入
- [x] 画像の挿入
- [x] テーブルの挿入
- [x] 水平線
- [x] 打ち消し線
- [x] waringの出現
- [x] veryWaringの出現
- [x] littleWaringの出現
- [x] informationの出現
- [x] 太文字
- [x] コードスパンの中身がCSSの <color> 型
- [x] Blockquotes - 引用
- [x] Blockquotes - 多重引用
- [x] 斜体


- [ ] 折りたたみ
[https://qiita.com/Qiita/items/c686397e4a0f4f11683d]
- [ ] チェックボックス(デザインを修正したい。。)
- [ ] リスト(妥協)
- [ ] インライン表示
- [ ] 番号付きリスト
- [ ] 注釈
- [ ] 空行・改行
- [ ] コードの挿入
- [ ] 画像の挿入（サイズ指定）
- [ ] 文字色
- [ ] マークダウンのエスケープ

## 具体的な解決方法
・入力画面 → リスト画面 ->入力画面にしたい   
 ->WillPopScopeの採用とautomaticallyImplyLeading: false,を採用
 

 
## 参考になったサイト一覧
[マークダウンにおける見出しのサイズについて]  
https://zenn.dev/yu_9/articles/yu9-md-fontsize   
[【Flutter】flutter_markdown で見た目をカスタマイズする]
https://zenn.dev/k_shir0/articles/a4fb94315ac89a
[waringのmarkdownを出すやつ]
 https://github.com/flutter/flutter/issues/96608
[文字から空白文字を全て削除する方法]
 [https://qiita.com/blendthink/items/3a70a3ee5b72e5f4e2bc]
