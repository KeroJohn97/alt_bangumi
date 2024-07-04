# Alt Bangumi (Mandarin App)
An alternative bangumi mobile application project written in Flutter.

## Use Build Runner
flutter packages pub run build_runner build --delete-conflicting-outputs

## Solve Shader Compilation Jank
https://docs.flutter.dev/perf/shader

## Shift M to capture sksl
flutter run --profile --cache-sksl --purge-persistent-cache
flutter build ios --bundle-sksl-path flutter_01.sksl.json

## Need to create your own secrets.json including variables below:
  - Authorization (follow the instruction [here](https://github.com/bangumi/api/blob/master/open-api/api.yml) if you know Mandarin or ask me for assistance)
  - X-RapidAPI-Key (https://rapidapi.com/microsoft-azure-org-microsoft-cognitive-services/api/microsoft-translator-text)
  - X-RapidAPI-Host (https://rapidapi.com/microsoft-azure-org-microsoft-cognitive-services/api/microsoft-translator-text)

Probably PoweredBy

[Bangumi-OnAir] ekibun 的单集播放数据源

[bangumi-mosaic-tile] weizhenye 的用户统计瓷砖库

[bangumi-data] 番组数据索引

[bangumi-api] 官方接口
