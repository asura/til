# clang-format

## 設定

* プロジェクトのトップディレクトリに `.clang-format` ファイルを配置する
  * [設定例](.clang-format)
  * [フォーマット結果](sample.cpp)

## VS Codeに統合する

### 導入

* C++拡張を導入していれば整形に対応している
  * clang-formatも自動的にインストールしてくれる
    * macの例: `~/.vscode/extensions/ms-vscode.cpptools-0.24.1/LLVM/bin/clang-format.darwin`
* clang-formatという拡張もあるが、上記のとおり、公式が対応したので不要

### 利用

* Windows版の場合「shift + alt + F」、mac版の場合「shift + option (つまりalt) + F」で手動整形
* 保存時に自動整形させたければ、`setting.json` に `"editor.formatOnSave": true` を定義する

## 参考

* [ClangFormatスタイルオプション — Algo13 2016.12.17 ドキュメント](http://algo13.net/clang/clang-format-style-oputions.html)
* [Clang-Format Style Options — Clang 10 documentation](https://clang.llvm.org/docs/ClangFormatStyleOptions.html)