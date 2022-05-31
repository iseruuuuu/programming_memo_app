class Example {
  final title = "記入例";

  final example = (() {
    return '''  
# 見出し
---
# h1
## h2 
### h3 
#### h4 
##### h5 
###### h6 
      

# コード
---

```
function test() {
    echo 'test';
}
```

# テーブル（表）
---

|  TH  |  TH  |
| ---- | ---- |
|  TD  |  TD  |
|  TD  |  TD  |
      
       
---
# リンクの挿入
---

[Qiita](http://qiita.com/)

---
# 画像の挿入
---

![image](https://cdn-ssl-devio-img.classmethod.jp/wp-content/uploads/2020/02/flutter.png)


---
# リスト
---

* テキスト
    * テキスト
    * テキスト
    
---
# 引用
---

[[Q1]] 引用

[[Q2]] 二重引用
   
  
---
# 文字の装飾
---

~~取り消し線~~

*斜体のテキスト*

_斜体のテキスト_


---
# 補足説明
---

[[warning]] warning 

[[verywaring]] very waring

[[littlewaring]] a little waring
 
[[information]] information


---
# Color
---

[[color]]ffce44

---
# 最後に
---

### ・開発中なため、不十分になっているかもしれません。  
### ・こんな機能を追加してほしいと思った方はお気軽に連絡してください
### ・Twitter：@isekiryu






      ''';
  })();
}
