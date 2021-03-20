# Hack U 関西大学 SOJO 2019 発表資料
URL(https://hacku.yahoo.co.jp/kandaisojo2019/)

グループ名：組立組

## 作品概要

組立組はコロナ禍における新しいスポーツ観戦の方法を提案しました。
新型コロナウイルスによって、スポーツ観戦の方法に中継のみの無観客観戦やハイブリッド観戦が加わりました。
しかし、スポーツ観戦の楽しみの一つである「大人数で熱狂する環境」が失われました。
そこで、スポーツ観戦を共に楽しめるエージェント「しんろくん」を開発しました。
しんろくんと一緒にスポーツ観戦を盛り上げよう！

Presentation_materials.pdfは発表資料です。使用した技術やアプリケーションイメージ図が記載されています。

## 使用言語

* processing
* python3

## 環境

macOS Mojave 10.14.6

## 起動・操作方法

### 起動方法

index.pyとapp.pdeを同時に起動して準備完了

### 操作方法

* 1キー：応援プリセット（好調）
* 2キー：応援プリセット（不調）
* マウスクリック：ユーザの音声を録音を開始し、エージェントが追いかけるように応援（SPTKを用いたボイスチェンジ）

## processingについて

### version

processing 3.5.3

### package

minim

## python3

### version

Python 3.8.3

### package

portaudio
sptk
Sox

### install　方法

```
$ brew install portaudio

$ cd library/SPTK-3.11
$ ./configure
$ make
$ sudo make install

$ brew install lame
$ brew install sox
```

## ボイスチェンジャーについて

Hatena Blog「人工知能に関する断創録　ー統計的声質変換 (2) ボイスチェンジャーを作ろうー」
https://aidiary.hatenablog.com/entry/20150225/1424863972

