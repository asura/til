# 配列やvectorをfor_eachするときにインデックス値がほしい

* for_eachの処理中に異常値を検知してログ出力したい場合など。
* 泥臭く、ループ外部にカウンタ変数を設ける。
* 早期returnなど、カウンタがインクリメントされないことがないよう要注意。

```c++
{
    // 動作確認のため合計値の格納先を作っておく
    int result = 0;

    // 5要素の配列を用意する
    int v[]{1, 2, 3000, 4, 5};

    // 2番目の要素を開始条件、最後の1つ手前の要素を終了条件として、for_eachを実行
    std::size_t i = 1;       // インデックス変数
    std::for_each(
        v + 1,
        v + sizeof(v) / sizeof(v[0]) - 1,
        [&](const int the_value) {
            // 異常値チェック
            if (10 <= the_value)
            {
                std::cerr << "[" << i << "] = " << the_value << std::endl;
                ++i;         // これを自分で書く必要がある
                return;
            }

            result += the_value;
            ++i;             // インデックスを次へ
        });

    // sdterr => [2] = 3000
    // result => 6
}
```

## 参考サイト

* [c++ - How to get the index of a value in a vector using for_each? - Stack Overflow](https://stackoverflow.com/questions/3752019/how-to-get-the-index-of-a-value-in-a-vector-using-for-each)
* [C++ - C++ 範囲ベースforの中でインデックス番号を取り出す方法｜teratail](https://teratail.com/questions/28543)
