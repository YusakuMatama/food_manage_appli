# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'csv'


CSV.foreach('db/menu_categories.csv', headers: true) do |row|
  MenuCategory.create(id: row['id'], name: row['name'])
end

CSV.foreach('db/menus.csv', headers: true) do |row|
  Menu.create(id: row['id'], name: row['name'])
end


CSV.foreach('db/foods.csv', headers: true) do |row|
  Food.create(id: row['id'], name: row['name'], hiragana_name: row['hiragana_name'], calorie: row['calorie'], menu_id: row['menu_id'], menu_category_id: row['menu_category_id'])
end

CSV.foreach('db/metabolisms.csv', headers: true) do |row|
  Metabolism.create(id: row['id'], age_base: row['age_base'], gender: row['gender'], base_metabolic_standard: row['base_metabolic_standard'], base_weight: row['base_weight'], base_metabolic_rate: row['base_metabolic_rate'])
end

