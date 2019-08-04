# clang-tidy


## 1. `cmake` に `compile_commands.json` を生成させる

* トップレベルの `CMakeLists.txt` に以下を記述する:

```cmake
set(CMAKE_EXPORT_COMPILE_COMMANDS ON)
```

## 2. 手動で `clang-tidy` を動かす

```shell
$ clang-tidy -p (compile_commands.jsonが存在するディレクトリ) 〜.cpp
```

## 3. `CMakeLists.txt` に統合する

```cmake
set(
  CMAKE_CXX_CLANG_TIDY
  clang-tidy;
  -checks=*;
  -header-filter=${CMAKE_SOURCE_DIR}/include;
  -warnings-as-errors=*;
)
```

* 全ルール適用
* ヘッダファイルは `include` 以下のみ対象
* 警告はエラーとして扱う

## 参考

* [冬休み到来! clang-tidy で安心安全な C/C++ コーディングを極めよう! - Qiita](https://qiita.com/syoyo/items/0e75410c44ed73d4bdd7)
* [CMAKE_EXPORT_COMPILE_COMMANDS — CMake 3.5.2 Documentation](https://cmake.org/cmake/help/v3.5/variable/CMAKE_EXPORT_COMPILE_COMMANDS.html)
* [Integrate Clang-Tidy into CMake – Embedded bits and pixels](file-header-comment)
