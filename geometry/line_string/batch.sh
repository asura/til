#!/bin/sh
# <機能>
#   CSV中の座標列から折線のGeoJSONを生成する
#   複数の折線に対応
#
# <引数>
#   $1 - CSVファイルパス
#
# <前提>
#   ・アクセス可能なネットワークでPostGISが稼動していること
#   ・ローカルにogr2ogrおよびjqコマンドが存在していること
#
# <CSVフォーマット>
#   第1カラム - 折線ID
#   第2カラム - 経度 [度]
#   第3カラム - 緯度 [度]

if [ $# -ne 1 ]; then
  echo "CSVファイルのパスを指定してください"
  exit 1
fi

target_csv_path=$1
pg_host=postgis_host.example.com
psql_path=psql

# SQL内で使っている\copyコマンドには変数を渡せない。
# つまりファイル名を可変にできない。
# そのため固定パスにコピーしておく。
cp -p ${target_csv_path} /tmp/points.csv

# インポートおよびWKT化を実行
${psql_path} -h ${pg_host} -U postgres -f import.sql -A -F, -t || exit 1
#cat /tmp/result.csv

# WKBからgeojsonを生成
ogr2ogr -f GeoJSON wk config.vrt

# 生成されたGeoJSONにはgeomプロパティが入っている。
# 座標列と重複するので削る。
cat wk | jq "del(.features[].properties.geom)" | jq -c ".name = \"LineStrings\"" > output.geojson
cat output.geojson

# 使った一時ファイルを始末
rm -f /tmp/points.csv /tmp/result.csv wk
