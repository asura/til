# 未push分の一部だけpushしたい

* 下図にて、Bはまだ公開したくないが、Cは公開したい場合。
* トピックブランチ切れ、という話ではある

```
(origin) A
(master) └-> B -> C
```

## 対処法

1. BとCのコミット順序を変更
1. Bを別ブランチに分ける
1. masterをpush

### コマンド例

>```
>  ==
>  * (HEAD -> master) [mdf] aaa
>  * [add] bbb
>  * (origin/master) [add] aaa
>  ==
>```

```
$ git rebase -i HEAD~

pick 1ec99b5 [add] bbb
pick efe7199 [mdf] aaa

↓

pick efe7199 [mdf] aaa
pick 1ec99b5 [add] bbb

=> Successfully rebased and updated refs/heads/master.
```

>```
>  ==
>  * (HEAD -> master) [add] bbb
>  * [mdf] aaa
>  * (origin/master) [add] aaa
>  ==
>```

```
$ git branch bbb
```

>```
>  ==
>  * (HEAD -> master,bbb) [add] bbb
>  * [mdf] aaa
>  * (origin/master) [add] aaa
>  ==
>```

```
$ git reset --hard HEAD~
```

>```
>  ==
>  * (bbb) [add] bbb
>  * (HEAD -> master) [mdf] aaa
>  * (origin/master) [add] aaa
>  ==
>```

```
$ git push
```

>```
>  ==
>  * (bbb) [add] bbb
>  * (HEAD -> master, origin/master) [mdf] aaa
>  * [add] aaa
>  ==
>```
