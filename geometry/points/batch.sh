#!/bin/sh

ogr2ogr -f GeoJSON output.geojson config.vrt || exit 1
cat output.geojson
