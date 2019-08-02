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
