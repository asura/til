# CSVをGeoJSONに変換

## 点の変換

* `ogr2ogr`コマンドで実現可能 → [コード等](points)
* 経度・緯度を含め、CSVの全カラムがGeiJSONのpropertiesに格納される
  * 経度・緯度を削るなら `jq` を使う

### コマンド

```
$ cd points
$ ./batch.sh
```

### 入力データ

```csv
経度,緯度,名称
139.691670,35.689444,東京都庁
130.875194,33.883417,北九州市庁
```

### 結果

```json
{
"type": "FeatureCollection",
"name": "points",
"crs": { "type": "name", "properties": { "name": "urn:ogc:def:crs:OGC:1.3:CRS84" } },
"features": [
{ "type": "Feature", "properties": { "経度": "139.691670", "緯度": "35.689444", "名称": "東京都庁" }, "geometry": { "type": "Point", "coordinates": [ 139.69167, 35.689444 ] } },
{ "type": "Feature", "properties": { "経度": "130.875194", "緯度": "33.883417", "名称": "北九州市庁" }, "geometry": { "type": "Point", "coordinates": [ 130.875194, 33.883417 ] } }
]
}
```

## 線の変換

* 単体では無理 → [コード等](line_string)
  * PostGISの力を借りた
  * 余分なプロパティを削るため & `name`プロパティの値を変更するため、`jq`も使った

### コマンド

```
$ cd line_string
$ ./batch.sh points.csv
```

### 入力データ

```csv
1,139.691670,35.689444
1,130.875194,33.883417
2,130.875194,33.883417
2,139.691670,35.689444
```

### 結果

```json
{"type":"FeatureCollection","name":"LineStrings","crs":{"type":"name","properties":{"name":"urn:ogc:def:crs:OGC:1.3:CRS84"}},"features":[{"type":"Feature","properties":{"id":"1"},"geometry":{"type":"LineString","coordinates":[[139.69167,35.689444],[130.875194,33.883417]]}},{"type":"Feature","properties":{"id":"2"},"geometry":{"type":"LineString","coordinates":[[130.875194,33.883417],[139.69167,35.689444]]}}]}
```

## 参考サイト

* [gdal - Converting csv to kml/geojson using ogr2ogr or equivalent command line tools? - Geographic Information Systems Stack Exchange](https://gis.stackexchange.com/questions/127518/converting-csv-to-kml-geojson-using-ogr2ogr-or-equivalent-command-line-tools/127525)
* [VRT – Virtual Format — GDAL documentation](https://gdal.org/drivers/vector/vrt.html)
* [COPYとcopyメタコマンド - Qiita](https://qiita.com/rhi222/items/6c9847e8f7f3a5109c20)
* [引数を処理する | UNIX & Linux コマンド・シェルスクリプト リファレンス](https://shellscript.sunone.me/parameter.html#指定された引数の数をチェックする)
* [jqコマンドでGeoJSONから特定のプロパティを削除する - Qiita](https://qiita.com/_shimizu/items/4b279eaa041387e2d9b7)
* [シェル芸で使いたい jqイディオム - Qiita](https://qiita.com/nmrmsys/items/5b4a4bd2e3909db161b1#jsonの置換)