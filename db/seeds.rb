# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

require 'factory_girl'

Article.destroy_all
User.destroy_all

user = FactoryGirl.create(:user)
articles = FactoryGirl.create_list(:article, 50, content: FFaker::Name.name * 100, author: user)
