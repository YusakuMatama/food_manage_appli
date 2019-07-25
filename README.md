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

### Association
- has_one :user_statuses, dependent: :destroy
- has_many :food_eatings,dependent: :destroy
- has_one :metabolisms

## user_statuses table

|Column|Type|Options|
|------|----|-------|
|name|string|
|age|string|
|gender|string|
|weight|string|
|active|string|
|est_energy_req|string|
|line_id|string|
|metabolism_id|string|add_foreign_key|
|user_id|integer|add_foreign_key|

### Association
- belongs_to :user

## metabolisms table

|Column|Type|Options|
|------|----|-------|
|age_base|integer|
|gender|string|
|base_weight|float|
|base_metabolic_rate|float|

### Association
- belong_to :user

## menus table

|Column|Type|Options|
|------|----|-------|
|name|string|

### Association
- has_many :foods

## menu_categories table

|Column|Type|Options|
|------|----|-------|
|name|string|

### Association
- has_many :foods

## foods table

|Column|Type|Options|
|------|----|-------|
|name|string|
|calorie|integer|null: false, |hiragana_name|string| 
|menu_id|integer|foreign_key: true|
|menu_category_id|integer|foreign_key: true|


### Association
- belongs_to :menu
- belongs_to :category_menu
- has_many :food_eatings

## food_eatings table

|Column|Type|Options|
|------|----|-------|
|food_id|integer|foreign_key: true|
|user_id|integer|foreign_key: true|

### Association
- belongs_to :food
- belongs_to :user
