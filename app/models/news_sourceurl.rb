# == Schema Information
# Schema version: 20160310132348
#
# Table name: news_sourceurls
#
#  id          :uuid             not null, primary key
#  description :string
#  source_url  :string
#  created_at  :datetime
#  updated_at  :datetime
#

class NewsSourceurl < ActiveRecord::Base
  has_many :news, class_name: "News"
end
