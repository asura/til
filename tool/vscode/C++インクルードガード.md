# C++インクルードガード

## 方法1: `Head-File-Guard` 拡張を利用する

* [Head-File-Guard - Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=bjr.head-file-guard)
* `setting.json` に `"headFileGuard.type": "filename"` を設定する

### 結果

* `Foo.h` に対して `Insert Head-File-Guard` を実行する

```cpp
#ifndef FOO_H
#define FOO_H

#endif /* FOO_H */
```

## 方法2: コードスニペット機能を利用する

### 1. スニペットを登録

1. メニューから `基本設定` → `ユーザー スニペット` を選択
2. `cpp (C++)` を選択
3. 以下を追加する

```json
{
	"Include Guard": {
		"prefix": "guard",
		"description": "C++ヘッダファイルにインクルード・ガードを追加する",
		"body": [
			"#ifndef ${TM_FILENAME/^([^\\.]*)\\..*$/${1:/upcase}/}_${TM_FILENAME/^.*\\.([^\\.]*)$/${1:/upcase}/}",
			"#define ${TM_FILENAME/^([^\\.]*)\\..*$/${1:/upcase}/}_${TM_FILENAME/^.*\\.([^\\.]*)$/${1:/upcase}/}",
			"",
			"$0",
			"",
			"#endif  // ${TM_FILENAME/^([^\\.]*)\\..*$/${1:/upcase}/}_${TM_FILENAME/^.*\\.([^\\.]*)$/${1:/upcase}/}",
			""
		]
	}
}
```

### 2. スニペットを利用

* `guard` と打つと補完候補が出てくるので、`Include Guard` を選択

### 3. 結果

```cpp
#ifndef FOO_H
#define FOO_H



#endif  // FOO_H
```

* 真ん中部分 (4行目) にカーソルが来るので、コーディングを続けやすい

### 参考

* [Visual Studio Code のスニペットでインクルードガードを作ってみる - Qiita](https://qiita.com/yuki12/items/a67af0142f77ff496ef3)
* [Visual Studio Code C Include Guard Snippet](https://gist.github.com/coffeenotfound/2305c3a2bc1dff0513f52ac178cb5616)