# CentOS6との違い

|やりたいこと|CentOS6|CentOS7|
|-|-|-|
|自身のIPアドレスを知りたい|`ifconfig`|`ip a` (`iproute`パッケージ)|
|サービス一覧を見る|`chkconfig --list`|`systemctl list-units -t =service`|
|特定のサービスの状態を見る|`/etc/init.d/... status`|`systemctl status ...`|
|特定のサービスを起動する|`/etc/init.d/... start`|`systemctl start ...`|
