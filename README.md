# flutter_bangumi
An alternative bangumi mobile application project written in Flutter.

## Use Build Runner
flutter packages pub run build_runner build --delete-conflicting-outputs

## Solve Shader Compilation Jank
https://docs.flutter.dev/perf/shader
## Shift M to capture sksl
flutter run --profile --cache-sksl --purge-persistent-cache
flutter build ios --bundle-sksl-path flutter_01.sksl.json

PowerBy

[Bangumi-OnAir] ekibun 的单集播放数据源

[bangumi-mosaic-tile] weizhenye 的用户统计瓷砖库

[bangumi-data] 番组数据索引

[bangumi-api] 官方接口