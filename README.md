# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
## users table

|Column|Type|Options|
|------|----|-------|
|email|string|unique: true|
|password|string|null: false|
|line_id|string|null: false|

### Association
- has_one :user_statuses, dependent: :destroy
- has_many :food_eatings,dependent: :destroy
- has_one :metabolisms

## user_statuses table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|age|integer|null: false|
|gender|string|null: false|
|weight|integer|
|est_energy_req|integer|null: false|
|metabolism_id|string|add_foreign_key|null: false|
|user_id|integer|add_foreign_key|null: false|

### Association
- has_many :metabolisms
- belongs_to :user

## metabolisms table

|Column|Type|Options|
|------|----|-------|
|age_base|integer|null: false|
|gender|string|null: false|
|base_weight|float|null: false|
|base_metabolic_rate|float|null: false|

### Association
- belong_to :user
- belong_to :user_status

## menus table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :foods

## menu_categories table

|Column|Type|Options|
|------|----|-------|
|name|string|null: false|

### Association
- has_many :foods

## foods table

|Column|Type|Options|
|------|----|-------|
|name|string|
|calorie|integer|null: false|
|hiragana_name|string|null: false|
|menu_id|integer|foreign_key: true|null: false|
|menu_category_id|integer|foreign_key: true|null: false|


### Association
- belongs_to :menu
- belongs_to :menu_category
- has_many :food_eatings

## food_eatings table

|Column|Type|Options|
|------|----|-------|
|food_id|integer|foreign_key: true|null: false|
|user_id|integer|foreign_key: true|null: false|

### Association
- belongs_to :food
- belongs_to :user

## このアプリで苦労した点。
「食事管理をより忘れずに行うためにはどうすればいいか？」検討することが苦労しました。
何故忘れてしまうか考えた時に、私は「 管理がめんどくさくなる」と「管理に 飽きる」の２つが大きな原因と
考えたので、それを解消するために以下のことを考えました。
 1. ラインボットで食事管理をすること。
 2. 食品のカロリー値や、今まで自分が食べた食事のデータをラインボットで返すこと。
1について

 単純にホームページに自分で食べた食事を入力して管理する方法だと、必ず入力忘れや面倒くささで
使用しなくなると考えたので、入力方法は、一番手軽なラインを使用することにしました。

2について

 ただ入力してデータベースに管理するだけではユーザー側は飽きてしまうので、入力した食べ物のカロリーと、
本日自分が摂取したカロリーの合計をラインボットで返答することにしました。
この返答により、食べた食品のカロリーを把握することや、自分がカロリーをとりすぎているかどうか
視覚的に分かるので、モチベーションに繋がるだろうと考えました。
また、昨日食べた食事や今週食べた食事の一覧もラインボットで返答できるようにしました。
これは、自分が偏った食事をとっていないかの指標や、食べた食事から、過去の出来事を思い出せたら
面白いだろうと思ったので、取り入れました。

## 今後追加したい機能。
1. タンパク質やビタミンなどの栄養価の管理

 今はカロリーしか管理できませんが、栄養素面の管理も追加したいと考えています。
 今日とった栄養素の中で、何が足りていないか、足りていない栄養素を補うために、
 どんな食べ物を食べればいいかを表示する機能を追加したいです。

2. 何かモチベーションを高めるためのその他の機能

 食事管理を行い、自分が健康になっていることを表すなんらかの表示を追加したいと考えています。（現在検討中）
 自分が変わっているとわかればモチベーションは上がり、飽きることが無くなると考えていますので、
 どんな表示を出せば自分が変化していることが分かるか検討し、追加したいです。

## アプリのgif画像 その１
友達追加したラインボットから、新規ユーザー登録するまでのgifです。

![demo](https://raw.github.com/wiki/YusakuMatama/food_manage_appli/images/line1-min.gif)

## アプリのgif画像 その2
新規ユーザー登録後、ラインで食事管理をしているgifです。

![demo](https://raw.github.com/wiki/YusakuMatama/food_manage_appli/images/line2-min.gif)

## ラインのQRコード
このラインボットのQRコードです。

<img width="973" alt="スクリーンショット 2019-07-31 16 56 23" src="https://user-images.githubusercontent.com/51021215/62447296-0818bc80-b7a0-11e9-8891-79f970d57d7d.png">
