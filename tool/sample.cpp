#include "sample.h"  // 自身と同名のヘッダファイルは最初にincludeする
                     // 間に1行あける
#include "abc.h"     // 次にユーザー定義ヘッダファイルをincludeする
#include "def.h"     // アルファベット順に並べる
                     // 間に1行あける
#include <iostream>  // 最後にシステム定義ヘッダファイルをincludeする
#include <sstream>   // アルファベット順に並べる
                     // 連続したコメントの位置を揃える

namespace a
{
// namespaceの内側はインデントしない
namespace b
{
// namespaceの内側はインデントしない
class C
{
    // インデントは4文字
    int m_i;
    int m_j;

public:  // アクセス修飾子は4文字戻す
    C();

    int Foo(short a,
            int b);  // このタイプの改行では "(" の位置に開始位置を揃える
                     // 宣言(変数名)の位置は揃えない
                     // 連続したコメントの位置を揃える

    // &は型の後に続ける
    bool Bar(const std::vector<int>& param) const;

    // *は型の後に続ける
    bool Bar(const std::vector<int>* const param) const;
};
}  // namespace b
}  // namespace a

// "\" の位置を ColumnLimit にはせず、揃えられる最も左端に設定する
#define TEST         \
    "long long test" \
    "string"         \
    "!!"

a::b::C::C()
    : m_i(0)
    , m_j(1)  // コンストラクタの初期化子内で改行する場合、カンマ始まりを許容
{
}

int a::b::C::Foo(
    short a,
    int b)
{
    if (a)
        return;  //if (a) return; は改行させる

    if (b < 0)  // {の前で常に改行
    {
        return;
    }

    int c = a +
            1 +  // 二項演算子の途中で改行がある場合、位置を揃える
            2;
    short ddd = b + 2;     // 連続した宣言(変数名)の位置は揃えない
    int result = c + ddd;  // 連続した代入文で = の位置を揃えない
    return result;
}
