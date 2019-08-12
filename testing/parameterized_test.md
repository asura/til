# Parameterized Test

## Catch2での実装例

```cpp
#include <catch.hpp>

TEST_CASE(
    "足し算のテスト",
    "[parameterized]")
{
    const auto [a, b, answer] = GENERATE(
        table<int, int, int>({{1, 2, 3},
                              {5, 8, 13},
                              {0, 0, 0}}));

    REQUIRE(a + b == answer);
}
```
