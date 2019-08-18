# インスタンスのreturn

* Named Return Value Optimizationの話
  * NamedでないRVOであれば、1998年の『More Effective C++』にて、すでに語られている (原著は1996年刊)
* たとえば巨大なvectorを返却する場合、参照渡しされたvector引数を使うか、戻り値として返すか

## 例題

* `std::vector<int>` から1つおきに値を取り出し、別の `std::vector<int>` に格納して返す

### 出力引数を使う場合

```c++
void sample(const std::vector<int>& in, std::vector<int>& out)
{
    out.clear();
    out.reserve((in.size() + 1) / 2);

    bool flag = true;
    for (const auto& i : in)
    {
        if (flag)
        {
            out.push_back(i);
            flag = false;
        }
        else
        {
            flag = true;
        }
    }
}

void caller()
{
    std::vector<int> in;
    for (int i = 0; i < 100000; ++i)
    {
        in.push_back(i);
    }

    std::vector<int> out;
    sample(in, out);

    std::cout << out.size() << std::endl;
}
```

* 入力に前提条件を設けられないケースでは、最初に `clear()` しておく必要がある
* コストは、呼び出し側でのデフォルトコンストラクトと `clear()`

### 戻り値を使う場合

```c++
std::vector<int> sample(const std::vector<int>& in)
{
    std::vector<int> result;
    result.reserve((in.size() + 1) / 2);

    bool flag = true;
    for (const auto& i : in)
    {
        if (flag)
        {
            result.push_back(i);
            flag = false;
        }
        else
        {
            flag = true;
        }
    }
    return result;
}

void caller()
{
    std::vector<int> in;
    for (int i = 0; i < 100000; ++i)
    {
        in.push_back(i);
    }

    std::vector<int> result = sample(in);

    std::cout << result.size() << std::endl;
}
```

* NRVOが効いていないと、メソッド内でのデフォルトコンストラクト、`return` によるコピーコンストラクト、呼び出し側でのコピーコンストラクト、のコストがかかる
  * g++、clang++の場合 `-fno-elide-constructors` オプションを指定すると最適化を無効化できる
* NRVOが効いていれば、メソッド内でのデフォルトコンストラクトのコストのみ
  * g++、clang++はデフォルトで最適化しようとする
* ただし `caller()` 内でこんなこと(↓)されると、最適化が効いてもデフォルトコンストラクト2回とコピー演算子が走る (`return` によるコピーコンストラクトが省略されるだけ) のでNG
```c++
    std::vector<int> result;
    result = sample(in);
```
