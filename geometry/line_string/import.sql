-- 空間処理のためPostGIS拡張を指定
CREATE EXTENSION IF NOT EXISTS postgis;

-- 一時テーブルを作成
--   セッション切断時に削除される
CREATE TEMP TABLE tmp (
  line_id integer,
  lon double precision,
  lat double precision
);

-- CSVファイルからインポート
--   第1カラム - 線ID
--   第2カラム - 経度 [度]
--   第3カラム - 緯度 [度]
\COPY tmp (line_id, lon, lat) FROM '/tmp/points.csv' DELIMITER ',';

-- LINESTRINGのWKTを生成
--   ※\copyは全てを一行に書いていないとパース失敗する
\COPY (SELECT line_id as id, (ST_MakeLine(ST_MakePoint(lon, lat))) as geom FROM tmp GROUP BY line_id) TO '/tmp/result.csv' (FORMAT CSV, HEADER true, QUOTE '"');
